<?php

namespace App\Constants;

class UserConsts
{
  const USER_APP_KEY = "USERS";

  const USER_REQUEST_DOCUMENT_NUMBER_UNIQUE = "El número de documento ya se encuentra registrado";
  const USER_REQUEST_EMAIL_UNIQUE = "El email ya se encuentra registrado";
  const USER_REQUEST_PASSWORD_CONFIRM_REQUIRED = "La confirmación de contraseña es requerida";
  const USER_REQUEST_PASSWORD_REGEX = "La contraseña no cumple con el formato establecido";
  const USER_REQUEST_PASSWORD_REQUIRED = "La contraseña es requerida";
  const USER_REQUEST_PASSWORD_SAME = "Las contraseñas ingresadas no coinciden";

  const USER_LOG_UPDATE_PASSWORD = "Actualización de contraseña";

  const USER_UPDATE_PASSWORD_SUCCESS = "Contraseña actualizada correctamente";

  const COMPANY_AREAS = "COMPANY_AREAS";
  const COMPANY_POSITIONS = "COMPANY_POSITIONS";
  const DOCUMENT_TYPE = "DOCUMENT_TYPE";
  const USER_ROLE = "USER_ROLE";
  const USER_STATUS = "USER_STATUS";

  const USER_MESSAGE_STORE_LOG = "Creación de usuario";
  const USER_MESSAGE_STORE_SUCCESS = "Usuario creado correctamente";
}
