<?php

namespace App\Constants;

class DerecognitionConsts
{
  const DERECOGNITION_APP_KEY = "DERECOGNITIONS";

  // const DERECOGNITION_MESSAGE_DETAIL_LOG = "Adición del detalle de inventario Nº";
  // const DERECOGNITION_MESSAGE_FINISHED_LOG = "Proceso de inventario finalizado";
  // const DERECOGNITION_MESSAGE_FINISHED_SUCCESS = "Proceso de inventario finalizado correctamente";
  const DERECOGNITION_MESSAGE_STORE_LOG = "Creación de proceso de baja de activos";
  const DERECOGNITION_MESSAGE_STORE_SUCCESS = "Proceso de baja de activos iniciado correctamente";
  const DERECOGNITION_MESSAGE_UPDATE_LOG = "Actualización de proceso de baja de activos";
  const DERECOGNITION_MESSAGE_UPDATE_SUCCESS = "Proceso de baja de activos actualizado correctamente";

  const DERECOGNITION_IN_PROCESS = "DERECOGNITION_IN_PROCESS";
  const DERECOGNITION_CHECKING = "DERECOGNITION_CHECKING";
  const DERECOGNITION_APPROVED = "DERECOGNITION_APPROVED";
  const DERECOGNITION_REJECTED = "DERECOGNITION_REJECTED";
  const DERECOGNITION_EXECUTED = "DERECOGNITION_EXECUTED";
  const DERECOGNITION_REVERSED = "DERECOGNITION_REVERSED";
  const DERECOGNITION_CANCELLED = "DERECOGNITION_CANCELLED";

  const DERECOGNITION_REASONS = "DERECOGNITION_REASONS";

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
