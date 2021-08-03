<?php

namespace App\Models;

use App\Models\User;
use App\Models\Parameter;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

/**
 * @class Certificate
 * @namespace App\Models
 * @brief Modelo de actas
 * @date 01/06/2021
 * @author Cristian Loaiza <cris-1997-loaiza@hotmail.com>
 */
class Certificate extends Model
{
    use HasFactory;

    protected $table = "certificates";

    protected $fillable = [
        "id_deliver_user",
        "id_deliver_area",
        "delivered_at",
        "id_receiver_user",
        "id_receiver_area",
        "received_at",
        "id_creator_user",
        "id_approver_user",
        "approved_at",
        "id_status",
        "id_parent",
        "observations"
    ];

    public function getDeliverUser()
    {
        return $this->belongsTo(User::class, "id_deliver_user");
    }

    public function getDeliverArea()
    {
        return $this->belongsTo(Parameter::class, "id_deliver_area");
    }

    public function getReceiverUser()
    {
        return $this->belongsTo(User::class, "id_receiver_user");
    }

    public function getReceiverArea()
    {
        return $this->belongsTo(Parameter::class, "id_receiver_area");
    }

    public function getCreatorUser()
    {
        return $this->belongsTo(User::class, "id_creator_user");
    }

    public function getApproverUser()
    {
        return $this->belongsTo(User::class, "id_approver_user");
    }

    public function getStatus()
    {
        return $this->belongsTo(Parameter::class, "id_status");
    }

    public function getParent()
    {
        return $this->belongsTo(Certificate::class, "id_parent");
    }
}
