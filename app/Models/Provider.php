<?php

namespace App\Models;

use App\Models\Parameter;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

/**
 * @class Provider
 * @namespace App\Models
 * @brief Modelo de proveedor
 * @date 01/06/2021
 * @author Cristian Loaiza <cris-1997-loaiza@hotmail.com>
 */
class Provider extends Model
{
    use HasFactory;

    protected $table = "providers";

    protected $fillable = [
        "id_document_type",
        "document_number",
        "name",
        "address",
        "id_city",
        "email",
        "phone_number",
        "observations",
        "is_active"
    ];

    public function getDocumentType()
    {
        return $this->belongsTo(Parameter::class, "id_document_type");
    }

    public function getCity()
    {
        return $this->belongsTo(Parameter::class, "id_city");
    }
}
