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
    Route::get('purchase_by_status/{status}', 'PurchaseController@getPurchasesByStatus');
    Route::get('purchase_to_approve', 'PurchaseController@indexApprover');
    Route::put('purchase/update_status/{id}', 'PurchaseController@updateStatus');
    Route::resource('purchase', 'PurchaseController');
    // Activos
    Route::get('asset/list_own', 'AssetController@indexOwner');
    Route::get('asset/purchase_finished_available', 'AssetController@getPurchaseFinished');
    Route::post('asset/generate_plate/{asset_number}', 'AssetController@generateAssetPlateQrCode');
    Route::resource('asset', 'AssetController');
});
