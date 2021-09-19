<?php

namespace App\Http\Controllers;

use App\Constants\ProviderConsts;
use App\Constants\UserConsts;
use App\Models\Parameter;
use App\Models\Provider;
use Illuminate\Http\Request;

/**
 * @class ProviderController
 * @namespace App\Http\Controllers
 * @brief Controlador para la gestión de proveedores
 * @date 01/06/2021
 * @author Cristian Loaiza <cris-1997-loaiza@hotmail.com>
 */
class ProviderController extends Controller
{
    private function getFormData()
    {

        $cities = Parameter::getCitiesByDepartment()["departments_cities"];

        $document_types_id = Parameter::getParameterByKey(UserConsts::DOCUMENT_TYPE)->id;
        $document_types = Parameter::where("id_parent", $document_types_id)->where("is_active", 1)->get();

        return ["cities" => $cities, "document_types" => $document_types];
    }

    public function index()
    {
        $providers = Provider::with(["getDocumentType", "getCity"])->get();

        return response()->json(["providers" => $providers]);
    }

    public function create()
    {
        return response()->json($this->getFormData());
    }

    public function store(Request $request)
    {
        $inputs = $request->all();

        $provider = new Provider($inputs);
        $provider->is_active = 1;
        $provider->save();

        LogController::store($request, ProviderConsts::PROVIDER_APP_KEY, ProviderConsts::PROVIDER_MESSAGE_STORE_LOG, $provider->id);

        return response()->json([
            'status' => true,
            'message' => ProviderConsts::PROVIDER_MESSAGE_STORE_SUCCESS,
            "provider" => $provider
        ]);
    }

    public function edit($id)
    {
        $provider = Provider::find($id);

        if ($provider) {

            $params = $this->getFormData();
            $params["provider"] = $provider;

            return response()->json($params);
        } else {
            return response()->json(['status' => false, 'message' => ProviderConsts::PROVIDER_MESSAGE_EDIT_ERROR], 400);
        }
    }

    public function update(Request $request, $id)
    {
        $inputs = $request->all();

        $provider = Provider::find($id);
        $provider->update($inputs);

        LogController::store($request, ProviderConsts::PROVIDER_APP_KEY, ProviderConsts::PROVIDER_MESSAGE_UPDATE_LOG, $provider->id);

        return response()->json([
            'status' => true,
            'message' => ProviderConsts::PROVIDER_MESSAGE_UPDATE_SUCCESS,
            "provider" => $provider
        ]);
    }
}
