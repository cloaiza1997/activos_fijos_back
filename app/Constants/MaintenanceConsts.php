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


  // const MAINTENANCE_STATUS_FINISHED = "MAINTENANCE_FINISHED";

  // const MAINTENANCE_MESSAGE_DETAIL_LOG = "Adición del detalle de inventario Nº";
  // const MAINTENANCE_MESSAGE_FINISHED_LOG = "Proceso de inventario finalizado";
  // const MAINTENANCE_MESSAGE_FINISHED_SUCCESS = "Proceso de inventario finalizado correctamente";
  const MAINTENANCE_MESSAGE_STORE_LOG = "Creación de proceso de mantenimiento";
  const MAINTENANCE_MESSAGE_STORE_SUCCESS = "Proceso de mantenimiento iniciado correctamente";
  // const MAINTENANCE_MESSAGE_UPDATE_LOG = "Actualización de proceso de inventario";
  // const MAINTENANCE_MESSAGE_UPDATE_SUCCESS = "Proceso de inventario actualizado correctamente";
}
