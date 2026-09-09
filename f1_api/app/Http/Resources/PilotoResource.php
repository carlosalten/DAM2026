<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class PilotoResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'nombre' => $this->nombre,
            'apellido' => $this->apellido,
            'pais' => $this->pais,
            'puntos' => $this->puntos,
            'equipo_id' => $this->equipo_id,
            'equipo' => EquipoResource::make($this->whenLoaded('equipo')),
        ];
    }
}
