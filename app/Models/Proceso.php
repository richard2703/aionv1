<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\SoftDeletes;

class Proceso extends Model
{
    use HasFactory;
    use SoftDeletes;

    protected $table = 'procesos';

    protected $fillable = [
        'area_id',
        'departamento_id',
        'nombre',
        'descripcion',
        'link_externo',
        'link_herramienta',
    ];

    public function area(): BelongsTo
    {
        return $this->belongsTo(Area::class, 'area_id', 'id');
    }

    public function departamento(): BelongsTo
    {
        return $this->belongsTo(Departamento::class, 'departamento_id', 'id');
    }
    public function procedimientos()
    {
        return $this->hasMany(Procedimiento::class);
    }

    public function kpis()
    {
        return $this->hasMany(Kpis::class);
    }
}
