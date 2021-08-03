<?php

namespace App\Models;

use App\Models\User;
use App\Models\Parameter;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

/**
 * @class Inventory
 * @namespace App\Models
 * @brief Modelo de inventario
 * @date 01/06/2021
 * @author Cristian Loaiza <cris-1997-loaiza@hotmail.com>
 */
class Inventory extends Model
{
    use HasFactory;

    protected $table = "inventories";

    protected $fillable = [
        "id_user",
        "id_status",
        "observations"
    ];

    public function getUser()
    {
        return $this->belongsTo(User::class, "id_user");
    }

    public function getStatus()
    {
        return $this->belongsTo(Parameter::class, "id_status");
    }
}
