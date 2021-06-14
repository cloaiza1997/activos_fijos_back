<?php

namespace App\Models;

use App\Models\Parameter;
use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;

/**
 * @class User
 * @namespace App\Models
 * @brief Modelo de usuario
 * @date 01/06/2021
 * @author Cristian Loaiza <cris-1997-loaiza@hotmail.com>
 */
class User extends Authenticatable
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
}
