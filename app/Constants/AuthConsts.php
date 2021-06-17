<?php

namespace App\Constants;

class AuthConsts
{
    const AUTH_APP_KEY = "AUTH";
    const AUTH_LOG_LOGIN = "Inicio de sesión";
    const AUTH_LOG_LOGOUT = "Cierre de sesión";
    const AUTH_LOGIN_VALIDATION_CREDENTIALS_ERROR = "No se puede generar el token";
    const AUTH_LOGIN_VALIDATION_CREDENTIALS_FAIL = "Email o contraseña incorrecta";
    const AUTH_LOGIN_VALIDATION_EMAIL_EMAIL = "Usuario debe de ser un email";
    const AUTH_LOGIN_VALIDATION_EMAIL_REQUIRED = "Email es requerido";
    const AUTH_LOGIN_VALIDATION_PASSWORD_REQUIRED = "Contraseña es requerida";
    const AUTH_LOGOUT_MESSAGE = "Sesión cerrada correctamente";
}
