<?php

namespace App\Constants;

class MailConsts
{
    const EMAIL_TEMPLATE_FOOTER = "EMAIL_TEMPLATE_FOOTER";
    const EMAIL_TEMPLATE_HEADER = "EMAIL_TEMPLATE_HEADER";

    const EMAIL_TEMPLATE_PURCHASE_APPROVED = "EMAIL_TEMPLATE_PURCHASE_APPROVED";
    const EMAIL_TEMPLATE_RECOVERY_PASSWORD_USER = "EMAIL_TEMPLATE_RECOVERY_PASSWORD_USER";

    const MAIL_PARAMS_DEFAULT = ["app_key" => null, "id_email_template" => null, "address" => [], "cc" => [], "bcc" => []];
    const MAIL_SENDER_EMAIL = "SENDER_EMAIL";
    const MAIL_SENDER_EMAIL_FROM = "SENDER_EMAIL_FROM";
}
