<?php

namespace App\Http\Controllers;

use App\Constants\AssetConsts;
use App\Constants\AuthConsts;
use App\Constants\GeneralConsts;
use App\Constants\MailConsts;
use App\Constants\PurchaseConsts;
use App\Models\Attachment;
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
        $company_info = Parameter::getCompnayInfo();
        $asset_amount = Parameter::getParameterByKey(AssetConsts::ASSET_AMOUNT)->num_val;
        $iva = Parameter::getParameterByKey(GeneralConsts::IVA)->num_val;

        return [
            "company_info" => $company_info,
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
            $purchase && ($purchase->status->parameter_key != PurchaseConsts::PURCHASE_STATUS_CANCELLED)
        ) {
            $purchase->files = Attachment::getAttachments(PurchaseConsts::PURCHASE_APP_KEY, $purchase->id);

            $params["purchase"] = $purchase;

            return response()->json($params);
        } else {
            return response()->json(['status' => false, 'message' => PurchaseConsts::PURCHASE_MESSAGE_EDIT_ERROR], 400);
        }
    }

    /**
     * Actualiza una orden de compra
     */
    public function update(Request $request, $id)
    {
        $inputs = $request->all();
        $inputs["id_status"] = Parameter::getParameterByKey(PurchaseConsts::PURCHASE_STATUS_IN_PROCESS)->id;
        $inputs["id_updater_user"] = $request->user->id;

        $purchase = Purchase::find($id);
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

    public function updateStatus(Request $request, $id)
    {
        $inputs = $request->all();
        $approved = false;
        $new_status = Parameter::getParameterByKey($inputs["status"]);

        $purchase = Purchase::find($id);
        $purchase->id_status = $new_status->id;

        if ($new_status->parameter_key == PurchaseConsts::PURCHASE_STATUS_APPROVED) {
            $purchase->id_approver_user = $request->user->id;
            $purchase->approved_at = date('Y-m-d H:i:s');
            $approved = true;
        }

        $purchase->update();

        if ($approved) {
            $id_order = str_pad($purchase->id, 8, "0", STR_PAD_LEFT);

            $params = [
                "app_key" => PurchaseConsts::PURCHASE_APP_KEY,
                "address" => [["email" => $purchase->getCreatorUser->email, "name" => $purchase->getCreatorUser->display_name]],
                "cc" => [["email" => $purchase->getApproverUser->email, "name" => $purchase->getApproverUser->display_name]],
                "subject" => ["id_order" => $id_order],
                "body" => ["id_order" => $id_order, "approver_name" => $purchase->getApproverUser->display_name, "approved_at" => $purchase->approved_at],
            ];

            MailController::sendEmailByTemplate($params, MailConsts::EMAIL_TEMPLATE_PURCHASE_APPROVED);
        }

        LogController::store($request, PurchaseConsts::PURCHASE_APP_KEY, PurchaseConsts::PURCHASE_MESSAGE_UPDATE_STATUS_LOG . " - " . $new_status->str_val, $purchase->id);

        $purchase = Purchase::getPurchase($id);

        return response()->json([
            'status' => true,
            'message' => PurchaseConsts::PURCHASE_MESSAGE_UPDATE_STATUS_SUCCESS,
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
