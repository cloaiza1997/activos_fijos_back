<?php

namespace App\Models;

use App\Models\Maintenance;
use App\Models\Asset;
use App\Models\User;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

/**
 * @class MaintenanceDetail
 * @namespace App\Models
 * @brief Modelo de detalle de mantenimiento
 * @date 01/06/2021
 * @author Cristian Loaiza <cris-1997-loaiza@hotmail.com>
 */
class MaintenanceDetail extends Model
{
    use HasFactory;

    protected $table = "maint_details";

    protected $fillable = [
        "id_maintenance",
        "id_asset",
        "executed_at",
        "id_validator_user",
        "validated_at",
        "observations"
    ];

    public function getMaintenance()
    {
        return $this->belongsTo(Maintenance::class, "id_maintenance");
    }

    public function getAsset()
    {
        return $this->belongsTo(Asset::class, "id_asset");
    }

    public function getValidatorUser()
    {
        return $this->belongsTo(User::class, "id_validator_user");
    }
}
