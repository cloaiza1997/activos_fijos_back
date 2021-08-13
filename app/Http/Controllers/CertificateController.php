<?php

namespace App\Http\Controllers;

use App\Constants\AssetConsts;
use App\Constants\AuthConsts;
use App\Constants\CertificateConsts;
use App\Models\Asset;
use App\Models\Certificate;
use App\Models\CertificateDetail;
use App\Models\Parameter;
use App\Models\User;
use Illuminate\Http\Request;

class CertificateController extends Controller
{

    private function getFormData()
    {
        $admin_id = Parameter::getParameterByKey(AuthConsts::USER_ROLE_ADMIN)->id;
        $active_status_id = Parameter::getParameterByKey(AuthConsts::AUTH_USER_STATUS_ACTIVE)->id;

        $users = User::where("id_status", $active_status_id)->get();

        $areas = Parameter::getCompanyAreas();

        $physical_status_id = Parameter::getParameterByKey(CertificateConsts::CERTIFICATES_ASSET_STATUS)->id;
        $physical_status = Parameter::where("id_parent", $physical_status_id)->where("is_active", 1)->get(["id", "str_val as name"]);

        $asset_decommissioned_id = Parameter::getParameterByKey(AssetConsts::ASSET_DECOMMISSIONED)->id;
        $assets = Asset::where("id_status", "!=", $asset_decommissioned_id)->with(["getBrand"])->get();

        return [
            "users" => $users,
            "areas" => $areas,
            "physical_status" => $physical_status,
            "assets" => $assets
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
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        $params = $this->getFormData();

        return response()->json($params);
    }

    /**
     * Crea un acta de movimiento
     */
    public function store(Request $request)
    {
        $inputs = $request->all();

        $certificate = new Certificate($inputs);
        $certificate->id_creator_user = User::getAuthUserId();
        $certificate->id_status = Parameter::getParameterByKey(CertificateConsts::CERTIFICATE_IN_PROCESS)->id;
        $certificate->save();

        return response()->json(["certificate" => $certificate]);
    }

    /**
     * Agrega un item al acta creada debido a que cada ítem puede tener adjuntos por lo cual se envían por separado
     */
    public function storeItem(Request $request)
    {
        $inputs = $request->all();

        $certi_detail = new CertificateDetail($inputs);
        $certi_detail->save();

        $attachment = new AttachmentController();

        $certi_detail->files = $attachment->uploadFiles($request, CertificateConsts::CERTIFICATE_APP_KEY, $certi_detail->id, false);

        return response()->json(["certi_detail" => $certi_detail]);
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
