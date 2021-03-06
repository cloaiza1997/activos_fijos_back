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

Route::post('generate_password/{password}', function ($password) {
    return response()->json(["password" => bcrypt($password)]);
});

Route::group(['middleware' => ['jwt']], function () {
    // Usuarios
    Route::get('test_login', 'AuthController@testLogin');
    Route::post('update_password', 'UserController@updatePassword');
    Route::post('user/admin_update_password/{id}', 'UserController@adminUpdatePassword');
    Route::resource('user', 'UserController');

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

    // Actas
    Route::get('certificate/list_own', 'CertificateController@indexResponsible');
    Route::get('certificate/list_to_approve', 'CertificateController@indexApprover');
    Route::post('certificate/status/active/{id}', 'CertificateController@setStatusActive');
    Route::post('certificate/status/approved/{id}', 'CertificateController@setStatusApproved');
    Route::post('certificate/status/cancel/{id}', 'CertificateController@setStatusCancel');
    Route::post('certificate/status/checking/{id}', 'CertificateController@setStatusChecking');
    Route::post('certificate/status/inactive/{id}', 'CertificateController@setStatusInactive');
    Route::post('certificate/status/rejected/{id}', 'CertificateController@setStatusRejected');
    Route::post('certificate/status/send_sign/{id}', 'CertificateController@setStatusSendSign');
    Route::post('certificate/store_item', 'CertificateController@storeItem');
    Route::resource('certificate', 'CertificateController');

    // Revaluaciones
    Route::post('revaluation/status/cancel/{id}', 'RevaluationController@setStatusCancel');
    Route::post('revaluation/status/execute/{id}', 'RevaluationController@setStatusExecute');
    Route::post('revaluation/status/reverse/{id}', 'RevaluationController@setStatusReverse');
    Route::resource('revaluation', 'RevaluationController');

    // Depreciaciones
    Route::post('deprecation/status/reverse/{id}', 'DeprecationController@setStatusReverse');
    Route::resource('deprecation', 'DeprecationController');

    // Inventarios
    Route::post('inventory/detail', 'InventoryController@storeInventoryDetail');
    Route::post('inventory/status/finished/{id}', 'InventoryController@setStatusFinished');
    Route::resource('inventory', 'InventoryController');

    // Bajas
    Route::get('derecognition/list_to_approve', 'DerecognitionController@indexApprover');
    Route::post('derecognition/status/approved/{id}', 'DerecognitionController@setStatusApproved');
    Route::post('derecognition/status/cancel/{id}', 'DerecognitionController@setStatusCancel');
    Route::post('derecognition/status/checking/{id}', 'DerecognitionController@setStatusChecking');
    Route::post('derecognition/status/executed/{id}', 'DerecognitionController@setStatusExecuted');
    Route::post('derecognition/status/rejected/{id}', 'DerecognitionController@setStatusRejected');
    Route::post('derecognition/status/reverse/{id}', 'DerecognitionController@setStatusReverse');
    Route::resource('derecognition', 'DerecognitionController');

    // Mantenimientos
    Route::post('maintenance/status/cancel/{id}', 'MaintenanceController@setStatusCancel');
    Route::post('maintenance/status/finished/{id}', 'MaintenanceController@setStatusFinished');
    Route::resource('maintenance', 'MaintenanceController');

    // Proveedores
    Route::resource('provider', 'ProviderController');

    // Par??metros
    Route::get('parameter/details/{id}', 'ParameterController@indexDetail');
    Route::resource('parameter', 'ParameterController');

    // Logs
    Route::get('log', 'LogController@index');

    // Reportes
    Route::get('report', 'ReportController@index');
    Route::post('report', 'ReportController@generateReport');
});
