<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ComentarioMencion extends Model
{
    use HasFactory;
    protected $table = "comentario_menciones";
    protected $fillable = ['comentario_id', 'user_id'];

    public function comentario()
    {
        return $this->belongsTo(Comentario::class, 'comentario_id');
    }

    public function usuario()
    {
        return $this->belongsTo(User::class, 'user_id');
    }
}
