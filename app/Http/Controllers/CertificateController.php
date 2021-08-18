<?php

namespace App\Http\Controllers;

use App\Constants\AssetConsts;
use App\Constants\AuthConsts;
use App\Constants\CertificateConsts;
use App\Constants\MailConsts;
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

        $active_id = Parameter::getParameterByKey(CertificateConsts::CERTIFICATE_ACTIVE)->id;
        $inactive_id = Parameter::getParameterByKey(CertificateConsts::CERTIFICATE_INACTIVE)->id;
        $signature_id = Parameter::getParameterByKey(CertificateConsts::CERTIFICATE_SIGNATURE_PROCESS)->id;

        $certificates = Certificate::whereIn("id_status", [$active_id, $inactive_id, $signature_id])
            ->where(function ($query) use ($user_id) {
                $query->where("id_receiver_user", $user_id)
                    ->orWhere("id_deliver_user", $user_id);
            })
            ->with(["getDeliverUser", "getReceiverUser", "getStatus"])
            ->get();

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
        $certificate->delivered_at = date("Y-m-d");
        $certificate->save();

        LogController::store($request, CertificateConsts::CERTIFICATE_APP_KEY, CertificateConsts::CERTIFICATE_LOG_STORE_SUCCESS, $certificate->id);

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
     * Formulario de edición de un acta
     */
    public function edit($id)
    {
        $params = $this->getFormParams();
        $certificate = Certificate::getCertificate($id);

        if ($certificate) {
            $certificate->getCertificateDetails;
            $certificate->getCreatorUser;
            $certificate->getApproverUser;
            $certificate->getReceiverUser;
            $certificate->getReceiverUser->getPosition;
            $certificate->getReceiverArea;
            $certificate->getDeliverUser;
            $certificate->getDeliverArea;
            $certificate->getStatus;

            foreach ($certificate->getCertificateDetails as $item) {
                $item->getPhysicalStatus;
                $item->files = Attachment::getAttachments(CertificateConsts::CERTIFICATE_APP_KEY, $item->id);
            }

            $params["certificate"] = $certificate;
            $params["company_info"] = Parameter::getCompanyInfo();

            return response()->json($params);
        } else {
            return response()->json(['status' => false, 'message' => CertificateConsts::CERTIFICATE_MESSAGE_GET_ERROR], 400);
        }
    }

    /**
     * Actualiza un acta
     */
    public function update(Request $request, $id)
    {
        $inputs = $request->all();

        $status_id = Parameter::getParameterByKey(CertificateConsts::CERTIFICATE_IN_PROCESS)->id;

        $certificate = Certificate::find($id);
        $certificate->update($inputs);
        $certificate->id_status = $status_id;
        $certificate->update();

        $certificate = Certificate::getCertificate($id);

        LogController::store($request, CertificateConsts::CERTIFICATE_APP_KEY, CertificateConsts::CERTIFICATE_LOG_UPDATE_SUCCESS, $certificate->id);

        return response()->json(["certificate" => $certificate]);
    }

    /**
     * Realiza el registro del cambio de estado en el log
     * @param Request $request
     * @param number $id Número del acta
     */
    private function statusChangeLog($request, $id)
    {
        $certificate = Certificate::getCertificate($id);

        LogController::store(
            $request,
            CertificateConsts::CERTIFICATE_APP_KEY,
            CertificateConsts::CERTIFICATE_LOG_UPDATE_STATUS_SUCCESS . " - " . $certificate->getStatus->str_val,
            $certificate->id
        );

        return response()->json(['status' => false, 'message' => CertificateConsts::CERTIFICATE_MESSAGE_UPDATE_STATUS_SUCCESS, "certificate" => $certificate]);
    }

    /**
     * Envía un acta a revisión por parte de un aprobador
     */
    public function setStatusChecking(Request $request, $id)
    {
        $status_id = Parameter::getParameterByKey(CertificateConsts::CERTIFICATE_CHECKING)->id;

        $certificate = Certificate::find($id);
        $certificate->id_status = $status_id;
        $certificate->update();

        return $this->statusChangeLog($request, $id);
    }

    /**
     * Acta rechazada por un aprobador
     */
    public function setStatusRejected(Request $request, $id)
    {
        $status_id = Parameter::getParameterByKey(CertificateConsts::CERTIFICATE_REJECTED)->id;

        $certificate = Certificate::find($id);
        $certificate->id_status = $status_id;
        $certificate->update();

        return $this->statusChangeLog($request, $id);
    }

    /**
     * Acta aprobada por un aprobador
     */
    public function setStatusApproved(Request $request, $id)
    {
        $status_id = Parameter::getParameterByKey(CertificateConsts::CERTIFICATE_APPROVED)->id;

        $certificate = Certificate::find($id);
        $certificate->id_approver_user = $request->user->id;
        $certificate->id_status = $status_id;
        $certificate->approved_at = date('Y-m-d H:i:s');
        $certificate->update();

        $id_certificate = str_pad($certificate->id, 6, "0", STR_PAD_LEFT);

        $params = [
            "app_key" => CertificateConsts::CERTIFICATE_APP_KEY,
            "address" => [["email" => $certificate->getCreatorUser->email, "name" => $certificate->getCreatorUser->display_name]],
            "cc" => [["email" => $certificate->getApproverUser->email, "name" => $certificate->getApproverUser->display_name]],
            "subject" => ["id_certificate" => $id_certificate],
            "body" => ["id_certificate" => $id_certificate, "approver_name" => $certificate->getApproverUser->display_name, "approved_at" => $certificate->approved_at],
        ];

        MailController::sendEmailByTemplate($params, MailConsts::EMAIL_TEMPLATE_CERTIFICATE_APPROVED);

        return $this->statusChangeLog($request, $id);
    }

    /**
     * Envía un acta a firmar por parte del responsable
     */
    public function setStatusSendSign(Request $request, $id)
    {
        $status_id = Parameter::getParameterByKey(CertificateConsts::CERTIFICATE_SIGNATURE_PROCESS)->id;

        $certificate = Certificate::find($id);
        $certificate->id_status = $status_id;
        $certificate->update();

        $id_certificate = str_pad($certificate->id, 6, "0", STR_PAD_LEFT);

        $params = [
            "app_key" => CertificateConsts::CERTIFICATE_APP_KEY,
            "address" => [["email" => $certificate->getReceiverUser->email, "name" => $certificate->getReceiverUser->display_name]],
            "subject" => ["id_certificate" => $id_certificate],
            "body" => ["id_certificate" => $id_certificate],
        ];

        MailController::sendEmailByTemplate($params, MailConsts::EMAIL_TEMPLATE_CERTIFICATE_SIGNATURE_PENDING);

        return $this->statusChangeLog($request, $id);
    }

    /**
     * Firmar el recibido de un acta de movimiento
     */
    public function setStatusActive(Request $request, $id)
    {
        $status_id = Parameter::getParameterByKey(CertificateConsts::CERTIFICATE_ACTIVE)->id;

        $certificate = Certificate::find($id);
        $certificate->id_status = $status_id;
        $certificate->update();

        $id_certificate = str_pad($certificate->id, 6, "0", STR_PAD_LEFT);

        $params = [
            "app_key" => CertificateConsts::CERTIFICATE_APP_KEY,
            "address" => [
                ["email" => $certificate->getDeliverUser->email, "name" => $certificate->getDeliverUser->display_name],
                ["email" => $certificate->getCreatorUser->email, "name" => $certificate->getCreatorUser->display_name],
            ],
            "subject" => ["id_certificate" => $id_certificate],
            "body" => ["id_certificate" => $id_certificate, "name" => $certificate->getReceiverUser->display_name],
        ];

        MailController::sendEmailByTemplate($params, MailConsts::EMAIL_TEMPLATE_CERTIFICATE_ACTIVE);

        return $this->statusChangeLog($request, $id);
    }

    /**
     * Inactiva un acta de movimiento
     */
    public function setStatusInactive(Request $request, $id)
    {
        $status_id = Parameter::getParameterByKey(CertificateConsts::CERTIFICATE_INACTIVE)->id;

        $certificate = Certificate::find($id);
        $certificate->id_status = $status_id;
        $certificate->update();

        return $this->statusChangeLog($request, $id);
    }

    /**
     * Anula un acta de movimiento
     */
    public function setStatusCancel(Request $request, $id)
    {
        $status_id = Parameter::getParameterByKey(CertificateConsts::CERTIFICATE_CANCELLED)->id;

        $certificate = Certificate::find($id);
        $certificate->id_status = $status_id;
        $certificate->update();

        return $this->statusChangeLog($request, $id);
    }
}
