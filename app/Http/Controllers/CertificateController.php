<?php

namespace App\Http\Controllers;

use App\Constants\AssetConsts;
use App\Constants\AuthConsts;
use App\Constants\CertificateConsts;
use App\Models\Asset;
use App\Models\Attachment;
use App\Models\Certificate;
use App\Models\CertificateDetail;
use App\Models\Parameter;
use App\Models\User;
use Illuminate\Http\Request;

class CertificateController extends Controller
{

    private function getFormParams()
    {
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
     * Listado principal de actas
     */
    public function index()
    {
        $certificates = Certificate::with(["getDeliverUser", "getReceiverUser", "getStatus"])->get();

        return response()->json(["certificates" => $certificates]);
    }

    /**
     * Listado de actas pendientes de aprobación
     */
    public function indexApprover()
    {
        $status_id = Parameter::getParameterByKey(CertificateConsts::CERTIFICATE_CHECKING)->id;

        $certificates = Certificate::where("id_status", $status_id)->with(["getDeliverUser", "getReceiverUser"])->get();

        return response()->json(["certificates" => $certificates]);
    }

    /**
     * Listado de actas propias de un usuario
     */
    public function indexResponsible()
    {
        $user_id = User::getAuthUserId();

        $certificates = Certificate::where("id_receiver_user", $user_id)->orWhere("id_deliver_user", $user_id)->with(["getDeliverUser", "getReceiverUser", "getStatus"])->get();

        return response()->json(["certificates" => $certificates]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        $params = $this->getFormParams();

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

        LogController::store($request, CertificateConsts::CERTIFICATE_APP_KEY, CertificateConsts::CERTIFICATE_MESSAGE_STORE_SUCCESS, $certificate->id);

        return response()->json(["certificate" => $certificate]);
    }

    /**
     * Agrega un item al acta creada debido a que cada ítem puede tener adjuntos por lo cual se envían por separado
     */
    public function storeItem(Request $request)
    {
        $inputs = $request->all();

        if (isset($inputs["id"])) {
            $certi_detail = CertificateDetail::find($inputs["id"]);
            $certi_detail->update($inputs);
        } else {
            $certi_detail = new CertificateDetail($inputs);
            $certi_detail->save();
        }

        $attachment = new AttachmentController();

        $certi_detail = CertificateDetail::find($certi_detail->id);
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
        $params = $this->getFormParams();
        $certificate = Certificate::find($id);

        if ($certificate) {
            $certificate->getCertificateDetails;

            foreach ($certificate->getCertificateDetails as $item) {
                $item->files = Attachment::getAttachments(CertificateConsts::CERTIFICATE_APP_KEY, $item->id);
            }

            $params["certificate"] = $certificate;

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

        $certificate = Certificate::find($id);
        $certificate->update($inputs);

        LogController::store($request, CertificateConsts::CERTIFICATE_APP_KEY, CertificateConsts::CERTIFICATE_MESSAGE_UPDATE_SUCCESS, $certificate->id);

        return response()->json(["certificate" => $certificate]);
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
