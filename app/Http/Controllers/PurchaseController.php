<?php

namespace App\Http\Controllers;

use App\Constants\AssetConsts;
use App\Constants\AuthConsts;
use App\Constants\GeneralConsts;
use App\Constants\PurchaseConsts;
use App\Models\Parameter;
use App\Models\Provider;
use App\Models\Purchase;
use App\Models\PurchaseItem;
use App\Models\User;
use Illuminate\Http\Request;

/**
 * @class PurchaseController
 * @namespace App\Http\Controllers
 * @brief Controlador para la gestión de compras
 * @date 01/06/2021
 * @author Cristian Loaiza <cris-1997-loaiza@hotmail.com>
 */
class PurchaseController extends Controller
{
    private function getFormParams()
    {
        $users = User::where('id_status', Parameter::getParameterByKey(AuthConsts::AUTH_USER_STATUS_ACTIVE)->id)->get();
        $providers = Provider::where('is_active', 1)->get();
        $cities = Parameter::getCitiesByDepartment()["departments_cities"];
        $payment_methods = Parameter::getPaymentMethods();
        $asset_amount = Parameter::getParameterByKey(AssetConsts::ASSET_AMOUNT)->num_val;
        $iva = Parameter::getParameterByKey(GeneralConsts::IVA)->num_val;

        return [
            "users" => $users,
            "providers" => $providers,
            "cities" => $cities,
            "payment_methods" => $payment_methods,
            "asset_amount" => $asset_amount * 1,
            "iva" => $iva * 1,
        ];
    }
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
    }

    /**
     * Consulta los datos necesarios para el formulario de creación de órdenes de compra
     */
    public function create()
    {
        return response()->json($this->getFormParams());
    }

    /**
     * Genera una orden de compra
     */
    public function store(Request $request)
    {
        $inputs = $request->all();

        $purchase = new Purchase($inputs);
        $purchase->id_status = Parameter::getParameterByKey(PurchaseConsts::PURCHASE_STATUS_IN_PROCESS)->id;
        $purchase->id_creator_user = $request->user->id;
        $purchase->id_updater_user = $request->user->id;
        $purchase->save();

        foreach ($inputs["items"] as $item) {
            $item["id_purchase"] = $purchase->id;

            $purchase_item = new PurchaseItem($item);
            $purchase_item->save();
        }

        LogController::store($request, PurchaseConsts::PURCHASE_APP_KEY, PurchaseConsts::PURCHASE_MESSAGE_STORE_LOG, $purchase->id);

        $purchase = Purchase::getPurchase($purchase->id);

        return response()->json([
            'status' => true,
            'message' => PurchaseConsts::PURCHASE_MESSAGE_STORE_SUCCESS,
            'purchase' => $purchase
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
     * Consulta la orden de compra a editar
     */
    public function edit($id)
    {
        $params = $this->getFormParams();
        $purchase = Purchase::getPurchase($id);

        if (
            $purchase && ($purchase->status->parameter_key === PurchaseConsts::PURCHASE_STATUS_IN_PROCESS || $purchase->status->parameter_key === PurchaseConsts::PURCHASE_STATUS_APPROVED)
        ) {
            $params["purchase"] = $purchase;
        } else {
            $params["purchase"] = null;
        }

        if ($params["purchase"]) {
            return response()->json($params);
        } else {
            return response()->json(['status' => false, 'message' => PurchaseConsts::PURCHASE_MESSAGE_EDIT_ERROR], 400);
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

        $purchase = Purchase::find($id);
        $purchase->id_updater_user = $request->user->id;
        $purchase->update($inputs);

        PurchaseItem::where("id_purchase", $id)->delete();

        foreach ($inputs["items"] as $item) {
            $item["id_purchase"] = $purchase->id;

            $purchase_item = new PurchaseItem($item);
            $purchase_item->save();
        }

        LogController::store($request, PurchaseConsts::PURCHASE_APP_KEY, PurchaseConsts::PURCHASE_MESSAGE_UPDATE_LOG, $purchase->id);

        $purchase = Purchase::getPurchase($id);

        return response()->json([
            'status' => true,
            'message' => PurchaseConsts::PURCHASE_MESSAGE_UPDATE_SUCCESS,
            'purchase' => $purchase
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
