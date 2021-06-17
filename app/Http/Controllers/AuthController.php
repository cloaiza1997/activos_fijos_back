<?php

namespace App\Http\Controllers;

use App\Constants\AuthConsts;
use App\Http\Controllers\LogController;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
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
        $validator = Validator::make(
            $request->all(),
            [
                "email" => "required|email",
                "password" => "required"

            ],
            [
                "email.required" => AuthConsts::AUTH_LOGIN_VALIDATION_EMAIL_REQUIRED,
                "email.email" => AuthConsts::AUTH_LOGIN_VALIDATION_EMAIL_EMAIL,
                "password.required" => AuthConsts::AUTH_LOGIN_VALIDATION_PASSWORD_REQUIRED,
            ]
        );

        if ($validator->fails()) {

            return response()->json([
                "error" => $validator->errors()
            ], 422);
        }

        $credentials = $request->only('email', 'password');

        try {
            if (!$token = JWTAuth::attempt($credentials)) {
                return response()->json(['error' => AuthConsts::AUTH_LOGIN_VALIDATION_CREDENTIALS_FAIL], 400);
            }
        } catch (JWTException $e) {
            return response()->json(['error' => AuthConsts::AUTH_LOGIN_VALIDATION_CREDENTIALS_ERROR], 500);
        }

        LogController::store($request, AuthConsts::AUTH_APP_KEY, AuthConsts::AUTH_LOG_LOGIN);

        return response()->json([
            "status" => true,
            "token" => $token,
            "user" => User::getAuthUser()
        ]);
    }


    /**
     * Cierre de sesión
     *
     * @param Request $request
     * @return Object { message }
     */
    public function logout(Request $request)
    {
        LogController::store($request, AuthConsts::AUTH_APP_KEY, AuthConsts::AUTH_LOG_LOGOUT);

        Auth::logout();

        return response()->json(['message' => AuthConsts::AUTH_LOGOUT_MESSAGE]);
    }
}
