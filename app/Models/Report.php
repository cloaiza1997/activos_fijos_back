<?php

namespace App\Models;

use App\Constants\CertificateConsts;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

/**
 * @class Report
 * @namespace App\Models
 * @brief Modelo para los reportes
 * @date 01/06/2021
 * @author Cristian Loaiza <cris-1997-loaiza@hotmail.com>
 */
class Report
{
    public function reportAssetsDetail()
    {
        $report = DB::select("SELECT asset.id 'Nº', asset.asset_number 'Nº activo', asset.name 'Activo', asset.description 'Descripción', param_brand.str_val 'Marca', asset.model 'Modelo', asset.serial_number 'Nº Serial',
        asset.created_at 'Fecha Creación', asset.entry_date 'Fecha Ingreso', LPAD(purch.id_purchase, 8, 0) 'OC', param_status.str_val 'Estado', asset.use_life 'Vida Útil', 
        param_main_freq.str_val 'Freq Manto', asset.maintenance_date 'Último Manto'
        FROM assets AS asset
        LEFT JOIN purch_items AS purch ON asset.id_purchase_item = purch.id,
        parameters AS param_brand, parameters AS param_status, parameters AS param_main_freq
        WHERE asset.id_brand = param_brand.id
        AND asset.id_status = param_status.id
        AND asset.id_maintenance_frequence = param_main_freq.id");

        return $report;
    }

    public function reportAssetCertificate()
    {
        $id_certificate_active = Parameter::getParameterByKey(CertificateConsts::CERTIFICATE_ACTIVE)->id;

        $report = DB::select("SELECT asset.asset_number 'Nº activo', asset.id 'Nº Sistema', asset.name 'Activo', param_asset_status.str_val 'Estado Activo',
        LPAD(cert.id, 6, 0) 'Nº Acta', receiver_user.display_name 'Asignado', param_cert_location.str_val 'Ubicación', cert.received_at 'Fecha Entrega', param_cert_status.str_val 'Estado Acta'
        FROM assets AS asset
        LEFT JOIN certi_details AS cert_det ON (
            asset.id = cert_det.id_asset 
            AND cert_det.id_certificate IN (
                SELECT id 
                FROM certificates 
                WHERE id = cert_det.id_certificate 
                AND certificates.id_status = $id_certificate_active
            )
        )
        LEFT JOIN certificates AS cert ON cert_det.id_certificate = cert.id
        LEFT JOIN users AS receiver_user ON cert.id_receiver_user = receiver_user.id
        LEFT JOIN parameters AS param_cert_location ON cert.id_receiver_area = param_cert_location.id
        LEFT JOIN parameters AS param_cert_status ON cert.id_status = param_cert_status.id,
        parameters AS param_asset_status
        WHERE asset.id_status = param_asset_status.id
        AND (
            cert.id IS NULL
            OR (cert.id, asset.id) IN (
                SELECT MAX(id_certificate), id_asset 
                FROM certi_details 
                WHERE certi_details.id_asset = asset.id
                GROUP BY id_asset
            )
        )
        ORDER BY asset.asset_number");

        return $report;
    }
}
