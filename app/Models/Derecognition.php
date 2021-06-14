<?php

namespace App\Models;

use App\Models\Parameter;
use App\Models\User;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

/**
 * @class Derecognition
 * @namespace App\Models
 * @brief Modelo de baja
 * @date 01/06/2021
 * @author Cristian Loaiza <cris-1997-loaiza@hotmail.com>
 */
class Derecognition extends Model
{
    use HasFactory;

    protected $table = "derecognitions";

    protected $fillable = [
        "id_status",
        "observations",
        "id_parent",
        "id_creator_user",
        "id_approver_user",
        "approvated_at"
    ];

    public function getStatus()
    {
        return $this->belongsTo(Parameter::class, "id_status");
    }

    public function getParent()
    {
        return $this->belongsTo(Derecognition::class, "id_parent");
    }

    public function getCreatorUser()
    {
        return $this->belongsTo(User::class, "id_creator_user");
    }

    public function getApproverUser()
    {
        return $this->belongsTo(User::class, "id_approver_user");
    }
}
