<?php

namespace App\Models;

use App\Models\Maintenance;
use App\Models\User;
use App\Models\Provider;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

/**
 * @class MaintenanceResponsible
 * @namespace App\Models
 * @brief Modelo de responsable de mantenimiento
 * @date 01/06/2021
 * @author Cristian Loaiza <cris-1997-loaiza@hotmail.com>
 */
class MaintenanceResponsible extends Model
{
    use HasFactory;

    protected $table = "maint_responsibles";

    protected $fillable = [
        "id_maintenance",
        "id_user",
        "id_provider"
    ];

    public function getMaintenance()
    {
        return $this->belongsTo(Maintenance::class, "id_maintenance");
    }

    public function getUser()
    {
        return $this->belongsTo(User::class, "id_user");
    }

    public function getProvider()
    {
        return $this->belongsTo(Provider::class, "id_provider");
    }
}
