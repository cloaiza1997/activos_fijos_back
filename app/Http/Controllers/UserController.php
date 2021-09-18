<?php

namespace App\Http\Controllers;

use App\Constants\AuthConsts;
use App\Constants\MailConsts;
use App\Constants\RegexConsts;
use App\Constants\UserConsts;
use App\Helpers\FunctionsHelper;
use App\Models\Parameter;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

/**
 * @class UserController
 * @namespace App\Http\Controllers
 * @brief Controlador para la gestión de usuarios
 * @date 01/06/2021
 * @author Cristian Loaiza <cris-1997-loaiza@hotmail.com>
 */
class UserController extends Controller
{
    private function getFormData()
    {
        $document_types_id = Parameter::getParameterByKey(UserConsts::DOCUMENT_TYPE)->id;
        $document_types = Parameter::where("id_parent", $document_types_id)->where("is_active", 1)->get();

        $company_areas_id = Parameter::getParameterByKey(UserConsts::COMPANY_AREAS)->id;
        $company_areas = Parameter::where("id_parent", $company_areas_id)->where("is_active", 1)->get();

        $company_positions_id = Parameter::getParameterByKey(UserConsts::COMPANY_POSITIONS)->id;
        $company_positions = Parameter::where("id_parent", $company_positions_id)->where("is_active", 1)->get();

        $roles_id = Parameter::getParameterByKey(UserConsts::USER_ROLE)->id;
        $roles = Parameter::where("id_parent", $roles_id)->where("is_active", 1)->get();

        $status_id = Parameter::getParameterByKey(UserConsts::USER_STATUS)->id;
        $status = Parameter::where("id_parent", $status_id)->where("is_active", 1)->get();

        return [
            "document_types" => $document_types,
            "company_areas" => $company_areas,
            "company_positions" => $company_positions,
            "roles" => $roles,
            "status" => $status,
        ];
    }

    private function generatePassword($id)
    {
        $new_password = FunctionsHelper::ramdomString(20);

        $user = User::find($id);
        $user->password = bcrypt($new_password);
        $user->must_change_password = true;
        $user->save();

        $params = [
            "app_key" => UserConsts::USER_APP_KEY,
            "address" => [["email" => $user->email, "name" => $user->name]],
            "body" => ["name" => $user->name, "password" => $new_password],
        ];

        $mail = MailController::sendEmailByTemplate($params, MailConsts::EMAIL_TEMPLATE_USER_PASSWORD);
    }

    public function updatePassword(Request $request)
    {
        $password_regex = RegexConsts::REGEX_PASSWORD;

        $fail = FunctionsHelper::validateRequest(
            $request,
            [
                "password" => ["required", "regex:$password_regex", "same:password_confirm"],
                "password_confirm" =>  ["required", "regex:$password_regex", "same:password"]
            ],
            [
                "password.required" => UserConsts::USER_REQUEST_PASSWORD_REQUIRED,
                "password.same" => UserConsts::USER_REQUEST_PASSWORD_SAME,
                "password.regex" => UserConsts::USER_REQUEST_PASSWORD_REGEX,
                "password_confirm.required" => UserConsts::USER_REQUEST_PASSWORD_CONFIRM_REQUIRED,
                "password_confirm.same" => UserConsts::USER_REQUEST_PASSWORD_SAME,
                "password_confirm.regex" => UserConsts::USER_REQUEST_PASSWORD_REGEX,
            ]
        );

        if ($fail) {
            return $fail;
        }

        $inputs = $request->all();
        $user_id = Auth::user()->id;

        $user = User::find($user_id);
        $user->password = bcrypt($inputs["password"]);
        $user->must_change_password = 0;
        $user->save();

        LogController::store($request, UserConsts::USER_APP_KEY, UserConsts::USER_LOG_UPDATE_PASSWORD);

        return response()->json(['status' => true, 'message' => UserConsts::USER_UPDATE_PASSWORD_SUCCESS], 200);
    }

    public function index()
    {
        $users = User::where("id", "!=", 1)->with(["getDocumentType", "getStatus", "getRole"])->orderBy("name")->get();

        return response()->json(["users" => $users]);
    }

    public function create()
    {
        $params = $this->getFormData();

        return response()->json($params);
    }

    public function store(Request $request)
    {
        $fail = FunctionsHelper::validateRequest(
            $request,
            [
                "document_number" => "unique:users,document_number",
                "email" => "unique:users,email",
            ],
            [
                "document_number.unique" => UserConsts::USER_REQUEST_DOCUMENT_NUMBER_UNIQUE,
                "email.unique" => UserConsts::USER_REQUEST_EMAIL_UNIQUE,
            ]
        );

        if ($fail) {
            return $fail;
        }

        $inputs = $request->all();

        $status_id = Parameter::getParameterByKey(AuthConsts::AUTH_USER_STATUS_ACTIVE)->id;

        $user = new User($inputs);
        $user->display_name = $user->name . " " . $user->last_name;
        $user->id_status = $status_id;
        $user->save();

        $this->generatePassword($user->id);

        LogController::store($request, UserConsts::USER_APP_KEY, UserConsts::USER_MESSAGE_STORE_LOG, $user->id);

        return response()->json([
            'status' => true,
            'message' => UserConsts::USER_MESSAGE_STORE_SUCCESS,
            "user" => $user
        ]);
    }
}
