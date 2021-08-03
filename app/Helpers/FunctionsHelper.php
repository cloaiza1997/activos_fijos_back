<?php

namespace App\Helpers;

use Illuminate\Support\Facades\Validator;
use Illuminate\Http\Request;

/**
 * @class FunctionsHelper
 * @namespace App\Helpers
 * @brief Clase con funciones helpers
 * @date 26/06/2021
 * @author Cristian Loaiza <cris-1997-loaiza@hotmail.com>
 */
class FunctionsHelper
{
    /**
     * Genera una cadena aleatora
     *
     * @param integer $chars Longitud de la cadena
     * @return string Cadena aleatoria
     */
    static public function ramdomString($chars = 10)
    {
        $letters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
        return substr(str_shuffle($letters), 0, $chars);
    }

    /**
     * Valida una petición de acuerdo con las validacione y mensajes recibidos
     *
     * @param Request $request
     * @param Array $validations
     * @param Array $messages
     * @return Boolean fail - FALSE = Datos son válidos
     */
    static public function validateRequest(Request $request, $validations = [], $messages = [])
    {
        $validator = Validator::make(
            $request->all(),
            $validations,
            $messages
        );

        if ($validator->fails()) {

            return response()->json([
                "error" => $validator->errors()
            ], 422);
        } else {
            return false;
        }
    }
}
