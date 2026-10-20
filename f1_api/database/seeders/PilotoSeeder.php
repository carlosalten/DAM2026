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
                ['nombre' => 'Kimi', 'apellido' => 'Antonelli', 'pais' => 'Italia', 'nacimiento' => '2006-08-25', 'numero' => 12, 'puntos' => 267],
                ['nombre' => 'George', 'apellido' => 'Russell', 'pais' => 'Gran Bretaña', 'nacimiento' => '1998-02-15', 'numero' => 63, 'puntos' => 201],
            ],
            'Ferrari' => [
                ['nombre' => 'Lewis', 'apellido' => 'Hamilton', 'pais' => 'Gran Bretaña', 'nacimiento' => '1985-01-07', 'numero' => 44, 'puntos' => 191],
                ['nombre' => 'Charles', 'apellido' => 'Leclerc', 'pais' => 'Mónaco', 'nacimiento' => '1997-10-16', 'numero' => 16, 'puntos' => 155],
            ],
            'McLaren' => [
                ['nombre' => 'Lando', 'apellido' => 'Norris', 'pais' => 'Gran Bretaña', 'nacimiento' => '1999-11-13', 'numero' => 1, 'puntos' => 171],
                ['nombre' => 'Oscar', 'apellido' => 'Piastri', 'pais' => 'Australia', 'nacimiento' => '2001-04-06', 'numero' => 81, 'puntos' => 116],
            ],
            'Red Bull Racing' => [
                ['nombre' => 'Max', 'apellido' => 'Verstappen', 'pais' => 'Países Bajos', 'nacimiento' => '1997-09-30', 'numero' => 3, 'puntos' => 127],
                ['nombre' => 'Isack', 'apellido' => 'Hadjar', 'pais' => 'Francia', 'nacimiento' => '2004-09-28', 'numero' => 6, 'puntos' => 71],
            ],
            'Racing Bulls' => [
                ['nombre' => 'Liam', 'apellido' => 'Lawson', 'pais' => 'Nueva Zelanda', 'nacimiento' => '2002-02-11', 'numero' => 30, 'puntos' => 51],
                ['nombre' => 'Arvid', 'apellido' => 'Lindblad', 'pais' => 'Gran Bretaña', 'nacimiento' => '2007-08-08', 'numero' => 41, 'puntos' => 29],
            ],
            'Alpine' => [
                ['nombre' => 'Pierre', 'apellido' => 'Gasly', 'pais' => 'Francia', 'nacimiento' => '1996-02-07', 'numero' => 10, 'puntos' => 41],
                ['nombre' => 'Franco', 'apellido' => 'Colapinto', 'pais' => 'Argentina', 'nacimiento' => '2003-05-27', 'numero' => 43, 'puntos' => 21],
            ],
            'Haas F1 Team' => [
                ['nombre' => 'Oliver', 'apellido' => 'Bearman', 'pais' => 'Gran Bretaña', 'nacimiento' => '2005-05-08', 'numero' => 87, 'puntos' => 18],
                ['nombre' => 'Esteban', 'apellido' => 'Ocon', 'pais' => 'Francia', 'nacimiento' => '1996-09-17', 'numero' => 31, 'puntos' => 3],
            ],
            'Audi' => [
                ['nombre' => 'Gabriel', 'apellido' => 'Bortoleto', 'pais' => 'Brasil', 'nacimiento' => '2004-10-14', 'numero' => 5, 'puntos' => 10],
                ['nombre' => 'Nico', 'apellido' => 'Hulkenberg', 'pais' => 'Alemania', 'nacimiento' => '1987-08-19', 'numero' => 27, 'puntos' => 6],
            ],
            'Williams' => [
                ['nombre' => 'Carlos', 'apellido' => 'Sainz', 'pais' => 'España', 'nacimiento' => '1994-09-01', 'numero' => 55, 'puntos' => 6],
                ['nombre' => 'Alexander', 'apellido' => 'Albon', 'pais' => 'Tailandia', 'nacimiento' => '1996-03-23', 'numero' => 23, 'puntos' => 5],
            ],
            'Aston Martin' => [
                ['nombre' => 'Fernando', 'apellido' => 'Alonso', 'pais' => 'España', 'nacimiento' => '1981-07-29', 'numero' => 14, 'puntos' => 3],
                ['nombre' => 'Lance', 'apellido' => 'Stroll', 'pais' => 'Canadá', 'nacimiento' => '1998-10-29', 'numero' => 18, 'puntos' => 0],
            ],
            'Cadillac' => [
                ['nombre' => 'Sergio', 'apellido' => 'Perez', 'pais' => 'México', 'nacimiento' => '1990-01-26', 'numero' => 11, 'puntos' => 0],
                ['nombre' => 'Valtteri', 'apellido' => 'Bottas', 'pais' => 'Finlandia', 'nacimiento' => '1989-08-28', 'numero' => 77, 'puntos' => 0],
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
