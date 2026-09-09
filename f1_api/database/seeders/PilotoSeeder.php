<?php

namespace Database\Seeders;

use App\Models\Equipo;
use App\Models\Piloto;
use Illuminate\Database\Seeder;

class PilotoSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * Pilotos de la temporada 2026 de Fórmula 1 (formula1.com/en/drivers),
     */
    public function run(): void
    {
        $pilotos = [
            'Mercedes' => [
                ['nombre' => 'Kimi', 'apellido' => 'Antonelli', 'pais' => 'Italia', 'puntos' => 267],
                ['nombre' => 'George', 'apellido' => 'Russell', 'pais' => 'Gran Bretaña', 'puntos' => 201],
            ],
            'Ferrari' => [
                ['nombre' => 'Lewis', 'apellido' => 'Hamilton', 'pais' => 'Gran Bretaña', 'puntos' => 191],
                ['nombre' => 'Charles', 'apellido' => 'Leclerc', 'pais' => 'Mónaco', 'puntos' => 155],
            ],
            'McLaren' => [
                ['nombre' => 'Lando', 'apellido' => 'Norris', 'pais' => 'Gran Bretaña', 'puntos' => 171],
                ['nombre' => 'Oscar', 'apellido' => 'Piastri', 'pais' => 'Australia', 'puntos' => 116],
            ],
            'Red Bull Racing' => [
                ['nombre' => 'Max', 'apellido' => 'Verstappen', 'pais' => 'Países Bajos', 'puntos' => 127],
                ['nombre' => 'Isack', 'apellido' => 'Hadjar', 'pais' => 'Francia', 'puntos' => 71],
            ],
            'Racing Bulls' => [
                ['nombre' => 'Liam', 'apellido' => 'Lawson', 'pais' => 'Nueva Zelanda', 'puntos' => 51],
                ['nombre' => 'Arvid', 'apellido' => 'Lindblad', 'pais' => 'Gran Bretaña', 'puntos' => 29],
            ],
            'Alpine' => [
                ['nombre' => 'Pierre', 'apellido' => 'Gasly', 'pais' => 'Francia', 'puntos' => 41],
                ['nombre' => 'Franco', 'apellido' => 'Colapinto', 'pais' => 'Argentina', 'puntos' => 21],
            ],
            'Haas F1 Team' => [
                ['nombre' => 'Oliver', 'apellido' => 'Bearman', 'pais' => 'Gran Bretaña', 'puntos' => 18],
                ['nombre' => 'Esteban', 'apellido' => 'Ocon', 'pais' => 'Francia', 'puntos' => 3],
            ],
            'Audi' => [
                ['nombre' => 'Gabriel', 'apellido' => 'Bortoleto', 'pais' => 'Brasil', 'puntos' => 10],
                ['nombre' => 'Nico', 'apellido' => 'Hulkenberg', 'pais' => 'Alemania', 'puntos' => 6],
            ],
            'Williams' => [
                ['nombre' => 'Carlos', 'apellido' => 'Sainz', 'pais' => 'España', 'puntos' => 6],
                ['nombre' => 'Alexander', 'apellido' => 'Albon', 'pais' => 'Tailandia', 'puntos' => 5],
            ],
            'Aston Martin' => [
                ['nombre' => 'Fernando', 'apellido' => 'Alonso', 'pais' => 'España', 'puntos' => 3],
                ['nombre' => 'Lance', 'apellido' => 'Stroll', 'pais' => 'Canadá', 'puntos' => 0],
            ],
            'Cadillac' => [
                ['nombre' => 'Sergio', 'apellido' => 'Perez', 'pais' => 'México', 'puntos' => 0],
                ['nombre' => 'Valtteri', 'apellido' => 'Bottas', 'pais' => 'Finlandia', 'puntos' => 0],
            ],
        ];

        foreach ($pilotos as $equipoNombre => $listaPilotos) {
            $equipo = Equipo::where('nombre', $equipoNombre)->firstOrFail();

            foreach ($listaPilotos as $piloto) {
                Piloto::create([...$piloto, 'equipo_id' => $equipo->id]);
            }
        }
    }
}
