<?php

namespace App\Http\Controllers;

use App\Constants\AssetConsts;
use App\Constants\RevaluationConsts;
use App\Models\Asset;
use App\Models\DeprecationRevaluation;
use App\Models\DeprecationRevaluationDetail;
use App\Models\Parameter;
use App\Models\User;
use Illuminate\Http\Request;

/**
 * @class RevaluationController
 * @namespace App\Http\Controllers
 * @brief Controlador de los procesos de revaluación
 * @date 01/06/2021
 * @author Cristian Loaiza <cris-1997-loaiza@hotmail.com>
 */
class RevaluationController extends Controller
{
    /**
     * Listado de revaluaciones
     */
    public function index()
    {
        $revaluation_process_id = Parameter::getParameterByKey(AssetConsts::ASSET_REVALUATION)->id;


        $revaluations = DeprecationRevaluation::where("id_action_type", $revaluation_process_id)->with(["getUser", "getStatus"])->get();

        return response()->json(["revaluations" => $revaluations]);
    }

    /**
     * Crea un proceso de revaluación
     */
    public function store(Request $request)
    {
        $inputs = $request->all();

        $revaluation_process_id = Parameter::getParameterByKey(AssetConsts::ASSET_REVALUATION)->id;
        $status_id = Parameter::getParameterByKey(AssetConsts::ASSET_UPDATE_COST_IN_PROCESS)->id;

        $revaluation = new DeprecationRevaluation($inputs);
        $revaluation->id_action_type = $revaluation_process_id;
        $revaluation->id_user = User::getAuthUserId();
        $revaluation->id_status = $status_id;
        $revaluation->save();

        LogController::store($request, RevaluationConsts::REVALUATION_APP_KEY, RevaluationConsts::REVALUATION_MESSAGE_STORE_LOG, $revaluation->id);

        return response()->json([
            'status' => true,
            'message' => RevaluationConsts::REVALUATION_MESSAGE_STORE_SUCCESS,
            'revaluation' => $revaluation
        ], 200);
    }

    /**
     * Consulta el formulario de edición de una revaluación
     */
    public function edit($id)
    {
        $revaluation = DeprecationRevaluation::getDepreRevalCanReverse($id);
        $revaluation->getDetails;
        $revaluation->getUser;
        $revaluation->getStatus;
        $revaluation->getChildren;

        $asset_decommissioned_id = Parameter::getParameterByKey(AssetConsts::ASSET_DECOMMISSIONED)->id;
        $assets = Asset::where("id_status", "!=", $asset_decommissioned_id)->with(["getBrand", "getStatus"])->get();

        return response()->json(["revaluation" => $revaluation, "assets" => $assets]);
    }

    /**
     * Actualiza un proceso de revaluación
     */
    public function update(Request $request, $id)
    {
        $inputs = $request->all();

        $revaluation = DeprecationRevaluation::find($id);
        $revaluation->update($inputs);

        DeprecationRevaluationDetail::where("id_depre_reval", $id)->delete();

        DeprecationRevaluationDetail::insert($inputs["details"]);

        $revaluation->getDetails;
        $revaluation->getUser;
        $revaluation->getStatus;

        LogController::store($request, RevaluationConsts::REVALUATION_APP_KEY, RevaluationConsts::REVALUATION_MESSAGE_UPDATE_LOG, $revaluation->id);

        return response()->json([
            'status' => true,
            'message' => RevaluationConsts::REVALUATION_MESSAGE_UPDATE_SUCCESS,
            'revaluation' => $revaluation
        ], 200);
    }

    /**
     * Realiza el registro del cambio de estado en el log
     * @param Request $request
     * @param number $id Número de la revaluación
     */
    private function statusChangeLog($request, $revaluation)
    {
        $revaluation->getDetails;
        $revaluation->getUser;
        $revaluation->getStatus;

        LogController::store($request, RevaluationConsts::REVALUATION_APP_KEY, RevaluationConsts::REVALUATION_MESSAGE_UPDATE_STATUS_LOG . " - " . $revaluation->getStatus->str_val, $revaluation->id);

        return response()->json([
            'status' => true,
            'message' => RevaluationConsts::REVALUATION_MESSAGE_UPDATE_STATUS_SUCCESS,
            'revaluation' => $revaluation
        ], 200);
    }

