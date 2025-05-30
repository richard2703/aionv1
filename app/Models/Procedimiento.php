<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\SoftDeletes;

class Procedimiento extends Model
{
    use HasFactory;
    use SoftDeletes;

    protected $table = 'procedimientos';

    protected $fillable = [
        'proceso_id',
        'nombre',
        'descripcion',
        'link_externo',
        'link_herramienta',
    ];

    public function proceso(): BelongsTo
    {
        return $this->belongsTo(Proceso::class, 'proceso_id', 'id');
    }
}
