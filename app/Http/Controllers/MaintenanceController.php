<?php

namespace App\Http\Controllers;

use App\Constants\AssetConsts;
use App\Constants\AuthConsts;
use App\Constants\MaintenanceConsts;
use App\Models\Asset;
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
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
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
