<?php

namespace App\Models;

use App\Models\Purchase;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

/**
 * @class PurchaseItem
 * @namespace App\Models
 * @brief Modelo de item de compra
 * @date 01/06/2021
 * @author Cristian Loaiza <cris-1997-loaiza@hotmail.com>
 */
class PurchaseItem extends Model
{
    use HasFactory;

    protected $table = "purch_items";

    protected $fillable = [
        "id_purchase",
        "product",
        "quantity",
        "unit_value",
        "total_value"
    ];

    public function getPurchase()
    {
        return $this->belongsTo(Purchase::class, "id_purchase");
    }
}
