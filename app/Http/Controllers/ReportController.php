<?php

namespace App\Http\Controllers;

use App\Constants\ReportConsts;
use App\Models\Report;
use Illuminate\Http\Request;

/**
 * @class ReportController
 * @namespace App\Http\Controllers
 * @brief Controlador de la gestión de reportes
 * @date 01/06/2021
 * @author Cristian Loaiza <cris-1997-loaiza@hotmail.com>
 */
class ReportController extends Controller
{
    public function index()
    {
        return response()->json(["reports" => ReportConsts::REPORT_LIST]);
    }

    public function generateReport(Request $request)
    {
        $inputs = $request->all();
        $reportModel = new Report();

        $reports = [
            ReportConsts::REPORT_ASSET_DETAILS => [
                "label" => ReportConsts::REPORT_ASSET_DETAILS_LABEL,
                "func" => function () use ($reportModel) {
                    return $reportModel->reportAssetsDetail();
                }
            ],
            ReportConsts::REPORT_ASSET_CERTIFICATE => [
                "label" =>  ReportConsts::REPORT_ASSET_CERTIFICATE_LABEL,
                "func" => function () use ($reportModel) {
                    return $reportModel->reportAssetCertificate();
                }
            ],
            ReportConsts::REPORT_ASSET_DEPRECATION => [
                "label" => ReportConsts::REPORT_ASSET_DEPRECATION_LABEL,
                "func" => function () use ($reportModel) {
                    return $reportModel->reportAssetDeprecation();
                }
            ],
        ];

        $report = [];
        $status = true;
        $code = 200;
        $message = "";

        if (isset($reports[$inputs["name"]])) {
            $label = $reports[$inputs["name"]]["label"];
            $report =  $reports[$inputs["name"]]["func"]();

            $status = true;
            $message = "Reporte generado correctamente";
            $code = 200;
        } else {
            $label = "No existe el reporte";

            $status = false;
            $message = $label;
            $code = 400;
        }

        return response()->json(["status" => $status, "message" => $message, "label" => $label, "report" => $report], $code);
    }
}