    /**
     * Cancela una revaluación
     */
    public function setStatusCancel(Request $request, $id)
    {
        $status_id = Parameter::getParameterByKey(AssetConsts::ASSET_UPDATE_COST_CANCELLED)->id;

        $revaluation = DeprecationRevaluation::getDepreRevalCanReverse($id);
        $revaluation->id_status = $status_id;
        $revaluation->update();

        return $this->statusChangeLog($request, $revaluation);
    }

    /**
     * Actualiza el estado de un proceso de revaluación como ejecutado
     */
    public function setStatusExecute(Request $request, $id)
    {
        $status_id = Parameter::getParameterByKey(AssetConsts::ASSET_UPDATE_COST_EXECUTED)->id;

        $revaluation = DeprecationRevaluation::find($id);
        $revaluation->id_status = $status_id;
        $revaluation->update();

        foreach ($revaluation->getDetails as $detail) {
            $asset = Asset::find($detail->id_asset);
            $asset->current_value = $detail->new_value;
            $asset->update();
        }

        $revaluation = DeprecationRevaluation::getDepreRevalCanReverse($id);

        return $this->statusChangeLog($request, $revaluation);
    }

    /**
     * Realiza un proceso de reversa de revaluación
     */
    public function setStatusReverse(Request $request, $id)
    {
        $reversed_status_id = Parameter::getParameterByKey(AssetConsts::ASSET_UPDATE_COST_REVERSED)->id;
        $executed_status_id = Parameter::getParameterByKey(AssetConsts::ASSET_UPDATE_COST_EXECUTED)->id;

        $revaluation = DeprecationRevaluation::find($id);
        $revaluation->id_status = $reversed_status_id;
        $revaluation->update();

        LogController::store($request, RevaluationConsts::REVALUATION_APP_KEY, RevaluationConsts::REVALUATION_MESSAGE_UPDATE_STATUS_LOG . " - " . $revaluation->getStatus->str_val, $revaluation->id);

        $observations = RevaluationConsts::REVALUATION_OBSERVATION_REVERSE . " - " . $revaluation->id;

        $new_revaluation = new DeprecationRevaluation();
        $new_revaluation->id_action_type = $revaluation->id_action_type;
        $new_revaluation->id_user = User::getAuthUserId();
        $new_revaluation->observations = $observations;
        $new_revaluation->id_status = $executed_status_id;
        $new_revaluation->id_parent = $revaluation->id;
        $new_revaluation->save();

        LogController::store($request, RevaluationConsts::REVALUATION_APP_KEY, $observations, $new_revaluation->id);

        foreach ($revaluation->getDetails as $detail) {
            $revaluation_detail = new DeprecationRevaluationDetail();
            $revaluation_detail->id_depre_reval = $new_revaluation->id;
            $revaluation_detail->id_asset = $detail->id_asset;
            $revaluation_detail->old_value = $detail->new_value;
            $revaluation_detail->new_value = $detail->old_value;
            $revaluation_detail->id_parent = $detail->id;
            $revaluation_detail->observations = RevaluationConsts::REVALUATION_OBSERVATION_REVERSE_DETAIL . " - " . $detail->id;
            $revaluation_detail->save();

            $asset = Asset::find($revaluation_detail->id_asset);
            $asset->current_value = $revaluation_detail->new_value;
            $asset->update();
        }

        $revaluation->getDetails;
        $revaluation->getUser;
        $revaluation->getStatus;
        $revaluation->getChildren;

        return response()->json([
            'status' => true,
            'message' => RevaluationConsts::REVALUATION_MESSAGE_UPDATE_STATUS_SUCCESS,
            'revaluation' => $revaluation
        ], 200);
    }
}
