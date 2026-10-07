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
                ['nombre' => 'Kimi', 'apellido' => 'Antonelli', 'pais' => 'Italia', 'numero' => 12, 'puntos' => 267],
                ['nombre' => 'George', 'apellido' => 'Russell', 'pais' => 'Gran Bretaña', 'numero' => 63, 'puntos' => 201],
            ],
            'Ferrari' => [
                ['nombre' => 'Lewis', 'apellido' => 'Hamilton', 'pais' => 'Gran Bretaña', 'numero' => 44, 'puntos' => 191],
                ['nombre' => 'Charles', 'apellido' => 'Leclerc', 'pais' => 'Mónaco', 'numero' => 16, 'puntos' => 155],
            ],
            'McLaren' => [
                ['nombre' => 'Lando', 'apellido' => 'Norris', 'pais' => 'Gran Bretaña', 'numero' => 1, 'puntos' => 171],
                ['nombre' => 'Oscar', 'apellido' => 'Piastri', 'pais' => 'Australia', 'numero' => 81, 'puntos' => 116],
            ],
            'Red Bull Racing' => [
                ['nombre' => 'Max', 'apellido' => 'Verstappen', 'pais' => 'Países Bajos', 'numero' => 3, 'puntos' => 127],
                ['nombre' => 'Isack', 'apellido' => 'Hadjar', 'pais' => 'Francia', 'numero' => 6, 'puntos' => 71],
            ],
            'Racing Bulls' => [
                ['nombre' => 'Liam', 'apellido' => 'Lawson', 'pais' => 'Nueva Zelanda', 'numero' => 30, 'puntos' => 51],
                ['nombre' => 'Arvid', 'apellido' => 'Lindblad', 'pais' => 'Gran Bretaña', 'numero' => 41, 'puntos' => 29],
            ],
            'Alpine' => [
                ['nombre' => 'Pierre', 'apellido' => 'Gasly', 'pais' => 'Francia', 'numero' => 10, 'puntos' => 41],
                ['nombre' => 'Franco', 'apellido' => 'Colapinto', 'pais' => 'Argentina', 'numero' => 43, 'puntos' => 21],
            ],
            'Haas F1 Team' => [
                ['nombre' => 'Oliver', 'apellido' => 'Bearman', 'pais' => 'Gran Bretaña', 'numero' => 87, 'puntos' => 18],
                ['nombre' => 'Esteban', 'apellido' => 'Ocon', 'pais' => 'Francia', 'numero' => 31, 'puntos' => 3],
            ],
            'Audi' => [
                ['nombre' => 'Gabriel', 'apellido' => 'Bortoleto', 'pais' => 'Brasil', 'numero' => 5, 'puntos' => 10],
                ['nombre' => 'Nico', 'apellido' => 'Hulkenberg', 'pais' => 'Alemania', 'numero' => 27, 'puntos' => 6],
            ],
            'Williams' => [
                ['nombre' => 'Carlos', 'apellido' => 'Sainz', 'pais' => 'España', 'numero' => 55, 'puntos' => 6],
                ['nombre' => 'Alexander', 'apellido' => 'Albon', 'pais' => 'Tailandia', 'numero' => 23, 'puntos' => 5],
            ],
            'Aston Martin' => [
                ['nombre' => 'Fernando', 'apellido' => 'Alonso', 'pais' => 'España', 'numero' => 14, 'puntos' => 3],
                ['nombre' => 'Lance', 'apellido' => 'Stroll', 'pais' => 'Canadá', 'numero' => 18, 'puntos' => 0],
            ],
            'Cadillac' => [
                ['nombre' => 'Sergio', 'apellido' => 'Perez', 'pais' => 'México', 'numero' => 11, 'puntos' => 0],
                ['nombre' => 'Valtteri', 'apellido' => 'Bottas', 'pais' => 'Finlandia', 'numero' => 77, 'puntos' => 0],
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
