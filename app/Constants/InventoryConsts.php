<?php

namespace App\Constants;

class InventoryConsts
{
  const INVENTORY_APP_KEY = "INVENTORIES";

  const INVENTORY_STATUS_IN_PROCESS = "INVENTORY_IN_PROCESS";
  const INVENTORY_STATUS_FINISHED = "INVENTORY_FINISHED";

  const INVENTORY_MESSAGE_DETAIL_LOG = "Adición del detalle de inventario Nº";
  const INVENTORY_MESSAGE_FINISHED_LOG = "Proceso de inventario finalizado";
  const INVENTORY_MESSAGE_FINISHED_SUCCESS = "Proceso de inventario finalizado correctamente";
  const INVENTORY_MESSAGE_STORE_LOG = "Creación de proceso de inventario";
  const INVENTORY_MESSAGE_STORE_SUCCESS = "Proceso de inventario iniciado correctamente";
  const INVENTORY_MESSAGE_UPDATE_LOG = "Actualización de proceso de inventario";
  const INVENTORY_MESSAGE_UPDATE_SUCCESS = "Proceso de inventario actualizado correctamente";
  // const REVALUATION_MESSAGE_EDIT_ERROR = "Ocurrió un error al consultar la revaluación";
  // const REVALUATION_MESSAGE_STORE_LOG = "Creación de revaluación";
  // const REVALUATION_MESSAGE_STORE_SUCCESS = "Proceso de revaluación creado correctamente";
  // const REVALUATION_MESSAGE_UPDATE_LOG = "Actualización de revaluación";
  // const REVALUATION_MESSAGE_UPDATE_STATUS_LOG = "Actualización de estado de revaluación";
  // const REVALUATION_MESSAGE_UPDATE_STATUS_SUCCESS = "Estado de proceso de revaluación actualizado correctamente";
  // const REVALUATION_MESSAGE_UPDATE_SUCCESS = "Proceso de revaluación actualizado correctamente";

  // const REVALUATION_OBSERVATION_REVERSE = "Reversa de la revaluación Nº";
  // const REVALUATION_OBSERVATION_REVERSE_DETAIL = "Reversa de la actualización del costo del detalle de revaluación Nº";
}
