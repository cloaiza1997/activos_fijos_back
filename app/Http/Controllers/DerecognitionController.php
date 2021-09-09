<?php

namespace App\Http\Controllers;

use App\Constants\AssetConsts;
use App\Constants\DerecognitionConsts;
use App\Constants\MailConsts;
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

    public function indexApprover()
    {
        $approved_status_id = Parameter::getParameterByKey(DerecognitionConsts::DERECOGNITION_CHECKING)->id;

        $derecognitions = Derecognition::where("id_status", $approved_status_id)->with(["getStatus", "getCreatorUser", "getApproverUser"])->get();

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
            $derecognition->getDetails;;
            $derecognition->getStatus;
            $derecognition->getCreatorUser;
            $derecognition->getApproverUser;

            foreach ($derecognition->getDetails as $detail) {
                $detail->getAsset;
                $detail->getReason;
            }
        }

        $derecognition_reason_id = Parameter::getParameterByKey(DerecognitionConsts::DERECOGNITION_REASONS)->id;
        $derecognition_reasons = Parameter::where("id_parent", $derecognition_reason_id)->where("is_active", 1)->get();

        $asset_decommissioned_id = Parameter::getParameterByKey(AssetConsts::ASSET_DECOMMISSIONED)->id;
        $assets = Asset::where("id_status", "!=", $asset_decommissioned_id)->with(["getBrand", "getStatus"])->get();
        $all_assets = Asset::with(["getBrand", "getStatus"])->get();

        $company_info = Parameter::getCompanyInfo();

        return response()->json([
            "assets" => $assets,
            "all_assets" => $all_assets,
            "derecognition_reasons" => $derecognition_reasons,
            "derecognition" => $derecognition,
            "company_info" => $company_info,
        ]);
    }

    public function update(Request $request, $id)
    {
        $inputs = $request->all();

        $statud_id_in_process = Parameter::getParameterByKey(DerecognitionConsts::DERECOGNITION_IN_PROCESS)->id;

        $derecognition = Derecognition::find($id);
        $derecognition->id_status = $statud_id_in_process;
        $derecognition->observations = $inputs["observations"];
        $derecognition->id_approver_user = null;
        $derecognition->approved_at = null;
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

    private function changeStatusLog(Request $request, $id, $key)
    {
        $status_id = Parameter::getParameterByKey($key)->id;

        $derecognition = Derecognition::find($id);
        $derecognition->id_status = $status_id;
        $derecognition->update();

        LogController::store(
            $request,
            DerecognitionConsts::DERECOGNITION_APP_KEY,
            DerecognitionConsts::DERECOGNITION_UPDATE_STATUS_LOG . " - " . $derecognition->getStatus->str_val,
            $derecognition->id
        );

        return $derecognition;
    }

    private function getResponseUpdateStatus($derecognition)
    {
        return response()->json([
            'status' => true,
            'message' => DerecognitionConsts::DERECOGNITION_UPDATE_STATUS_SUCCESS,
            'derecognition' => $derecognition
        ], 200);
    }

    public function setStatusChecking(Request $request, $id)
    {
        $derecognition = $this->changeStatusLog($request, $id, DerecognitionConsts::DERECOGNITION_CHECKING);

        return $this->getResponseUpdateStatus($derecognition);
    }

    public function setStatusCancel(Request $request, $id)
    {
        $derecognition = $this->changeStatusLog($request, $id, DerecognitionConsts::DERECOGNITION_CANCELLED);

        return $this->getResponseUpdateStatus($derecognition);
    }

    public function setStatusRejected(Request $request, $id)
    {
        $derecognition = $this->changeStatusLog($request, $id, DerecognitionConsts::DERECOGNITION_REJECTED);

        return $this->getResponseUpdateStatus($derecognition);
    }

    public function setStatusApproved(Request $request, $id)
    {
        $derecognition = $this->changeStatusLog($request, $id, DerecognitionConsts::DERECOGNITION_APPROVED);

        $derecognition->id_approver_user = $request->user->id;
        $derecognition->approved_at = date('Y-m-d H:i:s');
        $derecognition->update();

        $params = [
            "app_key" => DerecognitionConsts::DERECOGNITION_APP_KEY,
            "address" => [["email" => $derecognition->getCreatorUser->email, "name" => $derecognition->getCreatorUser->display_name]],
            "cc" => [["email" => $derecognition->getApproverUser->email, "name" => $derecognition->getApproverUser->display_name]],
            "subject" => ["id_derecognition" => $derecognition->id],
            "body" => ["id_derecognition" => $derecognition->id, "approver_name" => $derecognition->getApproverUser->display_name, "approved_at" => $derecognition->approved_at],
        ];

        MailController::sendEmailByTemplate($params, MailConsts::EMAIL_TEMPLATE_DERECOGNITIOIN_APPROVED);

        return $this->getResponseUpdateStatus($derecognition);
    }

    public function setStatusExecuted(Request $request, $id)
    {
        $derecognition = $this->changeStatusLog($request, $id, DerecognitionConsts::DERECOGNITION_EXECUTED);

        $status_id = Parameter::getParameterByKey(AssetConsts::ASSET_DECOMMISSIONED)->id;

        foreach ($derecognition->getDetails as $detail) {
            $asset = Asset::find($detail->id_asset);
            $asset->id_status = $status_id;
            $asset->update();
        }

        return $this->getResponseUpdateStatus($derecognition);
    }

    public function setStatusReverse(Request $request, $id)
    {
        $derecognition = $this->changeStatusLog($request, $id, DerecognitionConsts::DERECOGNITION_REVERSED);

        $status_id = Parameter::getParameterByKey(AssetConsts::ASSET_UNASSIGNED)->id;

        foreach ($derecognition->getDetails as $detail) {
            $asset = Asset::find($detail->id_asset);
            $asset->id_status = $status_id;
            $asset->update();
        }

        return $this->getResponseUpdateStatus($derecognition);
    }
}
