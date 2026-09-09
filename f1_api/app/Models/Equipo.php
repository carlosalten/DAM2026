<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Equipo extends Model
{
    public $timestamps = false;

    protected $fillable = ['nombre', 'jefe', 'pais', 'color'];

    public function pilotos(): HasMany
    {
        return $this->hasMany(Piloto::class);
    }
}
