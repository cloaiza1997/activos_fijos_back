<?php

namespace App\Models;

use App\Constants\AssetConsts;
use App\Constants\CertificateConsts;
use App\Models\Parameter;
use App\Models\PurchaseItem;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

/**
 * @class Asset
 * @namespace App\Models
 * @brief Modelo de activos
 * @date 01/06/2021
 * @author Cristian Loaiza <cris-1997-loaiza@hotmail.com>
 */
class Asset extends Model
{
    use HasFactory;

    protected $table = "assets";

    protected $fillable = [
        "id_asset_group",
        "id_asset_type",
        "asset_number",
        "name",
        "description",
        "id_brand",
        "model",
        "serial_number",
        "entry_date",
        "init_value",
        "residual_value",
        "current_value",
        "use_life",
        "id_maintenance_frequence",
        "maintenance_date",
        "id_purchase_item",
        "id_status"
    ];

    public static function getAsset($id)
    {
        $asset = Asset::find($id);

        if ($asset) {
            $asset->getAssetGroup;
            $asset->getAssetType;
            $asset->getBrand;
            $asset->getMaintenanceFrequence;
            $asset->getPurchaseItem;
            $asset->getStatus;
            $asset->getDepreReval;
            $asset->getInventories;
            $asset->getDerecognitions;

            foreach ($asset->getDepreReval as $item) {
                $depre_reval = DeprecationRevaluation::find($item->id_depre_reval);
                $depre_reval->getStatus;
                $depre_reval->getActionType;
                $depre_reval->getUser;

                $item->depre_reval = $depre_reval;
            }

            foreach ($asset->getInventories as $item) {
                $inventory = Inventory::find($item->id_inventory);
                $inventory->getStatus;
                $inventory->getUser;

                $item->inventory = $inventory;
            }

            foreach ($asset->getDerecognitions as $item) {
                $derecognition = DerecognitionDetail::find($item->id);
                $derecognition->getReason;
                $derecognition->getDerecognition;
                $derecognition->getDerecognition->getCreatorUser;

                $item->derecognition = $derecognition;
            }

            $asset->certificates = DB::select("SELECT a.id, LPAD(a.id, 6 ,0) AS certificate_number, a.delivered_at, a.received_at, d.display_name AS deliver_user, e.display_name AS receiver_user, f.str_val AS status
            FROM certificates AS a, certi_details AS b, assets AS c, users AS d, users AS e, parameters AS f
            WHERE a.id = b.id_certificate
            AND b.id_asset = c.id
            AND a.id_deliver_user = d.id
            AND a.id_receiver_user = e.id
            AND a.id_status = f.id
            AND b.id_asset = $asset->id
            GROUP BY a.id, certificate_number, a.delivered_at, a.received_at, deliver_user, receiver_user, status
            ORDER BY a.id");
        }

        return $asset;
    }

    public static function getAssetList()
    {
        $assigned = AssetConsts::ASSET_ASSIGNED;

        $assets = DB::select("SELECT a.id, a.asset_number, a.name, 
            f.str_val AS 'group', g.str_val AS 'type', h.str_val AS brand, i.parameter_key AS 'status_key', i.str_val AS 'status',
            b.id_certificate, c.id_status AS id_certificate_status, d.parameter_key AS id_certificate_status_key, d.str_val AS 'certificate_status', IF(i.parameter_key = '$assigned', e.display_name, null) AS user
            FROM assets AS a 
            LEFT JOIN certi_details AS b ON a.id = b.id_asset
            LEFT JOIN certificates AS c ON b.id_certificate = c.id
            LEFT JOIN parameters AS d ON c.id_status = d.id
            LEFT JOIN users AS e ON c.id_receiver_user = e.id,
            parameters AS f, parameters AS g, parameters AS h, parameters AS i
            WHERE a.id_asset_group = f.id
            AND (
                (c.id, a.id) IN (
                    SELECT MAX(id_certificate), id_asset 
                    FROM certi_details 
                    GROUP BY id_asset
                ) 
                    OR c.id IS NULL
                )
            AND a.id_asset_type = g.id
            AND a.id_brand = h.id
            AND a.id_status = i.id
            GROUP BY a.id, a.asset_number, a.name, f.str_val, g.str_val, h.str_val, i.parameter_key, i.str_val, b.id_certificate, c.id_status, d.parameter_key, d.str_val, e.display_name");

        return $assets;
    }

    public static function getAssetOwnList()
    {
        $user_id = User::getAuthUserId();

        $cetificate_status_id = Parameter::getParameterByKey(CertificateConsts::CERTIFICATE_ACTIVE)->id;

        $assets = DB::select("SELECT a.id, a.asset_number, a.name, 
        f.str_val AS 'group', g.str_val AS 'type', h.str_val AS brand, i.str_val AS 'status',
        b.id_certificate, LPAD(b.id_certificate, 6 ,0) AS certificate_number, c.id_status AS id_certificate_status, d.parameter_key AS id_certificate_status_key, d.str_val AS certificate_status, 
        j.display_name AS deliver_user, c.delivered_at, e.display_name AS receiver_user, c.received_at
        FROM assets AS a, certi_details AS b, certificates AS c, parameters AS d, users AS e,
        parameters AS f, parameters AS g, parameters AS h, parameters AS i, users AS j
        WHERE a.id = b.id_asset
        AND b.id_certificate = c.id
        AND c.id_status = $cetificate_status_id
        AND c.id_status = d.id
        AND c.id_receiver_user = e.id
        AND a.id_asset_group = f.id
        AND a.id_asset_type = g.id
        AND a.id_brand = h.id
        AND a.id_status = i.id
        AND c.id_deliver_user = j.id
        AND c.id_receiver_user = $user_id");

        return $assets;
    }

    public function getAssetGroup()
    {
        return $this->belongsTo(Parameter::class, "id_asset_group");
    }

    public function getAssetType()
    {
        return $this->belongsTo(Parameter::class, "id_asset_type");
    }

    public function getBrand()
    {
        return $this->belongsTo(Parameter::class, "id_brand");
    }

    public function getMaintenanceFrequence()
    {
        return $this->belongsTo(Parameter::class, "id_maintenance_frequence");
    }

    public function getStatus()
    {
        return $this->belongsTo(Parameter::class, "id_status");
    }

    public function getPurchaseItem()
    {
        return $this->belongsTo(PurchaseItem::class, "id_purchase_item");
    }

    public function getDepreReval()
    {
        return $this->hasMany(DeprecationRevaluationDetail::class, "id_asset");
    }

    public function getInventories()
    {
        return $this->hasMany(InventoryDetail::class, "id_asset");
    }

    public function getDerecognitions()
    {
        return $this->hasMany(DerecognitionDetail::class, "id_asset");
    }
}
