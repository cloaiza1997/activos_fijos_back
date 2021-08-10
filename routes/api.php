<?php

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

Route::post('login', "AuthController@login");
Route::post('logout', "AuthController@logout");
Route::post('recovery_password', "AuthController@recoveryPassword");

Route::group(['middleware' => ['jwt']], function () {
    Route::get('test_login', 'AuthController@testLogin');
    Route::post('update_password', 'UserController@updatePassword');

    // Adjuntos
    Route::post('upload_files/{app_key}/{id_register}', 'AttachmentController@uploadFiles');

    // Compras
    Route::resource('purchase', 'PurchaseController');
    Route::put('purchase/update_status/{id}', 'PurchaseController@updateStatus');
    Route::get('purchase_to_approve', 'PurchaseController@indexApprover');
    // Activos
    Route::resource('asset', 'AssetController');
});
