<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Accion extends Model
{
    use HasFactory;

    protected $table = 'acciones';

    protected $fillable = [
        'id',
        'tipo_id',
        'area_id',
        'departamento_id',
        'proceso_id',
        'estatus_id',
        'responsable_id',
        'titulo',
        'link',
    ];

    public function area()
    {
        return $this->belongsTo(Area::class, 'area_id');
    }

    public function proceso()
    {
        return $this->belongsTo(Proceso::class, 'proceso_id');
    }

    public function tipo()
    {
        return $this->belongsTo(TipoAccion::class, 'tipo_id');
    }

    public function responsable()
    {
        return $this->belongsTo(User::class, 'responsable_id');
    }

    public function estatus()
    {
        return $this->belongsTo(Estatus::class, 'estatus_id');
    }
}
