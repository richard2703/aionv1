<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Personalizar extends Model
{
    use HasFactory;
    use SoftDeletes;

    protected $table = 'personalizar';

    protected $fillable = [
        'proposito',
        'slogan',
        'actuacion',
        'logo',
        'banner',
        'portada',
        'titulo_evento',
        'nombre_negocio',
    ];
}
