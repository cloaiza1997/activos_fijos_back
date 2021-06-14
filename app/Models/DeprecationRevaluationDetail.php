<?php

namespace App\Models;

use App\Models\DeprecationRevaluation;
use App\Models\Asset;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

/**
 * @class DeprecationRevaluationDetail
 * @namespace App\Models
 * @brief Modelo de detalle de depreciación y revaluación
 * @date 01/06/2021
 * @author Cristian Loaiza <cris-1997-loaiza@hotmail.com>
 */
class DeprecationRevaluationDetail extends Model
{
    use HasFactory;

    protected $table = "depre_reval_details";

    protected $fillable = [
        "id_depre_reval",
        "id_asset",
        "old_value",
        "new_value",
        "observations",
        "id_parent"
    ];

    public function getDepreReval()
    {
        return $this->belongsTo(DeprecationRevaluation::class, "id_depre_reval");
    }

    public function getAsset()
    {
        return $this->belongsTo(Asset::class, "id_asset");
    }

    public function getParent()
    {
        return $this->belongsTo(DeprecationRevaluationDetail::class, "id_parent");
    }
}
