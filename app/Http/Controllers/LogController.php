<?php

namespace App\Http\Controllers;

use App\Models\Log;
use App\Models\Parameter;
use App\Models\User;
use Illuminate\Http\Request;

/**
 * @class LogController
 * @namespace App\Http\Controllers
 * @brief Controlador de los logs
 * @date 01/06/2021
 * @author Cristian Loaiza <cris-1997-loaiza@hotmail.com>
 */
class LogController extends Controller
{
    /**
     * Registra una acción realizada en el sistema
     *
     * @param Request $request Petición realizada
     * @param string $app_key Aplicación a la que pertenece la acción ejecutada
     * @param string $description Descripción de la acción a realizar
     * @param number $id_register Id del registo de otra tabla afectado
     */
    public static function store(Request $request, $app_key, $description, $id_register = null)
    {
        $id_app_key = Parameter::getParameterByKey($app_key)->id;
        $log = new Log();

        $log->id_user = User::getAuthUser()->id;
        $log->id_register = $id_register;
        $log->id_app_key = $id_app_key;
        $log->description = $description;
        $log->ip = $request->ip();
        $log->client = $request->header("client");

        $log->save();
    }
}
