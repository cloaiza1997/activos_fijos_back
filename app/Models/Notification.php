<?php

namespace App\Models;

use App\Models\Parameter;
use App\Models\User;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

/**
 * @class Notification
 * @namespace App\Models
 * @brief Modelo de notificación
 * @date 01/06/2021
 * @author Cristian Loaiza <cris-1997-loaiza@hotmail.com>
 */
class Notification extends Model
{
    use HasFactory;

    protected $table = "notifications";

    protected $fillable = [
        "id_app_key",
        "text",
        "id_user",
        "id_status",
        "readed_at"
    ];

    public function getAppKey()
    {
        return $this->belongsTo(Parameter::class, "id_app_key");
    }

    public function getUser()
    {
        return $this->belongsTo(User::class, "id_user");
    }

    public function getStatus()
    {
        return $this->belongsTo(Parameter::class, "id_status");
    }
}
