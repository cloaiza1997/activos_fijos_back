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
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
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
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Consulta el formulario de edición de una revaluación
     */
    public function edit($id)
    {
        $revaluation = DeprecationRevaluation::find($id);
        $revaluation->getDetails;
        $revaluation->getUser;
        $revaluation->getStatus;

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
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }
}
