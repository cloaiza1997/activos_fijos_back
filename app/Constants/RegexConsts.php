<?php

namespace App\Constants;

class RegexConsts
{
    // Contraseña de 8 caracateres mínimo, mayúsculas, minúsculas, números y caracteres especiales
    const REGEX_PASSWORD = "/(?=^.{8,}$)((?=.*\d)(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$/";
    // Números de celular de 10 digitos y de inicio 3
    const REGEX_PHONE_NUMBER = "/^[3][0-9]{9}$/";
    // Email
    const REGEX_EMAIL = "/[-0-9a-zA-Z.+_]+@[-0-9a-zA-Z.+_]+.[a-zA-Z]{2,4}/";
}
