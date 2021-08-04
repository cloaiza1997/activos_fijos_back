<?php

namespace App\Http\Controllers;

use App\Constants\AssetConsts;
use App\Constants\AuthConsts;
use App\Constants\GeneralConsts;
use App\Models\Parameter;
use App\Models\Provider;
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
        $users = User::where('id_status', Parameter::getParameterByKey(AuthConsts::AUTH_USER_STATUS_ACTIVE)->id)->get();
        $providers = Provider::where('is_active', 1)->get();
        $cities = Parameter::getCitiesByDepartment()["departments_cities"];
        $payment_methods = Parameter::getPaymentMethods();
        $asset_amount = Parameter::getParameterByKey(AssetConsts::ASSET_AMOUNT)->num_val;
        $iva = Parameter::getParameterByKey(GeneralConsts::IVA)->num_val;

        return response()->json([
            "users" => $users,
            "providers" => $providers,
            "cities" => $cities,
            "payment_methods" => $payment_methods,
            "asset_amount" => $asset_amount * 1,
            "iva" => $iva * 1,
        ]);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //
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
