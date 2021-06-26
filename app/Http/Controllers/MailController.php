<?php

namespace App\Http\Controllers;

use App\Constants\MailConsts;
use App\Models\Outbox;
use App\Models\Parameter;
use PHPMailer\PHPMailer\Exception;
use PHPMailer\PHPMailer\PHPMailer;

/**
 * @class MailController
 * @namespace App\Http\Controllers
 * @brief Controlador para el envío de correos
 * @date 01/06/2021
 * @author Cristian Loaiza <cris-1997-loaiza@hotmail.com>
 */
class MailController extends Controller
{
    /**
     * Agrega las direcciones de correo a los respectivos destinatarios
     *
     * @param Array $mail_params Listado de direcciones
     * @param String $subject Asunto
     * @param String $body Cuerpo del mensaje
     * @param Array $data Datos opcionales
     * @return String Cadena de destinatarios
     */
    private static function addAddressesToMail($list_name, $mail_params, $mail)
    {
        $list = isset($mail_params[$list_name]) ? $mail_params[$list_name] : [];
        $address_text = null;

        if (count($list)) {
            $address_text = "";

            foreach ($list as $address) {
                $email = $address["email"];
                $name = $address["name"];

                switch ($list_name) {
                    case "address":
                        $mail->addAddress($email, $name);
                        break;
                    case "cc":
                        $mail->addCC($email, $name);
                        break;
                    case "bcc":
                        $mail->addBCC($email, $name);
                        break;
                }

                $address_text .= "$email;";
            }
        }

        return $address_text;
    }

    /**
     * Consulta el template del mensaje con base en la key del parámetro
     *
     * @param String $parameter_key
     * @return Array { subject, body }
     */
    static public function getEmailTemplate($parameter_key)
    {
        $template = Parameter::getParameterByKey($parameter_key);

        return ["id" => $template->id, "subject" => $template->name, "body" => $template->str_val];
    }

    /**
     * Realiza el envío de un email
     * @param Array $mail_params Listado de direcciones { app_key, id_email_template, address: [{ email, name }], cc: [{ email, name }], bcc: [{ email, name }] }
     * @param String $subject Asunto
     * @param String $body Cuerpo del mensaje
     * @param Array $data Datos opcionales
     * @return Array [ status => boolean, outbox ]
     */
    public static function sendMail($mail_params = MailConsts::MAIL_PARAMS_DEFAULT, $subject, $body, $data = [])
    {
        try {
            $id_app_key = Parameter::getParameterByKey($mail_params["app_key"])->id;
            $from_email = Parameter::getParameterByKey(MailConsts::MAIL_SENDER_EMAIL)->str_val;
            $from_name = Parameter::getParameterByKey(MailConsts::MAIL_SENDER_EMAIL_FROM)->str_val;
            $header = MailController::getEmailTemplate(MailConsts::EMAIL_TEMPLATE_HEADER)["body"];
            $footer = MailController::getEmailTemplate(MailConsts::EMAIL_TEMPLATE_FOOTER)["body"];
            $body = $header . $body . $footer;

            $mail = new PHPMailer();
            $mail->isSMTP();
            $mail->CharSet = config('phpmailer.charset');
            $mail->Host = config('phpmailer.host');
            $mail->SMTPAuth = true;
            $mail->SMTPSecure = true;
            $mail->Port = config('phpmailer.port');
            $mail->Username = config('phpmailer.username');
            $mail->Password = config('phpmailer.password');
            $mail->SMTPOptions = array(
                'ssl' => array(
                    'verify_peer' => false,
                    'verify_peer_name' => false,
                    'allow_self_signed' => true
                )
            );
            $mail->setFrom($from_email, $from_name);

            $mail->Subject = $subject;
            $mail->MsgHTML($body);

            $address = MailController::addAddressesToMail("address", $mail_params, $mail);
            $cc = MailController::addAddressesToMail("cc", $mail_params, $mail);
            $bcc = MailController::addAddressesToMail("bcc", $mail_params, $mail);

            if ($mail->send()) {

                $outbox = new Outbox();

                $outbox->id_app_key = $id_app_key;
                $outbox->id_email_template = $mail_params["id_email_template"];
                $outbox->from = "$from_name <$from_email>";
                $outbox->address = $address;
                $outbox->cc = $cc;
                $outbox->bcc = $bcc;
                $outbox->subject = $subject;
                $outbox->body = $body;
                $outbox->save();

                return ["status" => true, "outbox" => $outbox];
            } else {
                return ["status" => false];
            }
        } catch (phpmailerException $e) {
            return ["status" => false, "message" => $e];
        } catch (Exception $e) {
            return ["status" => false, "message" => $e];
        }
    }

    /**
     * Realiza el envío de un mensaje de acuerdo a su template
     * @param Array $mail_params { app_key, address, cc, bcc, subject, body } | Los parámetros subject y body deben de ser arreglos nombrados que contengan los nombres de las variables
     * a reemplazar en el template ya sea en el subject o el body del mensaje
     * @param String $email_template_name Key de la plantilla
     * @return Array [ status => boolean, outbox ]
     */
    static public function sendEmailByTemplate($mail_params = MailConsts::MAIL_PARAMS_DEFAULT, $email_template_name = "")
    {
        // Consulta el template
        $message = MailController::getEmailTemplate($email_template_name);
        // Sobreescribe el arreglo agredando el id del template
        $mail_params["id_email_template"] = $message["id"];

        $subject = MailController::replaceTemplateParams("subject", $message, $mail_params);
        $body = MailController::replaceTemplateParams("body", $message, $mail_params);

        return MailController::sendMail($mail_params, $subject, $body);
    }

    /**
     * Reemplaza las variables de la plantilla. Las variables deben de ser {{var_name}} y los parámetros deben de coincidir con las varialbes para que se realice el reemplazo
     * @param Strin $key_name "subject" | "body"
     * @param Array $mail_template Arreglo que contiene el texto de la plantilla en el cual se reemplazarán las variables
     * @param Array $mail_params Arreglo con los parámetros con los valores a reemplazar en la platilla
     * @return String Texto actualizado con sus respectivos valores
     */
    static public function replaceTemplateParams($key_name, $mail_template = [], $mail_params = [])
    {
        $template = isset($mail_template[$key_name]) ? $mail_template[$key_name] : "";

        if (isset($mail_params[$key_name])) {
            $template = $mail_template[$key_name];
            $params = $mail_params[$key_name];

            $keys = array_keys($params);

            foreach ($keys as $key) {
                $value = $params[$key];

                $template = preg_replace("/\{\{$key\}\}/", $value, $template);
            }
        }

        return $template;
    }
}
