<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\SoftDeletes;

class registros_kpi extends Model
{
    use HasFactory;
    use SoftDeletes;

    protected $table = 'registros_kpi';

    protected $fillable = [
        'kpi_id',
        'actual',
        'objetivo',
        'medicion',
        'regla', // 1 = subir, 0 = bajar
        'created_for',
        'created_at',
        'updated_at',
        'deleted_at',
    ];

    public function kpis(): BelongsTo
    {
        return $this->belongsTo(kpis::class, 'kpi_id', 'id');
    }
}
