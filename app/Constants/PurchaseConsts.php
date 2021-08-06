<?php

namespace App\Constants;

class PurchaseConsts
{
    const PURCHASE_APP_KEY = "PURCHASES";

    const PURCHASE_STATUS_IN_PROCESS = "PURCHASE_STATUS_IN_PROCESS";
    const PURCHASE_STATUS_CHECKING = "PURCHASE_STATUS_CHECKING";
    const PURCHASE_STATUS_CANCELLED = "PURCHASE_STATUS_CANCELLED";
    const PURCHASE_STATUS_APPROVED = "PURCHASE_STATUS_APPROVED";
    const PURCHASE_STATUS_REJECTED = "PURCHASE_STATUS_REJECTED";
    const PURCHASE_STATUS_CLOSED = "PURCHASE_STATUS_CLOSED";
    const PURCHASE_STATUS_FINISHED = "PURCHASE_STATUS_FINISHED";

    const PURCHASE_MESSAGE_EDIT_ERROR = "Orden de compra no encontrada";
    const PURCHASE_MESSAGE_STORE_LOG = "Creación de orden de compra";
    const PURCHASE_MESSAGE_STORE_SUCCESS = "Orden de compra generada correctamente";
    const PURCHASE_MESSAGE_UPDATE_LOG = "Actualización de orden de compra";
    const PURCHASE_MESSAGE_UPDATE_STATUS_LOG = "Actualización de estado de orden de compra";
    const PURCHASE_MESSAGE_UPDATE_STATUS_SUCCESS = "Estado de orden de compra actualizado correctamente";
    const PURCHASE_MESSAGE_UPDATE_SUCCESS = "Orden de compra actualizada correctamente";
}
