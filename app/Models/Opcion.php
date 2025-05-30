<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\SoftDeletes;

class Opcion extends Model
{
    use HasFactory;
    use SoftDeletes;

    protected $table = 'opciones';

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'challenge_id',
        'madurez',
        'formal',
        'informal',
    ];

    public function challenge(): BelongsTo
    {
        return $this->belongsTo(Challenge::class, 'challenge_id', 'id');
    }
}
