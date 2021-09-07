<?php

namespace App\Http\Controllers;

use App\Constants\AssetConsts;
use App\Constants\DeprecationConsts;
use App\Models\Asset;
use App\Models\DeprecationRevaluation;
use App\Models\DeprecationRevaluationDetail;
use App\Models\Parameter;
use App\Models\User;
use DateTime;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

/**
 * @class DeprecationController
 * @namespace App\Http\Controllers
 * @brief Controlador para procesos de depreciación de activos
 * @date 01/06/2021
 * @author Cristian Loaiza <cris-1997-loaiza@hotmail.com>
 */
class DeprecationController extends Controller
{
    public function index()
    {
        $deprecation_process_id = Parameter::getParameterByKey(AssetConsts::ASSET_DEPRECIATION)->id;

        $deprecations = DeprecationRevaluation::where("id_action_type", $deprecation_process_id)->with(["getUser", "getStatus"])->get();

        return response()->json(["deprecations" => $deprecations]);
    }

    public function store(Request $request)
    {
        $inputs = $request->all();

        $deprecation_process_id = Parameter::getParameterByKey(AssetConsts::ASSET_DEPRECIATION)->id;
        $status_id_in_process = Parameter::getParameterByKey(AssetConsts::ASSET_UPDATE_COST_IN_PROCESS)->id;
        $status_id_executed = Parameter::getParameterByKey(AssetConsts::ASSET_UPDATE_COST_EXECUTED)->id;

        $deprecation = new DeprecationRevaluation($inputs);
        $deprecation->id_action_type = $deprecation_process_id;
        $deprecation->id_user = User::getAuthUserId();
        $deprecation->id_status = $status_id_in_process;
        $deprecation->save();

        $status_id_assignet = Parameter::getParameterByKey(AssetConsts::ASSET_ASSIGNED)->id;
        $status_id_unassigned = Parameter::getParameterByKey(AssetConsts::ASSET_UNASSIGNED)->id;
        $status_id_depre_executed = Parameter::getParameterByKey(AssetConsts::ASSET_UPDATE_COST_EXECUTED)->id;
        $status_id_depre_reversed = Parameter::getParameterByKey(AssetConsts::ASSET_UPDATE_COST_REVERSED)->id;

        $assets = Asset::whereIn("id_status", [$status_id_assignet, $status_id_unassigned])->get();

        $created_at = new DateTime(date("Y-m-d", strtotime($deprecation->created_at)));
        // $created_at = new DateTime("2027-12-30");

        foreach ($assets as $asset) {
            $depre_reval = DB::select("SELECT a.id, a.id_depre_reval, a.id_asset, a.id_parent, a.old_value, a.new_value, b.id_action_type, DATE_FORMAT(b.updated_at, '%Y-%m-%d') updated_at
            FROM depre_reval_details AS a, depreciation_revaluation AS b
            WHERE a.id_depre_reval = b.id
            AND b.id_status IN ($status_id_depre_executed, $status_id_depre_reversed)
            AND a.id_asset = $asset->id");

            $entry_date =  new DateTime($asset->entry_date);
            $current_value = $asset->current_value;
            $residual_value = $asset->residual_value;

            $diff_days_entry_date = $entry_date->diff($created_at)->days;
            $diff_years_entry_date = $diff_days_entry_date / 365;

            $lenght = count($depre_reval);

            if ($lenght) {
                $updated_ad = new DateTime($depre_reval[$lenght - 1]->updated_at);
                // $updated_ad = new DateTime("2026-12-30");

                $diff_days_last_depre = $diff_days_entry_date - $updated_ad->diff($entry_date)->days;
            } else {
                $diff_days_last_depre = 0;
            }

            $use_life_years = $asset->use_life - $diff_years_entry_date;
            $use_life_days = $use_life_years * 365 + $diff_days_last_depre;

            $depre_daily = $use_life_days == 0 ? 0 : ($current_value - $residual_value) / $use_life_days;

            $new_value = $current_value - $depre_daily * $diff_days_last_depre;

            $depre_reval_detail = new DeprecationRevaluationDetail();
            $depre_reval_detail->id_depre_reval = $deprecation->id;
            $depre_reval_detail->id_asset = $asset->id;
            $depre_reval_detail->old_value = $current_value;
            $depre_reval_detail->new_value = $new_value;
            $depre_reval_detail->save();

            $asset->current_value = $new_value;
            $asset->update();

            // echo ("<br/> created_ad <br/>");
            // echo (date_format($created_at, "Y-m-d"));
            // echo ("<br/> diff_days_entry_date <br/>");
            // echo ($diff_days_entry_date);
            // echo ("<br/> diff_days_last_depre <br/>");
            // echo ($diff_days_last_depre);
            // echo ("<br/> diff_years_entry_date <br/>");
            // echo ($diff_years_entry_date);
            // echo ("<br/> cost <br/>");
            // echo ($current_value);
            // echo ("<br/> resi <br/>");
            // echo ($residual_value);
            // echo ("<br/> use_life_years <br/>");
            // echo ($use_life_years);
            // echo ("<br/> use_life_days <br/>");
            // echo ($use_life_days);
            // echo ("<br/> depre_daily <br/>");
            // echo ($depre_daily);
            // echo ("<br/> new_value <br/>");
            // echo ($new_value);

            // echo ($current_value);
            // echo "<br/>";
            // echo ($new_value);
            // echo "<br/>";
            // echo ($use_life_days);
            // echo "<br/>";
            // echo ($use_life_years);
            // echo "<br/>";
            // echo ($diff_days_entry_date);
            // echo "<br/>";
            // echo ($diff_years_entry_date);
            // echo "<br/>";
            // echo ($diff_days_last_depre);
            // echo "<br/>";
        }

        $deprecation->id_status = $status_id_executed;
        $deprecation->update();

        LogController::store($request, DeprecationConsts::DEPRECATION_APP_KEY, DeprecationConsts::DEPRECATION_MESSAGE_STORE_LOG, $deprecation->id);

        return response()->json([
            'status' => true,
            'message' => DeprecationConsts::DEPRECATION_MESSAGE_STORE_SUCCESS,
            'deprecation' => $deprecation
        ], 200);
    }

    public function edit($id)
    {
        $deprecation = DeprecationRevaluation::getDepreRevalCanReverse($id);

        if ($deprecation) {
            $deprecation->getDetails;
            $deprecation->getUser;
            $deprecation->getStatus;
            $deprecation->getChildren;

            foreach ($deprecation->getDetails as $detail) {
                $asset = Asset::getAsset($detail->id_asset);

                $detail->asset = $asset;
            }

            return response()->json(["deprecation" => $deprecation]);
        } else {
            return response()->json(['status' => false, 'message' => DeprecationConsts::DEPRECATION_MESSAGE_EDIT_ERROR], 400);
        }
    }

    /**
     * Realiza un proceso de reversa de revaluación
     */
    public function setStatusReverse(Request $request, $id)
    {
        $reversed_status_id = Parameter::getParameterByKey(AssetConsts::ASSET_UPDATE_COST_REVERSED)->id;
        $executed_status_id = Parameter::getParameterByKey(AssetConsts::ASSET_UPDATE_COST_EXECUTED)->id;

        $deprecation = DeprecationRevaluation::find($id);
        $deprecation->id_status = $reversed_status_id;
        $deprecation->update();

        LogController::store($request, DeprecationConsts::DEPRECATION_APP_KEY, DeprecationConsts::DEPRECATION_MESSAGE_UPDATE_STATUS_LOG . " - " . $deprecation->getStatus->str_val, $deprecation->id);

        $observations = DeprecationConsts::DEPRECATION_OBSERVATION_REVERSE . " - " . $deprecation->id;

        $new_deprecation = new DeprecationRevaluation();
        $new_deprecation->id_action_type = $deprecation->id_action_type;
        $new_deprecation->id_user = User::getAuthUserId();
        $new_deprecation->observations = $observations;
        $new_deprecation->id_status = $executed_status_id;
        $new_deprecation->id_parent = $deprecation->id;
        $new_deprecation->save();

        LogController::store($request, DeprecationConsts::DEPRECATION_APP_KEY, $observations, $new_deprecation->id);

        foreach ($deprecation->getDetails as $detail) {
            $deprecation_detail = new DeprecationRevaluationDetail();
            $deprecation_detail->id_depre_reval = $new_deprecation->id;
            $deprecation_detail->id_asset = $detail->id_asset;
            $deprecation_detail->old_value = $detail->new_value;
            $deprecation_detail->new_value = $detail->old_value;
            $deprecation_detail->id_parent = $detail->id;
            $deprecation_detail->observations = DeprecationConsts::DEPRECATION_OBSERVATION_REVERSE_DETAIL . " - " . $detail->id;
            $deprecation_detail->save();

            $asset = Asset::find($deprecation_detail->id_asset);
            $asset->current_value = $deprecation_detail->new_value;
            $asset->update();
        }

        $deprecation->getDetails;
        $deprecation->getUser;
        $deprecation->getStatus;
        $deprecation->getChildren;

        foreach ($deprecation->getDetails as $detail) {
            $asset = Asset::getAsset($detail->id_asset);

            $detail->asset = $asset;
        }

        return response()->json([
            'status' => true,
            'message' => DeprecationConsts::DEPRECATION_MESSAGE_UPDATE_STATUS_SUCCESS,
            'deprecation' => $deprecation
        ], 200);
    }
}
