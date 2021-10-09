<?php

namespace App\Http\Controllers;

use App\Constants\ReportConsts;
use App\Models\Report;
use Illuminate\Http\Request;

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

        if (isset($reports[$inputs["name"]])) {
            $label = $reports[$inputs["name"]]["label"];
            $report =  $reports[$inputs["name"]]["func"]();
        } else {
            $label = "No existe el reporte";
        }

        return response()->json(["label" => $label, "report" => $report]);
    }
}
