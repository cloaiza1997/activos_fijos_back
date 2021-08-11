<?php

namespace App\Models;

use App\Constants\PurchaseConsts;
use App\Models\Parameter;
use App\Models\Provider;
use App\Models\PurchaseItem;
use App\Models\User;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

/**
 * @class Purchase
 * @namespace App\Models
 * @brief Modelo de compra
 * @date 01/06/2021
 * @author Cristian Loaiza <cris-1997-loaiza@hotmail.com>
 */
class Purchase extends Model
{
    use HasFactory;

    protected $table = "purchases";

    protected $fillable = [
        "id_provider",
        "id_requesting_user",
        "delivery_date",
        "delivery_address",
        "id_city",
        "sub_total",
        "iva",
        "total",
        "id_status",
        "id_payment_method",
        "payment_days",
        "observations",
        "id_creator_user",
        "id_approver_user",
        "approved_at",
        "id_updater_user"
    ];

    public static function getPurchase($id)
    {
        $purchase = Purchase::find($id);

        if ($purchase) {
            $purchase->approver_user = $purchase->getApproverUser;
            $purchase->city = $purchase->getCity;
            $purchase->creator_user = $purchase->getCreatorUser;
            $purchase->items = $purchase->getPurchaseItems;
            $purchase->payment_method = $purchase->getPaymentMethod;
            $purchase->provider = $purchase->getProvider;
            $purchase->provider->city = $purchase->getProvider->getCity;
            $purchase->requesting_user = $purchase->getRequestingUser;
            $purchase->requesting_user->area = $purchase->getRequestingUser->getArea;
            $purchase->status = $purchase->getStatus;
            $purchase->updater_user = $purchase->getUpdaterUser;
        }

        return $purchase;
    }

    public static function getPurchaseList()
    {
        $purchases = DB::select("SELECT a.id, LPAD(a.id, 8 ,0) consecutive, b.str_val status, 
        DATE_FORMAT(a.created_at, '%Y-%m-%d') created_at, a.delivery_date, a.total, c.str_val payment_method, d.name provider, COUNT(a.id) items
        FROM purchases AS a, parameters AS b, parameters AS c, providers AS d, purch_items AS e
        WHERE a.id_status = b.id 
        AND a.id_payment_method = c.id 
        AND a.id_provider = d.id
        AND a.id = e.id_purchase
        GROUP BY a.id, consecutive, status, created_at, a.delivery_date, a.total, payment_method, provider");

        return $purchases;
    }

    public static function getPurchaseListToApprove()
    {
        $status_id = Parameter::getParameterByKey(PurchaseConsts::PURCHASE_STATUS_CHECKING)->id;

        $purchases = DB::select("SELECT a.id, LPAD(a.id, 8 ,0) consecutive, b.str_val status, 
        DATE_FORMAT(a.created_at, '%Y-%m-%d') created_at, a.delivery_date, a.total, c.str_val payment_method, d.name provider, f.display_name creator, COUNT(a.id) items
        FROM purchases AS a, parameters AS b, parameters AS c, providers AS d, purch_items AS e, users AS f
        WHERE a.id_status = b.id 
        AND a.id_payment_method = c.id 
        AND a.id_provider = d.id
        AND a.id = e.id_purchase
        AND a.id_creator_user = f.id
        AND a.id_status = $status_id
        GROUP BY a.id, consecutive, status, created_at, a.delivery_date, a.total, payment_method, provider, f.display_name");

        return $purchases;
    }

    public static function getPurchaseListByStatus($status, $with_items = true)
    {
        $status_id = Parameter::getParameterByKey($status)->id;

        $purchases = Purchase::where("id_status", $status_id)->get([
            "id",
            DB::raw('LPAD(id, 8 ,0) consecutive'),
            "id_provider",
            "id_requesting_user",
            "delivery_date",
            "delivery_address",
            "id_city",
            "sub_total",
            "iva",
            "total",
            "id_status",
            "id_payment_method",
            "payment_days",
            "observations",
            "id_creator_user",
            "created_at",
            "id_approver_user",
            "approved_at",
            "id_updater_user",
            "updated_at",
        ]);

        if ($with_items) {
            foreach ($purchases as $purchase) {
                $purchase->getPurchaseItems;
            }
        }

        return $purchases;
    }

    public function getPurchaseItems()
    {
        return $this->hasMany(PurchaseItem::class, 'id_purchase');
    }

    public function getProvider()
    {
        return $this->belongsTo(Provider::class, "id_provider");
    }

    public function getRequestingUser()
    {
        return $this->belongsTo(User::class, "id_requesting_user");
    }

    public function getStatus()
    {
        return $this->belongsTo(Parameter::class, "id_status");
    }

    public function getCity()
    {
        return $this->belongsTo(Parameter::class, "id_city");
    }

    public function getPaymentMethod()
    {
        return $this->belongsTo(Parameter::class, "id_payment_method");
    }

    public function getCreatorUser()
    {
        return $this->belongsTo(User::class, "id_creator_user");
    }

    public function getApproverUser()
    {
        return $this->belongsTo(User::class, "id_approver_user");
    }

    public function getUpdaterUser()
    {
        return $this->belongsTo(User::class, "id_updater_user");
    }
}
