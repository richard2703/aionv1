<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\SoftDeletes;

class Kpis extends Model
{
    use HasFactory;
    use SoftDeletes;

    protected $table = 'kpis';

    protected $fillable = [
        'titulo',
        'area_id',
        'departamento_id',
        'proceso_id',
        'procedimiento_id',
        'actual',
        'promedio',
        'objetivo',
        'medicion',
        'descripcion',
        'regla', // 0 = baja, 1 = sube
        'tipo', //1 = pilar, 2 = flujo de valor, 3 = proceso, 4 = procedimiento
        'archivado',
    ];

    public function area(): BelongsTo
    {
        return $this->belongsTo(Area::class, 'area_id', 'id');
    }
    public function departamento(): BelongsTo
    {
        return $this->belongsTo(Departamento::class, 'departamento_id', 'id');
    }
    public function proceso(): BelongsTo
    {
        return $this->belongsTo(Proceso::class, 'proceso_id', 'id');
    }
    public function procedimiento(): BelongsTo
    {
        return $this->belongsTo(Procedimiento::class, 'procedimiento_id', 'id');
    }

    public function registros()
    {
        return $this->hasMany(registros_kpi::class, 'kpi_id', 'id');
    }
}
