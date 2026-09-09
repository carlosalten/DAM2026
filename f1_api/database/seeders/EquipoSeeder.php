<?php

namespace Database\Seeders;

use App\Models\Equipo;
use Illuminate\Database\Seeder;

class EquipoSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * Equipos de la temporada 2026 de Fórmula 1 (formula1.com/en/teams).
     */
    public function run(): void
    {
        $equipos = [
            ['nombre' => 'Mercedes', 'jefe' => 'Toto Wolff', 'pais' => 'Alemania', 'color' => '27F4D2'],
            ['nombre' => 'Ferrari', 'jefe' => 'Fred Vasseur', 'pais' => 'Italia', 'color' => 'E8002D'],
            ['nombre' => 'McLaren', 'jefe' => 'Andrea Stella', 'pais' => 'Reino Unido', 'color' => 'FF8000'],
            ['nombre' => 'Red Bull Racing', 'jefe' => 'Laurent Mekies', 'pais' => 'Austria', 'color' => '3671C6'],
            ['nombre' => 'Racing Bulls', 'jefe' => 'Alan Permane', 'pais' => 'Italia', 'color' => '6692FF'],
            ['nombre' => 'Alpine', 'jefe' => 'Flavio Briatore', 'pais' => 'Francia', 'color' => '00A1E8'],
            ['nombre' => 'Haas F1 Team', 'jefe' => 'Ayao Komatsu', 'pais' => 'Estados Unidos', 'color' => '000000'],
            ['nombre' => 'Audi', 'jefe' => 'Mattia Binotto', 'pais' => 'Alemania', 'color' => 'FF2D00'],
            ['nombre' => 'Williams', 'jefe' => 'James Vowles', 'pais' => 'Reino Unido', 'color' => '1868DB'],
            ['nombre' => 'Aston Martin', 'jefe' => 'Adrian Newey', 'pais' => 'Reino Unido', 'color' => '229971'],
            ['nombre' => 'Cadillac', 'jefe' => 'Marcin Budkowski', 'pais' => 'Estados Unidos', 'color' => 'AAAAAD'],
        ];

        foreach ($equipos as $equipo) {
            Equipo::create($equipo);
        }
    }
}
