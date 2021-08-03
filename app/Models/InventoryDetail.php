<?php

namespace App\Models;

use App\Models\Inventory;
use App\Models\Asset;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

/**
 * @class InventoryDetail
 * @namespace App\Models
 * @brief Modelo de detalle de inventario
 * @date 01/06/2021
 * @author Cristian Loaiza <cris-1997-loaiza@hotmail.com>
 */
class InventoryDetail extends Model
{
    use HasFactory;

    protected $table = "inven_details";

    protected $fillable = [
        "id_inventory",
        "id_asset",
        "is_asset_updated"
    ];

    public function getInventory()
    {
        return $this->belongsTo(Inventory::class, "id_inventory");
    }

    public function getAsset()
    {
        return $this->belongsTo(Asset::class, "id_asset");
    }
}
