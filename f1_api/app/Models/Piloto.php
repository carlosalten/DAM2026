<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Piloto extends Model
{
    public $timestamps = false;

    protected $fillable = ['nombre', 'apellido', 'pais', 'puntos', 'equipo_id'];

    public function equipo(): BelongsTo
    {
        return $this->belongsTo(Equipo::class);
    }
}
