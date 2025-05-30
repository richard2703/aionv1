<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TipoMinuta extends Model
{
    use HasFactory;

    protected $table = 'tipos_minuta';

    public $fillable = [
        'titulo',
        'definicion',
    ];

    // function minuta()
    // {
    //     return $this->belongsTo(minutas::class, 'minuta_id', 'id')->withTrashed();
    // }
}
