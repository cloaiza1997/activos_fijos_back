<?php

namespace App\Models;

use App\Models\Parameter;
use App\Models\Derecognition;
use App\Models\Asset;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

/**
 * @class DerecognitionDetail
 * @namespace App\Models
 * @brief Modelo de detalle de baja
 * @date 01/06/2021
 * @author Cristian Loaiza <cris-1997-loaiza@hotmail.com>
 */
class DerecognitionDetail extends Model
{
    use HasFactory;

    protected $table = "derec_details";

    protected $fillable = [
        "id_derecognition",
        "id_asset",
        "id_reason",
        "observation",
        "id_parent"
    ];

    public function getDerecognition()
    {
        return $this->belongsTo(Derecognition::class, "id_derecognition");
    }

    public function getAsset()
    {
        return $this->belongsTo(Asset::class, "id_asset");
    }

    public function getReason()
    {
        return $this->belongsTo(Parameter::class, "id_reason");
    }

    public function getParent()
    {
        return $this->belongsTo(DerecognitionDetail::class, "id_parent");
    }
}
