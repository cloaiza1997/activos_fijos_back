<?php

namespace App\Constants;

class AuthConstsMessages
{
    const AUTH_LOG_LOGIN = "Inicio de sesión";
    const AUTH_LOG_LOGOUT = "Cierre de sesión";
    const AUTH_LOG_RECOVERY_PASSWORD = 'Solicitud de cambio de contraseña';
    const AUTH_LOGIN_VALIDATION_CREDENTIALS_ERROR = "No se puede generar el token";
    const AUTH_LOGIN_VALIDATION_CREDENTIALS_FAIL = "Email o contraseña incorrecta";
    const AUTH_LOGIN_VALIDATION_EMAIL_EMAIL = "Usuario debe de ser un email";
    const AUTH_LOGIN_VALIDATION_EMAIL_REQUIRED = "Email es requerido";
    const AUTH_LOGIN_VALIDATION_PASSWORD_REQUIRED = "Contraseña es requerida";
    const AUTH_LOGIN_VALIDATION_STATUS = "Usuario inactivo";
    const AUTH_LOGOUT_MESSAGE = "Sesión cerrada correctamente";
    const AUTH_LOGOUT_MESSAGE_INVALID_USER = "Sesión cerrada por usuario no activo";
    const AUTH_RECOVERY_PASSWORD_EMAIL_EMAIL = "Formato de email inválido";
    const AUTH_RECOVERY_PASSWORD_EMAIL_NO_SEND = 'Mensaje no enviado';
    const AUTH_RECOVERY_PASSWORD_EMAIL_REQUIRED = "Email es requerido";
    const AUTH_RECOVERY_PASSWORD_EMAIL_SEND = 'Mensaje enviado correctamente';
    const AUTH_RECOVERY_PASSWORD_USER_INACTIVE = 'El usuario no se encuentra activo';
    const AUTH_RECOVERY_PASSWORD_USER_NO_EXISTS = 'El usuario no existe';
    const AUTH_USER_TOKEN_EXPIRED = "La sesión expiró";
    const AUTH_USER_TOKEN_INVALID = "Acceso denegado. Token inválido";
}
