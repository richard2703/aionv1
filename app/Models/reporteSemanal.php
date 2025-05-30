<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\SoftDeletes;

class reporteSemanal extends Model
{
    use HasFactory;
    use SoftDeletes;

    protected $table = 'reporteSemanal';

    protected $fillable = [
        'numeroSemana',
        'inicio',
        'fin',
    ];

    // public function departamento(): BelongsTo
    // {
    //     return $this->belongsTo(Departamento::class, 'departamento_id', 'id');
    // }
    // public function procedimientos()
    // {
    //     return $this->hasMany(Procedimiento::class);
    // }
}
