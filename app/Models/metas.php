<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\SoftDeletes;

class metas extends Model
{
    use HasFactory;

    protected $table = 'metas';

    protected $fillable = [
        'departamento_id',
        'trimestre_id',
        'metaFlujo_id',
        'tipo',
        'meta',
        'created_for',
        'status',
    ];

    public function metaflujo(): BelongsTo
    {
        return $this->belongsTo(metaflujos::class, 'metaFlujo_id', 'id');
    }
}
