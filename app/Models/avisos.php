<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\SoftDeletes;

class avisos extends Model
{
    use HasFactory;

    use SoftDeletes;

    protected $table = 'avisos';

    protected $fillable = [
        'departamento_id',
        'semana_id',
        'reporte_id',
        'aviso',
        'created_for',
    ];

    public function reporte(): BelongsTo
    {
        return $this->belongsTo(reportes::class, 'reporte_id', 'id');
    }
    // public function procedimientos()
    // {
    //     return $this->hasMany(Procedimiento::class);
    // }
}
