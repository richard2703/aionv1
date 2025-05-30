<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\SoftDeletes;

class reportes extends Model
{
    use HasFactory;

    use SoftDeletes;

    protected $table = 'reportes';

    protected $fillable = [
        'departamento_id',
        'semana_id',
        'aviso',
        'created_for',
    ];

    public function departamento(): BelongsTo
    {
        return $this->belongsTo(Departamento::class, 'departamento_id', 'id')->withTrashed();
    }
    public function semana(): BelongsTo
    {
        return $this->belongsTo(reporteSemanal::class, 'semana_id', 'id');
    }
    // public function procedimientos()
    // {
    //     return $this->hasMany(Procedimiento::class);
    // }
    public function highlights()
    {
        return $this->hasMany(lights::class, 'reporte_id')->where('tipo', 1);
    }
    public function lowlights()
    {
        return $this->hasMany(lights::class, 'reporte_id')->where('tipo', 0);
    }

    public function avisos()
    {
        return $this->hasMany(avisos::class, 'reporte_id');
    }
    public function kpis()
    {
        //mayuscula KPIs
        return $this->hasMany(Kpis::class, 'departamento_id', 'departamento_id')->where('tipo', 2);
    }

    public function treintas()
    {
        return $this->hasMany(metas::class, 'departamento_id', 'departamento_id')->where('tipo', 1);
    }
    public function sesentas()
    {
        return $this->hasMany(metas::class, 'departamento_id', 'departamento_id')->where('tipo', 2);
    }
    public function noventas()
    {
        return $this->hasMany(metas::class, 'departamento_id', 'departamento_id')->where('tipo', 3);
    }

    public function actividades()
    {
        return $this->hasMany(Accion::class, 'departamento_id', 'departamento_id');
    }
    public function usuario()
    {
        return $this->belongsTo(User::class, 'created_for', 'id');
    }
}
