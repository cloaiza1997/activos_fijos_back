<?php

namespace App\Models;

use App\Models\Asset;
use App\Models\Parameter;
use App\Models\Certificate;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

/**
 * @class CertificateDetail
 * @namespace App\Models
 * @brief Modelo de detalle de actas
 * @date 01/06/2021
 * @author Cristian Loaiza <cris-1997-loaiza@hotmail.com>
 */
class CertificateDetail extends Model
{
    use HasFactory;

    protected $table = "certi_details";

    protected $fillable = [
        "id_certificate",
        "id_asset",
        "asset_number",
        "name",
        "brand",
        "model",
        "serial_number",
        "observations",
        "id_physical_status"
    ];

    public function getCertificate()
    {
        return $this->belongsTo(Certificate::class, "id_certificate");
    }

    public function getAsset()
    {
        return $this->belongsTo(Asset::class, "id_asset");
    }

    public function getPhysicalStatus()
    {
        return $this->belongsTo(Parameter::class, "id_physical_status");
    }
}
