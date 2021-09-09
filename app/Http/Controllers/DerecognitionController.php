<?php

namespace App\Http\Controllers;

use App\Constants\AssetConsts;
use App\Constants\DerecognitionConsts;
use App\Models\Asset;
use App\Models\Derecognition;
use App\Models\DerecognitionDetail;
use App\Models\Parameter;
use App\Models\User;
use Illuminate\Http\Request;

/**
 * @class DerecognitionController
 * @namespace App\Http\Controllers
 * @brief Controlador de bajas
 * @date 01/06/2021
 * @author Cristian Loaiza <cris-1997-loaiza@hotmail.com>
 */
class DerecognitionController extends Controller
{

    public function index()
    {
        $derecognitions = Derecognition::with(["getStatus", "getCreatorUser", "getApproverUser"])->get();

        return response()->json(["derecognitions" => $derecognitions]);
    }

    public function store(Request $request)
    {
        $inputs = $request->all();

        $statud_id_in_process = Parameter::getParameterByKey(DerecognitionConsts::DERECOGNITION_IN_PROCESS)->id;

        $derecognition = new Derecognition($inputs);
        $derecognition->id_status = $statud_id_in_process;
        $derecognition->id_creator_user = User::getAuthUserId();
        $derecognition->save();

        LogController::store($request, DerecognitionConsts::DERECOGNITION_APP_KEY, DerecognitionConsts::DERECOGNITION_MESSAGE_STORE_LOG, $derecognition->id);

        return response()->json([
            'status' => true,
            'message' => DerecognitionConsts::DERECOGNITION_MESSAGE_STORE_SUCCESS,
            'derecognition' => $derecognition
        ], 200);
    }

    public function edit($id)
    {
        $derecognition = Derecognition::find($id);

        if ($derecognition) {
            $derecognition->getDetails;
            $derecognition->getStatus;
            $derecognition->getCreatorUser;
            $derecognition->getApproverUser;
        }

        $derecognition_reason_id = Parameter::getParameterByKey(DerecognitionConsts::DERECOGNITION_REASONS)->id;
        $derecognition_reasons = Parameter::where("id_parent", $derecognition_reason_id)->where("is_active", 1)->get();

        $asset_decommissioned_id = Parameter::getParameterByKey(AssetConsts::ASSET_DECOMMISSIONED)->id;
        $assets = Asset::where("id_status", "!=", $asset_decommissioned_id)->with(["getBrand", "getStatus"])->get();

        return response()->json([
            "assets" => $assets,
            "derecognition_reasons" => $derecognition_reasons,
            "derecognition" => $derecognition
        ]);
    }

    public function update(Request $request, $id)
    {
        $inputs = $request->all();

        $derecognition = Derecognition::find($id);
        $derecognition->observations = $inputs["observations"];
        $derecognition->id_approver_user = null;
        $derecognition->approvated_at = null;
        $derecognition->update();

        DerecognitionDetail::where("id_derecognition", $id)->delete();

        foreach ($inputs["get_details"] as $item) {
            $item["id_derecognition"] = $derecognition->id;

            $purchase_item = new DerecognitionDetail($item);
            $purchase_item->save();
        }

        LogController::store($request, DerecognitionConsts::DERECOGNITION_APP_KEY, DerecognitionConsts::DERECOGNITION_MESSAGE_UPDATE_LOG, $derecognition->id);

        $derecognition->getDetails;
        $derecognition->getStatus;
        $derecognition->getCreatorUser;
        $derecognition->getApproverUser;

        return response()->json([
            'status' => true,
            'message' => DerecognitionConsts::DERECOGNITION_MESSAGE_UPDATE_SUCCESS,
            'derecognition' => $derecognition
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
