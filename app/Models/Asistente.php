<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Asistente extends Model
{
    use HasFactory;

    protected $table = 'minutas_asistentes';

    protected $fillable = [
        'minuta_id',
        'user_id',
    ];

    public function minuta()
    {
        return $this->belongsTo(minutas::class);
    }

    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
