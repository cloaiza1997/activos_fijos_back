<?php

namespace App\Constants;

class MaintenanceConsts
{
  const MAINTENANCE_APP_KEY = "MAINTENANCES";

  const MAINTENANCE_TYPE  = "MAINTENANCE_TYPE";

  const MAINTENANCE_IN_PROCESS = "MAINTENANCE_IN_PROCESS";
  const MAINTENANCE_SIGNATURE_PROCESS = "MAINTENANCE_SIGNATURE_PROCESS";
  const MAINTENANCE_FINISHED = "MAINTENANCE_FINISHED";
  const MAINTENANCE_CANCELLED = "MAINTENANCE_CANCELLED";

  const MAINTENANCE_MESSAGE_EDIT_ERROR = "Mantenimiento no existe";
  const MAINTENANCE_MESSAGE_STORE_LOG = "Creación de proceso de mantenimiento";
  const MAINTENANCE_MESSAGE_STORE_SUCCESS = "Proceso de mantenimiento iniciado correctamente";
  const MAINTENANCE_MESSAGE_UPDATE_LOG = "Actualización de proceso de mantenimiento";
  const MAINTENANCE_MESSAGE_UPDATE_STATUS_LOG = "Estado de mantenimiento actualizado - Estado: ";
  const MAINTENANCE_MESSAGE_UPDATE_STATUS_SUCCESS = "Estado actualizado correctamente";
  const MAINTENANCE_MESSAGE_UPDATE_SUCCESS = "Proceso de mantenimiento actualizado correctamente";
}
