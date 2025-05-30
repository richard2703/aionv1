<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Comentario extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'reporte_semanal_id',
        'texto',
    ];

    public function reporte()
    {
        return $this->belongsTo(reporteSemanal::class, 'reporte_semanal_id', 'id');
    }

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id', 'id');
    }

    public function menciones()
    {
        return $this->hasMany(ComentarioMencion::class);
    }
}
