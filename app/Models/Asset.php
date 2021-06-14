<?php

namespace App\Models;

use App\Models\Parameter;
use App\Models\Purchase;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

/**
 * @class Asset
 * @namespace App\Models
 * @brief Modelo de activos
 * @date 01/06/2021
 * @author Cristian Loaiza <cris-1997-loaiza@hotmail.com>
 */
class Asset extends Model
{
    use HasFactory;

    protected $table = "assets";

    protected $fillable = [
        "id_asset_group",
        "id_asset_type",
        "asset_number",
        "name",
        "description",
        "id_brand",
        "model",
        "serial_number",
        "entry_date",
        "current_value",
        "use_life",
        "id_maintenance_frequence",
        "id_purchase_item",
        "id_status"
    ];

    public function getAssetGroup()
    {
        return $this->belongsTo(Parameter::class, "id_asset_group");
    }

    public function getAssetType()
    {
        return $this->belongsTo(Parameter::class, "id_asset_type");
    }

    public function getBrand()
    {
        return $this->belongsTo(Parameter::class, "id_brand");
    }

    public function getMaintenanceFrequence()
    {
        return $this->belongsTo(Parameter::class, "id_maintenance_frequence");
    }

    public function getStatus()
    {
        return $this->belongsTo(Parameter::class, "id_status");
    }

    public function getPurchaseItem()
    {
        return $this->belongsTo(Purchase::class, "id_purchase_item");
    }
}
