<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class tareaEvidencia extends Model
{
    use HasFactory;

    protected $table = 'tarea_evidencia';

    protected $fillable = [
        'tarea_id',
        'img_ref',
        'created_for',
    ];

    public function tarea()
    {
        return $this->belongsTo(tareas::class, 'tarea_id', 'id');
    }
}
