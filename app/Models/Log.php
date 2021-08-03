<?php

namespace App\Models;

use App\Models\User;
use App\Models\Parameter;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

/**
 * @class Log
 * @namespace App\Models
 * @brief Modelo de log
 * @date 01/06/2021
 * @author Cristian Loaiza <cris-1997-loaiza@hotmail.com>
 */
class Log extends Model
{
    use HasFactory;

    protected $table = "logs";

    protected $fillable = [
        "id_user",
        "id_register",
        "id_app_key",
        "description",
        "ip",
        "client"
    ];

    public function getUser()
    {
        return $this->belongsTo(User::class, "id_user");
    }

    public function getAppKey()
    {
        return $this->belongsTo(Parameter::class, "id_app_key");
    }
}
