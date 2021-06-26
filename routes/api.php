<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

// Route::middleware('auth:api')->get('/user', function (Request $request) {
//     return $request->user();
// });

Route::post('login', "AuthController@login");
Route::post('logout', "AuthController@logout");
Route::post('recovery_password', "AuthController@recoveryPassword");

Route::group(['middleware' => ['jwt']], function () {
    Route::get('test_login', 'AuthController@testLogin');
});
