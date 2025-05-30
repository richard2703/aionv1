<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Respuesta extends Model
{
    use HasFactory;

    protected $table = 'respuestas';

    protected $fillable = [
        'assessment_id',
        'seccion_id',
        'area_id',
        'departamento_id',
        'seccion_id',
        'challenge_id',
        'opcion_id',
        'valor_opcion'
    ];

    public function assessment(): BelongsTo
    {
        return $this->belongsTo(Assessment::class, 'assessment_id', 'id');
    }

    public function seccion(): BelongsTo
    {
        return $this->belongsTo(Seccion::class, 'seccion_id', 'id');
    }
}
