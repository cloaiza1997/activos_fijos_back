<?php

namespace App\Models;

use App\Models\Parameter;
use App\Models\User;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

/**
 * @class DeprecationRevaluation
 * @namespace App\Models
 * @brief Modelo de depreciación y revaluación
 * @date 01/06/2021
 * @author Cristian Loaiza <cris-1997-loaiza@hotmail.com>
 */
class DeprecationRevaluation extends Model
{
    use HasFactory;

    protected $table = "depreciation_revaluation";

    protected $fillable = [
        "id_action_type",
        "id_user",
        "observations",
        "id_status",
        "id_parent"
    ];

    public function getActionType()
    {
        return $this->belongsTo(Parameter::class, "id_action_type");
    }

    public function getUser()
    {
        return $this->belongsTo(User::class, "id_user");
    }

    public function getStatus()
    {
        return $this->belongsTo(Parameter::class, "id_status");
    }

    public function getParent()
    {
        return $this->belongsTo(DeprecationRevaluation::class, "id_parent");
    }
}
