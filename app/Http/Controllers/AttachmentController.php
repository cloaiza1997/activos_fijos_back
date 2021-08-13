<?php

namespace App\Http\Controllers;

use App\Constants\AttachmentConsts;
use App\Models\Attachment;
use App\Models\Parameter;
use Illuminate\Http\Request;

/**
 * @class AttachmentController
 * @namespace App\Http\Controllers
 * @brief Controlador de la gestión de archivos
 * @date 01/06/2021
 * @author Cristian Loaiza <cris-1997-loaiza@hotmail.com>
 */
class AttachmentController extends Controller
{
    /**
     * Carga archivos relacionándolos a un registro
     *
     * @param Request $request
     * @param string $app_key Aplicación a la que pertenece el registro
     * @param number $id_register Id del registro a relacionar los archivos
     * @return void
     */
    public function uploadFiles(Request $request, $app_key, $id_register, $response = true)
    {
        $success = false;
        $id_app_key = Parameter::getParameterByKey($app_key)->id;
        $id_files = $request->input("oldFiles");

        // + Validaicón de existencia de archivos
        if ($request->hasfile('files')) {
            // Se mueven los archivos y se almacenan en la DB
            foreach ($request->file('files') as $file) {
                $file_name = date('YmdHis') . '_' . $app_key . '_' . $id_register . '_' .  $file->getClientOriginalName();
                $file_name = str_replace(' ', '', $file_name);

                $file->move(public_path() . '/attachments/', $file_name);

                $attach = new Attachment();
                $attach->id_app_key = $id_app_key;
                $attach->id_register = $id_register;
                $attach->file_name = $file_name;
                $attach->save();

                $id_files[] = $attach->id;
            }

            $success = true;
        }

        // Se consultan los archivos a eliminar
        if ($id_files) {
            $files_to_delete = Attachment::where("id_app_key", $id_app_key)->where("id_register", $id_register)->whereNotIn("id", $id_files)->get();
        } else {
            $files_to_delete = Attachment::where("id_app_key", $id_app_key)->where("id_register", $id_register)->get();
        }

        if (count($files_to_delete)) {
            foreach ($files_to_delete as $delete) {
                unlink(public_path() . "/attachments/$delete->file_name");
                $delete->delete();
            }

            $success = true;
        }

        // Se consultan los archivos activos
        $files = Attachment::getAttachments($app_key, $id_register);

        if ($response) {
            return response()->json(["status" => true, "message" => $success ? AttachmentConsts::ATTACHMENT_MESSAGE_STORE_SUCCESS : null, "files" => $files]);
        } else {
            return $files;
        }
    }
}
