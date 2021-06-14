<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

/**
 * @class Outbox
 * @namespace App\Models
 * @brief Modelo de bandeja de salida
 * @date 01/06/2021
 * @author Cristian Loaiza <cris-1997-loaiza@hotmail.com>
 */
class Outbox extends Model
{
    use HasFactory;

    protected $table = "outboxes";

    protected $fillable = [
        "id_app_key",
        "id_email_template",
        "sender",
        "receiver",
        "subject",
        "body"
    ];

    public function getAppKey()
    {
        return $this->belongsTo(Parameter::class, "id_app_key");
    }

    public function getEmailTemplate()
    {
        return $this->belongsTo(Parameter::class, "id_email_template");
    }
}
