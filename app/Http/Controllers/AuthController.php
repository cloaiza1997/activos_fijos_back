<?php

namespace App\Http\Controllers;

use App\Constants\AuthConsts;
use App\Constants\AuthConstsMessages;
use App\Constants\MailConsts;
use App\Helpers\FunctionsHelper;
use App\Http\Controllers\LogController;
use App\Models\Parameter;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Tymon\JWTAuth\Exceptions\JWTException;
use Tymon\JWTAuth\Facades\JWTAuth;

/**
 * @class AuthController
 * @namespace App\Http\Controllers
 * @brief Controlador de la autenticación
 * @date 01/06/2021
 * @author Cristian Loaiza <cris-1997-loaiza@hotmail.com>
 */
class AuthController extends Controller
{
    /**
     * Inicio de sesión
     *
     * @param Request $request
     * @return Object { status, token, user }
     */
    public function login(Request $request)
    {

        $fail = FunctionsHelper::validateRequest(
            $request,
            [
                "email" => "required|email",
                "password" => "required"
            ],
            [
                "email.required" => AuthConstsMessages::AUTH_LOGIN_VALIDATION_EMAIL_REQUIRED,
                "email.email" => AuthConstsMessages::AUTH_LOGIN_VALIDATION_EMAIL_EMAIL,
                "password.required" => AuthConstsMessages::AUTH_LOGIN_VALIDATION_PASSWORD_REQUIRED,
            ]
        );

        if ($fail) {
            return $fail;
        }

        $credentials = $request->only('email', 'password');

        try {
            if (!$token = JWTAuth::attempt($credentials)) {
                return response()->json(['status' => false, 'message' => AuthConstsMessages::AUTH_LOGIN_VALIDATION_CREDENTIALS_FAIL], 400);
            }

            $user = User::getAuthUser();

            $status_active = Parameter::getParameterByKey(AuthConsts::AUTH_USER_STATUS_ACTIVE);

            if ($user->id_status !== $status_active->id) {
                return response()->json(['status' => false, 'message' => AuthConstsMessages::AUTH_LOGIN_VALIDATION_STATUS], 400);
            }
        } catch (JWTException $e) {
            return response()->json(['status' => false, 'message' => AuthConstsMessages::AUTH_LOGIN_VALIDATION_CREDENTIALS_ERROR . " - " . $e->getMessage()], 500);
        }

        LogController::store($request, AuthConsts::AUTH_APP_KEY, AuthConstsMessages::AUTH_LOG_LOGIN);

        return response()->json([
            "status" => true,
            "token" => $token,
            "user" => $user
        ]);
    }

    /**
     * Cierre de sesión
     *
     * @param Request $request
     * @return Object { status, message }
     */
    public function logout(Request $request)
    {
        LogController::store($request, AuthConsts::AUTH_APP_KEY, AuthConstsMessages::AUTH_LOG_LOGOUT);

        Auth::logout();

        return response()->json(['status' => true, 'message' => AuthConstsMessages::AUTH_LOGOUT_MESSAGE]);
    }

    /**
     * Función de prueba de validación de autenticación
     *
     * @return Object { user } Usuario autenticado
     */
    public function testLogin()
    {
        return response()->json(["user" => User::getAuthUser()]);
    }

    /**
     * Recuperación de contraseña
     *
     * @param Request $request
     * @return Object { status, message }
     */
    public function recoveryPassword(Request $request)
    {
        $fail = FunctionsHelper::validateRequest(
            $request,
            [
                "email" => "required|email",
            ],
            [
                "email.required" => AuthConstsMessages::AUTH_RECOVERY_PASSWORD_EMAIL_REQUIRED,
                "email.email" => AuthConstsMessages::AUTH_RECOVERY_PASSWORD_EMAIL_EMAIL,
            ]
        );

        if ($fail) {
            return $fail;
        }

        $user = User::where("email", $request->input("email"))->first();
        $id_status_active = Parameter::getParameterByKey(AuthConsts::AUTH_USER_STATUS_ACTIVE)->id;

        $error_message = "";

        if (!$user) {
            $error_message = AuthConstsMessages::AUTH_RECOVERY_PASSWORD_USER_NO_EXISTS;
        } else if ($id_status_active !== $user->id_status) {
            $error_message = AuthConstsMessages::AUTH_RECOVERY_PASSWORD_USER_INACTIVE;
        }

        if ($error_message) {
            return response()->json(['status' => false, 'message' => $error_message], 400);
        }

        $new_password = FunctionsHelper::ramdomString(20);

        $user->password = bcrypt($new_password);
        $user->must_change_password = true;
        $user->save();

        $params = [
            "app_key" => AuthConsts::AUTH_APP_KEY,
            "address" => [["email" => $user->email, "name" => $user->name]],
            "body" => ["name" => $user->name, "password" => $new_password],
        ];

        $mail = MailController::sendEmailByTemplate($params, MailConsts::EMAIL_TEMPLATE_RECOVERY_PASSWORD_USER);

        if ($mail["status"]) {

            $request->id_user = $user->id;
            LogController::store($request, AuthConsts::AUTH_APP_KEY, AuthConstsMessages::AUTH_LOG_RECOVERY_PASSWORD);

            return response()->json(['status' => true, 'message' => AuthConstsMessages::AUTH_RECOVERY_PASSWORD_EMAIL_SEND], 200);
        } else {
            return response()->json(['status' => false, 'message' => AuthConstsMessages::AUTH_RECOVERY_PASSWORD_EMAIL_NO_SEND], 400);
        }
    }
}
