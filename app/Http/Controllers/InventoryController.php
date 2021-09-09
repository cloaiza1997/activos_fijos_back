<?php

namespace App\Http\Controllers;

use App\Constants\AssetConsts;
use App\Constants\InventoryConsts;
use App\Models\Asset;
use App\Models\Inventory;
use App\Models\InventoryDetail;
use App\Models\Parameter;
use App\Models\User;
use Illuminate\Http\Request;

/**
 * @class InventoryController
 * @namespace App\Http\Controllers
 * @brief Controlador de los inventarios
 * @date 01/06/2021
 * @author Cristian Loaiza <cris-1997-loaiza@hotmail.com>
 */
class InventoryController extends Controller
{
    public function index()
    {
        $inventories = Inventory::with(["getStatus", "getUser"])->get();

        return response()->json(["inventories" => $inventories]);
    }

    public function store(Request $request)
    {
        $inputs = $request->all();

        $statud_id_in_process = Parameter::getParameterByKey(InventoryConsts::INVENTORY_STATUS_IN_PROCESS)->id;

        $inventory = new Inventory($inputs);
        $inventory->id_status = $statud_id_in_process;
        $inventory->id_user = User::getAuthUserId();
        $inventory->save();

        LogController::store($request, InventoryConsts::INVENTORY_APP_KEY, InventoryConsts::INVENTORY_MESSAGE_STORE_LOG, $inventory->id);

        return response()->json([
            'status' => true,
            'message' => InventoryConsts::INVENTORY_MESSAGE_STORE_SUCCESS,
            'inventory' => $inventory
        ], 200);
    }

    public function edit($id)
    {
        $inventory = Inventory::find($id);
        $inventory->getStatus;
        $inventory->getUser;
        $inventory->getDetails;

        foreach ($inventory->getDetails as $detail) {
            $asset = Asset::getAsset($detail->id_asset);

            $detail->asset = $asset;
        }

        $asset_decommissioned_id = Parameter::getParameterByKey(AssetConsts::ASSET_DECOMMISSIONED)->id;
        $assets = Asset::where("id_status", "!=", $asset_decommissioned_id)->with(["getBrand", "getStatus"])->get();

        return response()->json([
            "inventory" => $inventory,
            "assets" => $assets
        ]);
    }

    public function storeInventoryDetail(Request $request)
    {
        $inputs = $request->all();

        $inventory_detail = InventoryDetail::where("id_inventory", $inputs["id_inventory"])->where("id_asset", $inputs["id_asset"])->first();

        if (!$inventory_detail) {
            $inventory_detail = new InventoryDetail($inputs);
            $inventory_detail->save();

            LogController::store($request, InventoryConsts::INVENTORY_APP_KEY, InventoryConsts::INVENTORY_MESSAGE_DETAIL_LOG . " " . $inventory_detail->id, $inputs["id_inventory"]);
        }

        $inventory = Inventory::find($inputs["id_inventory"]);
        $inventory->getStatus;
        $inventory->getUser;
        $inventory->getDetails;

        foreach ($inventory->getDetails as $detail) {
            $asset = Asset::getAsset($detail->id_asset);

            $detail->asset = $asset;
        }

        $asset_decommissioned_id = Parameter::getParameterByKey(AssetConsts::ASSET_DECOMMISSIONED)->id;
        $assets = Asset::where("id_status", "!=", $asset_decommissioned_id)->with(["getBrand", "getStatus"])->get();

        return response()->json([
            "inventory" => $inventory,
            "assets" => $assets
        ]);
    }

    public function update(Request $request, $id)
    {
        $inputs = $request->all();

        $inventory = Inventory::find($id);
        $inventory->observations = $inputs["observations"];
        $inventory->update();

        LogController::store($request, InventoryConsts::INVENTORY_APP_KEY, InventoryConsts::INVENTORY_MESSAGE_UPDATE_LOG, $inventory->id);

        return response()->json([
            'status' => true,
            'message' => InventoryConsts::INVENTORY_MESSAGE_UPDATE_SUCCESS,
            'inventory' => $inventory
        ], 200);
    }

    public function setStatusFinished(Request $request, $id)
    {
        $status_id_finished = Parameter::getParameterByKey(InventoryConsts::INVENTORY_STATUS_FINISHED)->id;

        $inventory = Inventory::find($id);
        $inventory->id_status = $status_id_finished;
        $inventory->update();

        $inventory->getStatus;

        LogController::store($request, InventoryConsts::INVENTORY_APP_KEY, InventoryConsts::INVENTORY_MESSAGE_FINISHED_LOG, $inventory->id);

        return response()->json([
            'status' => true,
            'message' => InventoryConsts::INVENTORY_MESSAGE_FINISHED_SUCCESS,
            'inventory' => $inventory
        ], 200);
    }
}
