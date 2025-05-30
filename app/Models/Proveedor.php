<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Proveedor extends Model
{
    use HasFactory;
    use SoftDeletes;

    protected $table = 'proveedores';

    protected $fillable = [
        'area_id',
        'proceso_id',
        'nombre',
        'servicio',
        'pagina_web',
        'link_orden',
        'telefono',
        'correo',
        'info',
        'video',
    ];

    public function area()
    {
        return $this->belongsTo(Area::class, 'area_id', 'id')->withTrashed();
    }

    public function proceso()
    {
        return $this->belongsTo(Proceso::class, 'proceso_id', 'id')->withTrashed();
    }
}
