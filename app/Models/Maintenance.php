<?php

namespace App\Models;

use App\Models\User;
use App\Models\Parameter;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

/**
 * @class Maintenance
 * @namespace App\Models
 * @brief Modelo de mantenimiento
 * @date 01/06/2021
 * @author Cristian Loaiza <cris-1997-loaiza@hotmail.com>
 */
class Maintenance extends Model
{
    use HasFactory;

    protected $table = "maintenances";

    protected $fillable = [
        "id_user",
        "id_status",
        "id_type",
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

    public function getType()
    {
        return $this->belongsTo(Parameter::class, "id_type");
    }
}
