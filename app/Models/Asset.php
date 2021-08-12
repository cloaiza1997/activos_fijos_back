<?php

namespace App\Models;

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
        "current_value",
        "use_life",
        "id_maintenance_frequence",
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
        }

        return $asset;
    }

    public static function getAssetList()
    {
        $cetificate_status_id = Parameter::getParameterByKey(CertificateConsts::CERTIFICATE_ACTIVE)->id;

        $assets = DB::select("SELECT a.id, a.asset_number, a.name, 
        f.str_val AS 'group', g.str_val AS 'type', h.str_val AS brand, i.str_val AS 'status',
        b.id_certificate, c.id_status AS id_certificate_status, d.parameter_key AS id_certificate_status_key, d.str_val AS certificate_status, e.display_name AS user
        FROM assets AS a 
        LEFT JOIN certi_details AS b ON a.id = b.id_asset
        LEFT JOIN certificates AS c ON b.id_certificate = c.id
        LEFT JOIN parameters AS d ON c.id_status = d.id
        LEFT JOIN users AS e ON c.id_receiver_user = e.id,
        parameters AS f, parameters AS g, parameters AS h, parameters AS i
        WHERE (c.id_status = $cetificate_status_id OR c.id_status IS NULL)
        AND a.id_asset_group = f.id
        AND a.id_asset_type = g.id
        AND a.id_brand = h.id
        AND a.id_status = i.id");

        return $assets;
    }

    public static function getAssetOwnList()
    {
        $user_id = User::getAuthUserId();

        $assets = DB::select("SELECT a.id, a.asset_number, a.name, 
        f.str_val AS 'group', g.str_val AS 'type', h.str_val AS brand, i.str_val AS 'status',
        b.id_certificate, LPAD(b.id_certificate, 6 ,0) AS certificate_number, c.id_status AS id_certificate_status, d.parameter_key AS id_certificate_status_key, d.str_val AS certificate_status, 
        j.display_name AS deliver_user, c.delivered_at, e.display_name AS receiver_user, c.received_at
        FROM assets AS a, certi_details AS b, certificates AS c, parameters AS d, users AS e,
        parameters AS f, parameters AS g, parameters AS h, parameters AS i, users AS j
        WHERE a.id = b.id_asset
        AND b.id_certificate = c.id
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
}
