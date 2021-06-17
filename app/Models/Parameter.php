<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

/**
 * @class Parameter
 * @namespace App\Models
 * @brief Modelo de parámetro
 * @date 01/06/2021
 * @author Cristian Loaiza <cris-1997-loaiza@hotmail.com>
 */
class Parameter extends Model
{
    use HasFactory;

    protected $table = "parameters";

    protected $fillable = [
        "id_parent",
        "parameter_key",
        "name",
        "description",
        "num_val",
        "str_val",
        "is_active",
        "is_editable",
        "is_editable_details"
    ];

    public function getAppKey()
    {
        return $this->belongsTo(Parameter::class, "id_parent");
    }

    /**
     * Consulta un parámetro con base en el campo parameter_jey
     *
     * @param string $parameter_key Key del parámetro a consultar
     * @return Parameter Parámetro encontrado
     */
    public static function getParameterByKey($parameter_key)
    {
        return Parameter::where("parameter_key", $parameter_key)->get()[0];
    }
}
