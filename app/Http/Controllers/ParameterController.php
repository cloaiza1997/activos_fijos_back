<?php

namespace App\Http\Controllers;

use App\Constants\ParameterConsts;
use App\Models\Parameter;
use Illuminate\Http\Request;

class ParameterController extends Controller
{
    public function index()
    {
        $parameters = Parameter::where("id_parent", null)
            ->where(function ($query) {
                $query->where("is_editable", 1)->orWhere("is_editable_details", 1);
            })->get();

        return response()->json(["parameters" => $parameters]);
    }

    public function indexDetail($id)
    {
        $parameter = Parameter::find($id);

        if ($parameter) {
            $parameters = Parameter::where("id_parent", $id)
                ->where(function ($query) {
                    $query->where("is_editable", 1)->orWhere("is_editable_details", 1);
                })->get();

            return response()->json(["parameter" => $parameter, "parameters" => $parameters]);
        } else {
            return response()->json(['status' => false, 'message' => ParameterConsts::PARAMETER_MESSAGE_LIST_ERROR], 400);
        }
    }

    public function store(Request $request)
    {
        $inputs = $request->all();

        $parameter = new Parameter($inputs);
        $parameter->is_editable = 1;
        $parameter->is_editable_details = 0;
        $parameter->save();

        LogController::store($request, ParameterConsts::PARAMETER_APP_KEY, ParameterConsts::PARAMETER_MESSAGE_STORE_LOG, $parameter->id);

        return response()->json([
            'status' => true,
            'message' => ParameterConsts::PARAMETER_MESSAGE_STORE_SUCCESS,
            "parameter" => $parameter
        ]);
    }

    public function edit($id)
    {
        $parameter = Parameter::find($id);

        if ($parameter) {
            return response()->json(["parameter" => $parameter]);
        } else {
            return response()->json(['status' => false, 'message' => ParameterConsts::PARAMETER_MESSAGE_LIST_ERROR], 400);
        }
    }

    public function update(Request $request, $id)
    {
        $inputs = $request->all();

        $parameter = Parameter::find($id);
        $parameter->update($inputs);

        LogController::store($request, ParameterConsts::PARAMETER_APP_KEY, ParameterConsts::PARAMETER_MESSAGE_UPDATE_LOG, $parameter->id);

        return response()->json([
            'status' => true,
            'message' => ParameterConsts::PARAMETER_MESSAGE_UPDATE_SUCCESS,
            "parameter" => $parameter
        ]);
    }
}
