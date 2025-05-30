<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\SoftDeletes;


class tareas extends Model
{
    use HasFactory;
    use SoftDeletes;

    protected $table = 'tareas';

    protected $fillable = [
        'area_id',
        'departamento_id',
        'minuta_id',
        'responsable_id',
        'estatus_id',
        'revisor_id',
        'tarea',
        'fecha',
        'nota',
        'validacion',
    ];

    public function area(): BelongsTo
    {
        return $this->belongsTo(Area::class, 'area_id', 'id')->withTrashed();
    }

    public function departamento(): BelongsTo
    {
        return $this->belongsTo(Departamento::class, 'departamento_id', 'id')->withTrashed();
    }

    public function minuta(): BelongsTo
    {
        return $this->belongsTo(minutas::class, 'minuta_id', 'id')->withTrashed();
    }

    public function responsable(): BelongsTo
    {
        return $this->belongsTo(User::class, 'responsable_id', 'id')->withTrashed();
    }

    public function revisor(): BelongsTo
    {
        return $this->belongsTo(User::class, 'revisor_id', 'id')->withTrashed();
    }

    public function estatus()
    {
        return $this->belongsTo(Estatus::class, 'estatus_id', 'id');
    }

    public function evidencia()
    {
        return $this->hasMany(tareaEvidencia::class, 'tarea_id', 'id');
    }
}
