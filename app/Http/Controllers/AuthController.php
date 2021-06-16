<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Tymon\JWTAuth\Exceptions\JWTException;
use Tymon\JWTAuth\Facades\JWTAuth;

class AuthController extends Controller
{
    //
    public function login(Request $request)
    {
        // $validator = Validator::make(
        //     $request->all(),
        //     [
        //         "user" => "required|email",
        //         "password" => "required"

        //     ],
        //     [
        //         "user.required" => "Usuario es requerido",
        //         "user.email" => "Usuario debe de ser un email",
        //         "password.required" => "Contraseña es requerida",
        //     ]
        // );

        // if ($validator->fails()) {

        //     return response()->json([
        //         "error" => $validator->errors()
        //     ], 422);
        // }

        $credentials = $request->only('email', 'password');

        try {
            if (!$token = JWTAuth::attempt($credentials)) {
                return response()->json(['error' => 'invalid_credentials'], 400);
            }
        } catch (JWTException $e) {
            return response()->json(['error' => 'could_not_create_token'], 500);
        }

        return response()->json(compact('token'));
    }

    public function verify(Request $request)
    {
        dd($request->user->name);
    }

    public function logout()
    {
        Auth::logout();

        return response()->json(['message' => 'Successfully logged out']);
    }
}
