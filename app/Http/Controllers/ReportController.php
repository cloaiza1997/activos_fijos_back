<?php

namespace App\Http\Controllers;

use App\Models\Report;
use Illuminate\Http\Request;

class ReportController extends Controller
{
    public function generateReport(Request $request)
    {
        $inputs = $request->all();
        $reportModel = new Report();

        $reports = [
            "asset_details" => [
                "label" => "Reporte Detalle de Activos",
                "func" => function () use ($reportModel) {
                    return $reportModel->reportAssetsDetail();
                }
            ],
            "asset_certificate" => [
                "label" => "Reporte Activos y Actas",
                "func" => function () use ($reportModel) {
                    return $reportModel->reportAssetCertificate();
                }
            ],
            "asset_deprecation" => [
                "label" => "Reporte Depreciaciones",
                "func" => function () use ($reportModel) {
                    return $reportModel->reportAssetDeprecation();
                }
            ],
        ];

        $report = [];

        if (isset($reports[$inputs["name"]])) {
            $label = $reports[$inputs["name"]]["label"];
            $report =  $reports[$inputs["name"]]["func"]();
        } else {
            $label = "No existe el reporte";
        }

        return response()->json(["label" => $label, "report" => $report]);
    }
}
