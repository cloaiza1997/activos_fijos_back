<?php

namespace App\Http\Controllers;

use App\Constants\RegexConsts;
use App\Constants\UserConsts;
use App\Helpers\FunctionsHelper;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class UserController extends Controller
{
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
}
