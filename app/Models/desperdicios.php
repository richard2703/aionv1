<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\SoftDeletes;

class desperdicios extends Model
{
    use HasFactory;

    use SoftDeletes;

    protected $table = 'desperdicios';

    protected $fillable = [
        'area_id',
        'departamento_id',
        'tipoDesperdicio_id',
        'monto',
        'descripcion',
        'rango',
        'recurrencia',
        'detectabilidad',
        'created_for',
    ];

    public function usuario(): BelongsTo
    {
        return $this->belongsTo(User::class, 'created_for', 'id');
    }

    public function departamento(): BelongsTo
    {
        return $this->belongsTo(Departamento::class, 'departamento_id', 'id');
    }

    public function area(): BelongsTo
    {
        return $this->belongsTo(Area::class, 'area_id', 'id');
    }

    public function tipo(): BelongsTo
    {
        return $this->belongsTo(tiposDesperdicios::class, 'tipoDesperdicio_id', 'id');
    }
}
