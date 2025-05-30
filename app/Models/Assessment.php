<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\SoftDeletes;

class Assessment extends Model
{
    use HasFactory;
    // use SoftDeletes;

    protected $table = 'assessments';

    protected $fillable = [
        'titulo',
        'descripcion',
        'created_by',
    ];

    public function AssessmentAsignado(): HasMany
    {
        return $this->hasMany(AssessmentAsignado::class, 'assessment_id', 'id');
    }
}
