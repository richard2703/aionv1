<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\SoftDeletes;

class Seccion extends Model
{
    use HasFactory;
    // use SoftDeletes;

    protected $table = 'secciones';

    protected $fillable = [
        'area_id',
        'departamento_id',
        'titulo',
        'created_by',
    ];


    public function challenge(): HasMany
    {
        return $this->hasMany(Challenge::class, 'seccion_id', 'id');
    }

    public function area(): BelongsTo
    {
        return $this->belongsTo(Area::class, 'area_id', 'id');
    }

    public function departamento(): BelongsTo
    {
        return $this->belongsTo(Departamento::class, 'departamento_id', 'id');
    }

    public function departamentoEvaluacion(): HasMany
    {
        return $this->hasMany(DepartamentoEvaluacion::class, 'seccion_id', 'id');
    }
}
