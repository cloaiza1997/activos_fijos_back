<?php

namespace App\Models;

use App\Models\Parameter;
use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Tymon\JWTAuth\Contracts\JWTSubject;

/**
 * @class User
 * @namespace App\Models
 * @brief Modelo de usuario
 * @date 01/06/2021
 * @author Cristian Loaiza <cris-1997-loaiza@hotmail.com>
 */
class User extends Authenticatable implements JWTSubject
{
    use HasFactory, Notifiable;

    // /**
    //  * The attributes that are mass assignable.
    //  *
    //  * @var array
    //  */
    // protected $fillable = [
    //     'name',
    //     'email',
    //     'password',
    // ];

    // /**
    //  * The attributes that should be hidden for arrays.
    //  *
    //  * @var array
    //  */
    // protected $hidden = [
    //     'password',
    //     'remember_token',
    // ];

    // /**
    //  * The attributes that should be cast to native types.
    //  *
    //  * @var array
    //  */
    // protected $casts = [
    //     'email_verified_at' => 'datetime',
    // ];

    protected $table = "users";

    protected $fillable = [
        "id_document_type",
        "document_number",
        "name",
        "last_name",
        "display_name",
        "email",
        "phone_number",
        "password",
        "must_change_password",
        "id_role",
        "id_area",
        "id_position",
        "id_status",
    ];

    protected $hidden = [
        'password',
        'remember_token',
    ];

    public function getDocumentType()
    {
        return $this->belongsTo(Parameter::class, "id_document_type");
    }

    public function getRole()
    {
        return $this->belongsTo(Parameter::class, "id_role");
    }

    public function getArea()
    {
        return $this->belongsTo(Parameter::class, "id_area");
    }

    public function getPosition()
    {
        return $this->belongsTo(Parameter::class, "id_position");
    }

    public function getStatus()
    {
        return $this->belongsTo(Parameter::class, "id_status");
    }

    /**
     * Consulta el usuario logueado
     *
     * @return object User logueado
     */
    public static function getAuthUser()
    {
        $user = User::find(User::getAuthUserId());

        $user = $user;
        $user->document_type = $user->getDocumentType->str_val;
        $user->role = $user->getRole->str_val;
        $user->area = $user->getArea->str_val;
        $user->position = $user->getPosition->str_val;
        $user->status = $user->getStatus->str_val;

        return $user;
    }

    /**
     * Consulta el id usuario logueado
     *
     * @return number Id del usuario logueado
     */
    public static function getAuthUserId()
    {
        $user = auth()->user();

        return $user ? $user->id : null;
    }

    /**
     * Get the identifier that will be stored in the subject claim of the JWT.
     *
     * @return mixed
     */
    public function getJWTIdentifier()
    {
        return $this->getKey();
    }

    /**
     * Return a key value array, containing any custom claims to be added to the JWT.
     *
     * @return array
     */
    public function getJWTCustomClaims()
    {
        return [];
    }
}
