<?php

namespace App\Models;

use App\Constants\GeneralConsts;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

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
        return Parameter::where("parameter_key", $parameter_key)->first();
    }

    // ****
    // CONSULTAS DE PARÁMETROS ESPECÍFICOS
    // ****

    /**
     * Consulta el listado de departamentos con sus respectivas ciudades
     *
     * @return Array Departamentos y ciudades
     */
    public static function getCitiesByDepartment()
    {
        $departments_key_id = Parameter::getParameterByKey(GeneralConsts::DEPARTMENTS)->id;
        $departments = Parameter::where("id_parent", $departments_key_id)->where("is_active", 1)->get(["id", "str_val as name", "num_val as code"]);

        $departments_cities = [];

        foreach ($departments as $department) {
            $department->is_department = true;

            array_push($departments_cities, $department);

            $department->cities = Parameter::where("id_parent", $department->id)->where("is_active", 1)->get(["id", "str_val as name", "num_val as code"]);


            foreach ($department->cities as $city) {

                array_push($departments_cities, $city);
            }
        }

        return ["departments" => $departments, "departments_cities" => $departments_cities];
    }

    public static function getCompnayInfo()
    {
        $company_info["name"] = Parameter::getParameterByKey(GeneralConsts::COMPANY_NAME)->str_val;
        $company_info["document_number"] = Parameter::getParameterByKey(GeneralConsts::COMPANY_DOCUMENT_NUMBER)->str_val;
        $company_info["address"] = Parameter::getParameterByKey(GeneralConsts::COMPANY_ADDRESS)->str_val;
        $company_info["phone_number"] = Parameter::getParameterByKey(GeneralConsts::COMPANY_PHONE_NUMBER)->str_val;
        $company_info["city"] = Parameter::find(Parameter::getParameterByKey(GeneralConsts::COMPANY_CITY_ID)->num_val)->str_val;

        return $company_info;
    }

    public static function getPaymentMethods()
    {
        $payment_methods_id = Parameter::getParameterByKey(GeneralConsts::PAYMENT_METHODS)->id;
        $payment_methods = Parameter::where("id_parent", $payment_methods_id)->where("is_active", 1)->get(["id", "parameter_key as key", "str_val as name"]);

        return $payment_methods;
    }
}
