<?php

namespace App\Models;

use App\Constants\AssetConsts;
use App\Models\Parameter;
use App\Models\User;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

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

    public function getDetails()
    {
        return $this->hasMany(DeprecationRevaluationDetail::class, 'id_depre_reval');
    }

    public function getChildren()
    {
        return $this->hasOne(DeprecationRevaluation::class, 'id_parent');
    }

    /**
     * Consulta el elemento validando si puede ser reversado
     */
    public static function getDepreRevalCanReverse($id)
    {
        $depre_reval = DeprecationRevaluation::find($id);

        $executed_status_id = Parameter::getParameterByKey(AssetConsts::ASSET_UPDATE_COST_EXECUTED)->id;
        $in_process_status_id = Parameter::getParameterByKey(AssetConsts::ASSET_UPDATE_COST_IN_PROCESS)->id;

        $list = DB::select("SELECT MAX(id) id
        FROM depreciation_revaluation
        WHERE id_status IN ($executed_status_id, $in_process_status_id)
        AND id_action_type = $depre_reval->id_action_type");

        if (count($list) == 1) {
            $max_revaluation = DeprecationRevaluation::find($list[0]->id);

            $depre_reval->can_reverse = $depre_reval->id == $max_revaluation->id && $max_revaluation->id_status == $executed_status_id;
        }

        return $depre_reval;
    }
}
