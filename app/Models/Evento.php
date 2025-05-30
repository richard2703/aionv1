<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Evento extends Model
{
    use HasFactory;

    protected $fillable = [
        'area_id',
        'titulo',
        'descripcion',
        'fecha_inicio',
        'fecha_final',
        'recurrencia',        // 'none', 'daily', 'weekly', 'monthly'
        'dia_semana',         // Solo para eventos semanales (0 = Domingo, 6 = Sábado)
        'dia_mes',            // Solo para eventos mensuales (1-31, first_monday, last_friday)
        'num_repeticiones',   // Cantidad de repeticiones
        'ubicacion',
        'link',
    ];

    function area(): BelongsTo
    {
        return $this->belongsTo(Area::class, 'area_id', 'id');
    }
}
