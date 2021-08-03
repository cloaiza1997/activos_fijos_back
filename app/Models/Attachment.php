<?php

namespace App\Models;

use App\Models\Parameter;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

/**
 * @class Attachment
 * @namespace App\Models
 * @brief Modelo de adjuntos
 * @date 01/06/2021
 * @author Cristian Loaiza <cris-1997-loaiza@hotmail.com>
 */
class Attachment extends Model
{
    use HasFactory;

    protected $table = "attachments";

    protected $fillable = [
        "id_app_key",
        "id_register",
        "id_attachment_type",
        "file_name",
        "is_active"
    ];

    public function getAppKey()
    {
        return $this->belongsTo(Parameter::class, "id_app_key");
    }

    public function getAttachmentType()
    {
        return $this->belongsTo(Parameter::class, "id_attachment_type");
    }
}
