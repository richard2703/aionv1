<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Empresa extends Model
{
    use HasFactory;

    protected $table = 'empresa';

    protected $fillable = [
        'membresia_id',
        'nombre',
        'direccion',
        'ciudad',
        'estado',
        'cp',
        'pais',
        'telefono',
        'sitio_web',
    ];

    public function membresia()
    {
        return $this->belongsTo(Membresia::class, 'membresia_id', 'id');
    }
}
