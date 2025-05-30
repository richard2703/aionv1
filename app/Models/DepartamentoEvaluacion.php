<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class DepartamentoEvaluacion extends Model
{
    use HasFactory;

    protected $table = 'departamento_evaluacion';

    protected $fillable = [
        'assessment_id',
        'departamento_id',
        'seccion_id',
        'score',
        'feedback',
    ];

    public function assessment(): BelongsTo
    {
        return $this->belongsTo(Assessment::class, 'assessment_id', 'id');
    }

    public function departamento(): BelongsTo
    {
        return $this->belongsTo(Departamento::class, 'departamento_id', 'id');
    }

    function seccion()
    {
        return $this->belongsTo(Seccion::class, 'seccion_id', 'id');
    }
}
