<?php

namespace App\Constants;

class ReportConsts
{
    const REPORT_ASSET_DETAILS = "REPORT_ASSET_DETAILS";
    const REPORT_ASSET_DETAILS_LABEL = "Reporte Detalle de Activos";
    const REPORT_ASSET_CERTIFICATE = "REPORT_ASSET_CERTIFICATE";
    const REPORT_ASSET_CERTIFICATE_LABEL = "Reporte Activos y Actas";
    const REPORT_ASSET_DEPRECATION = "REPORT_ASSET_DEPRECATION";
    const REPORT_ASSET_DEPRECATION_LABEL = "Reporte Depreciaciones";

    const REPORT_LIST = [
        ["name" => ReportConsts::REPORT_ASSET_DETAILS, "label" => ReportConsts::REPORT_ASSET_DETAILS_LABEL],
        ["name" => ReportConsts::REPORT_ASSET_CERTIFICATE, "label" => ReportConsts::REPORT_ASSET_CERTIFICATE_LABEL],
        ["name" => ReportConsts::REPORT_ASSET_DEPRECATION, "label" => ReportConsts::REPORT_ASSET_DEPRECATION_LABEL],
    ];
}
