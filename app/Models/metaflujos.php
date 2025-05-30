<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\SoftDeletes;

class metaflujos extends Model
{
    use HasFactory;

    use SoftDeletes;

    protected $table = 'metaflujos';

    protected $fillable = [
        'departamento_id',
        'trimestre_id',
        'created_for',
    ];

    public function departamento(): BelongsTo
    {
        return $this->belongsTo(Departamento::class, 'departamento_id', 'id')->withTrashed();
    }
    public function trimestre(): BelongsTo
    {
        return $this->belongsTo(metatrimestres::class, 'trimestre_id', 'id');
    }
    // public function procedimientos()
    // {
    //     return $this->hasMany(Procedimiento::class);
    // }
    public function treintas()
    {
        return $this->hasMany(metas::class, 'metaFlujo_id')->where('tipo', 1);
    }
    public function sesentas()
    {
        return $this->hasMany(metas::class, 'metaFlujo_id')->where('tipo', 2);
    }
    public function noventas()
    {
        return $this->hasMany(metas::class, 'metaFlujo_id')->where('tipo', 3);
    }

    // public function avisos()
    // {
    //     return $this->hasMany(avisos::class, 'reporte_id');
    // }
    // public function kpis()
    // {
    //     //mayuscula KPIs
    //     return $this->hasMany(Kpis::class, 'departamento_id', 'departamento_id');
    // }
}
