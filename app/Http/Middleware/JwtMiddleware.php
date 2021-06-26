<?php

namespace App\Http\Middleware;

use App\Constants\AuthConsts;
use App\Constants\AuthConstsMessages;
use App\Http\Controllers\LogController;
use App\Models\Parameter;
use Closure;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Tymon\JWTAuth\Facades\JWTAuth;

class JwtMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle(Request $request, Closure $next)
    {
        try {
            $request->user = JWTAuth::parseToken()->authenticate();
            $status_active = Parameter::getParameterByKey(AuthConsts::AUTH_USER_STATUS_ACTIVE);

            if ($request->user->id_status !== $status_active->id) {
                LogController::store($request, AuthConsts::AUTH_APP_KEY, AuthConstsMessages::AUTH_LOGOUT_MESSAGE_INVALID_USER);

                Auth::logout();

                return response()->json(['status' => false, 'message' => AuthConstsMessages::AUTH_LOGOUT_MESSAGE_INVALID_USER], 401);
            }
        } catch (Exception $e) {
            $status = "";

            if ($e instanceof \Tymon\JWTAuth\Exceptions\TokenInvalidException) {
                $status = AuthConstsMessages::AUTH_USER_TOKEN_INVALID;
            } else if ($e instanceof \Tymon\JWTAuth\Exceptions\TokenExpiredException) {
                $status = AuthConstsMessages::AUTH_USER_TOKEN_EXPIRED;
            } else {
                $status = AuthConstsMessages::AUTH_USER_TOKEN_INVALID;
            }

            $message = $status . " - " . $e->getMessage();

            LogController::store($request, AuthConsts::AUTH_APP_KEY, $message);

            return response()->json(['status' => false, 'message' => $message], 401);
        }

        return $next($request);
    }
}
