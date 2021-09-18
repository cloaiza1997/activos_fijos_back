<?php

namespace App\Http\Controllers;

use App\Constants\AssetConsts;
use App\Constants\AuthConsts;
use App\Constants\MaintenanceConsts;
use App\Models\Asset;
use App\Models\Attachment;
use App\Models\Maintenance;
use App\Models\MaintenanceDetail;
use App\Models\MaintenanceResponsible;
use App\Models\Provider;
use App\Models\Parameter;
use App\Models\User;
use Illuminate\Http\Request;

/**
 * @class MaintenanceController
 * @namespace App\Http\Controllers
 * @brief Controlador para la gestión de mantenimientos
 * @date 01/06/2021
 * @author Cristian Loaiza <cris-1997-loaiza@hotmail.com>
 */
class MaintenanceController extends Controller
{

    private function getFormData()
    {
        $maintenance_type_id = Parameter::getParameterByKey(MaintenanceConsts::MAINTENANCE_TYPE)->id;
        $maintenance_types = Parameter::where("id_parent", $maintenance_type_id)->where("is_active", 1)->get();

        $providers = Provider::where("is_active", 1)->get();

        $active_status_id = Parameter::getParameterByKey(AuthConsts::AUTH_USER_STATUS_ACTIVE)->id;
        $users = User::where("id_status", $active_status_id)->get();

        $asset_decommissioned_id = Parameter::getParameterByKey(AssetConsts::ASSET_DECOMMISSIONED)->id;
        $assets = Asset::where("id_status", "!=", $asset_decommissioned_id)->with(["getBrand", "getStatus", "getMaintenanceFrequence"])->get();

        return ["maintenance_types" => $maintenance_types, "providers" => $providers, "users" => $users, "assets" => $assets];
    }

    private function getEditForm($maintenance)
    {
        $maintenance->files = Attachment::getAttachments(MaintenanceConsts::MAINTENANCE_APP_KEY, $maintenance->id);
        $maintenance->getDetails;
        $maintenance->getStatus;
        $maintenance->getResponsibles;
        $maintenance->getUser;

        foreach ($maintenance->getDetails as $detail) {
            $asset = Asset::find($detail->id_asset);
            $asset->getMaintenanceFrequence;

            $detail->asset = $asset;
        }

        $params = $this->getFormData();

        $params["maintenance"] = $maintenance;

        return $params;
    }

    public function index()
    {
        $maintenances = Maintenance::with(["getUser", "getStatus", "getType"])->get();

        return response()->json(["maintenances" => $maintenances]);
    }

    public function create()
    {
        return response()->json($this->getFormData());
    }

    public function store(Request $request)
    {
        $inputs = $request->all();

        $status_id = Parameter::getParameterByKey(MaintenanceConsts::MAINTENANCE_IN_PROCESS)->id;

        $maintenance = new Maintenance($inputs);
        $maintenance->id_status = $status_id;
        $maintenance->id_user = User::getAuthUserId();
        $maintenance->save();

        foreach ($inputs["get_responsibles"] as $responsible) {
            $maintenance_responsible = new MaintenanceResponsible($responsible);
            $maintenance_responsible->id_maintenance = $maintenance->id;
            $maintenance_responsible->save();
        }

        foreach ($inputs["get_details"] as $detail) {
            $maintenance_detail = new MaintenanceDetail($detail);
            $maintenance_detail->id_maintenance = $maintenance->id;
            $maintenance_detail->save();
        }

        LogController::store($request, MaintenanceConsts::MAINTENANCE_APP_KEY, MaintenanceConsts::MAINTENANCE_MESSAGE_STORE_SUCCESS, $maintenance->id);

        return response()->json([
            'status' => true,
            'message' => MaintenanceConsts::MAINTENANCE_MESSAGE_STORE_SUCCESS,
            "maintenance" => $maintenance
        ]);
    }

    public function edit($id)
    {
        $maintenance = Maintenance::find($id);

        if ($maintenance) {
            return response()->json($this->getEditForm($maintenance));
        } else {
            return response()->json(['status' => false, 'message' => MaintenanceConsts::MAINTENANCE_MESSAGE_EDIT_ERROR], 400);
        }
    }

    public function update(Request $request, $id)
    {
        $inputs = $request->all();

        $status_id = Parameter::getParameterByKey(MaintenanceConsts::MAINTENANCE_IN_PROCESS)->id;

        $maintenance = Maintenance::find($id);
        $maintenance->id_status = $inputs["id_status"];
        $maintenance->id_status = $status_id;
        $maintenance->observations = $inputs["observations"];
        $maintenance->update();

        MaintenanceDetail::where("id_maintenance", $id)->delete();
        MaintenanceResponsible::where("id_maintenance", $id)->delete();

        foreach ($inputs["get_responsibles"] as $responsible) {
            $responsible["id"] = null;
            $responsible["created_at"] = null;
            $responsible["updated_at"] = null;

            $maintenance_responsible = new MaintenanceResponsible($responsible);
            $maintenance_responsible->id_maintenance = $maintenance->id;
            $maintenance_responsible->save();
        }

        foreach ($inputs["get_details"] as $detail) {
            $detail["id"] = null;

            $maintenance_detail = new MaintenanceDetail($detail);
            $maintenance_detail->id_maintenance = $maintenance->id;
            $maintenance_detail->save();
        }

        LogController::store($request, MaintenanceConsts::MAINTENANCE_APP_KEY, MaintenanceConsts::MAINTENANCE_MESSAGE_UPDATE_SUCCESS, $maintenance->id);

        return response()->json([
            'status' => true,
            'message' => MaintenanceConsts::MAINTENANCE_MESSAGE_UPDATE_SUCCESS,
            "maintenance" => $maintenance
        ]);
    }

    public function setStatusCancel(Request $request, $id)
    {
        $status_id = Parameter::getParameterByKey(MaintenanceConsts::MAINTENANCE_CANCELLED)->id;

        $maintenance = Maintenance::find($id);
        $maintenance->id_status = $status_id;
        $maintenance->update();

        LogController::store($request, MaintenanceConsts::MAINTENANCE_APP_KEY, MaintenanceConsts::MAINTENANCE_MESSAGE_UPDATE_STATUS_LOG .  $maintenance->getStatus->str_val, $maintenance->id);

        $params = $this->getEditForm($maintenance);
        $params["status"] = true;
        $params["message"] =  MaintenanceConsts::MAINTENANCE_MESSAGE_UPDATE_STATUS_SUCCESS;
        $params["maintenance"] = $maintenance;

        return response()->json($params);
    }

    public function setStatusFinished(Request $request, $id)
    {
        $status_id = Parameter::getParameterByKey(MaintenanceConsts::MAINTENANCE_FINISHED)->id;

        $maintenance = Maintenance::find($id);
        $maintenance->id_status = $status_id;
        $maintenance->update();

        LogController::store($request, MaintenanceConsts::MAINTENANCE_APP_KEY, MaintenanceConsts::MAINTENANCE_MESSAGE_UPDATE_STATUS_LOG .  $maintenance->getStatus->str_val, $maintenance->id);

        foreach ($maintenance->getDetails as $detail) {
            $asset = Asset::find($detail->id_asset);
            $asset->maintenance_date = $detail->executed_at;
            $asset->update();
        }

        $params = $this->getEditForm($maintenance);
        $params["status"] = true;
        $params["message"] =  MaintenanceConsts::MAINTENANCE_MESSAGE_UPDATE_STATUS_SUCCESS;
        $params["maintenance"] = $maintenance;

        return response()->json($params);
    }
}
