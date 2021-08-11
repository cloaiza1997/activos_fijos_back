<?php

namespace App\Http\Controllers;

use App\Constants\AssetConsts;
use App\Constants\PurchaseConsts;
use App\Models\Asset;
use App\Models\Attachment;
use App\Models\Parameter;
use App\Models\Purchase;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

/**
 * @class AssetController
 * @namespace App\Http\Controllers
 * @brief Controlador para la gestión de activos
 * @date 01/06/2021
 * @author Cristian Loaiza <cris-1997-loaiza@hotmail.com>
 */
class AssetController extends Controller
{
    /**
     * Consulta de elementos para los formularios de creación y edición
     */
    private function getFormParams()
    {
        $asset_group_id = Parameter::getParameterByKey(AssetConsts::ASSET_GROUP)->id;
        $asset_groups = Parameter::where("id_parent", $asset_group_id)->where("is_active", 1)->get(["id", "parameter_key", "str_val as name"]);

        $asset_types = DB::select("SELECT id, id_parent, str_val AS name
        FROM parameters
        WHERE id_parent IN (
            SELECT id
            FROM parameters
            WHERE parameter_key IN (
                SELECT parameter_key
                FROM parameters 
                WHERE id_parent =  $asset_group_id
                AND is_active = 1
            )
        )
        ORDER BY id_parent, name");

        $asset_brands = Parameter::where("id_parent", Parameter::getParameterByKey(AssetConsts::ASSET_BRAND)->id)->where("is_active", 1)->get(["id", "str_val as name"]);

        $asset_main_freq = Parameter::where("id_parent", Parameter::getParameterByKey(AssetConsts::ASSET_MAINTENANCE_FREQUENCE)->id)->where("is_active", 1)->orderBy("num_val")->get(["id", "parameter_key", "str_val as name", "num_val as freq"]);

        return [
            "asset_groups" => $asset_groups,
            "asset_types" => $asset_types,
            "asset_brands" => $asset_brands,
            "asset_main_freq" => $asset_main_freq,
        ];
    }

    /**
     * Consulta las órdenes de compra las cuales están finalizadas
     */
    public function getPurchaseFinished()
    {
        $purchases = Purchase::getPurchaseListByStatus(PurchaseConsts::PURCHASE_STATUS_FINISHED, false);

        foreach ($purchases as $purchase) {
            $purchase->items = DB::select("SELECT * 
            FROM purch_items 
            WHERE id_purchase = $purchase->id 
            AND id NOT IN (
                SELECT id_purchase_item 
                FROM assets 
                WHERE id_purchase_item IS NOT NULL 
                GROUP BY id_purchase_item
            )");
        }

        return response()->json(["purchases" => $purchases]);
    }

    /**
     * Consulta el listado de activos
     */
    public function index()
    {
        $assets = Asset::getAssetList();

        return response()->json(["assets" => $assets]);
    }

    /**
     * Consulta los listados requeridos para el formulario de creación
     */
    public function create()
    {
        return $this->getFormParams();
    }

    /**
     * Creación de activo
     */
    public function store(Request $request)
    {
        $inputs = $request->all();

        $asset = new Asset($inputs);
        $asset->id_status = Parameter::getParameterByKey(AssetConsts::ASSET_UNASSIGNED)->id;
        $asset->save();
        $asset->asset_number = str_pad($asset->id_asset_group, 3, "0", STR_PAD_LEFT) . "-" . str_pad($asset->id_asset_type, 3, "0", STR_PAD_LEFT) . "-" .  str_pad($asset->id, 6, "0", STR_PAD_LEFT);
        $asset->update();

        LogController::store($request, AssetConsts::ASSET_APP_KEY, AssetConsts::ASSET_MESSAGE_STORE_LOG . " - " . $asset->asset_number, $asset->id);

        return response()->json([
            'status' => true,
            'message' => AssetConsts::ASSET_MESSAGE_STORE_SUCCESS . $asset->asset_number,
            'asset' => $asset
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
     * Consulta el formulario de edición
     */
    public function edit($id)
    {
        $params = $this->getFormParams();
        $asset = Asset::getAsset($id);

        if ($asset) {
            $asset->files = Attachment::getAttachments(AssetConsts::ASSET_APP_KEY, $asset->id);

            $params["asset"] = $asset;

            return response()->json($params);
        } else {
            return response()->json(['status' => false, 'message' => AssetConsts::ASSET_MESSAGE_EDIT_ERROR], 400);
        }
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
        $inputs = $request->all();

        $asset = Asset::find($id);
        $asset->update($inputs);

        LogController::store($request, AssetConsts::ASSET_APP_KEY, AssetConsts::ASSET_MESSAGE_UPDATE_LOG . " - " . $asset->asset_number, $asset->id);

        $asset = Asset::getAsset($id);

        return response()->json([
            'status' => true,
            'message' => AssetConsts::ASSET_MESSAGE_UPDATE_SUCCESS,
            'asset' => $asset
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
