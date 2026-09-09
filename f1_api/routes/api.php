<?php

use App\Http\Controllers\EquipoController;
use App\Http\Controllers\PilotoController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

Route::apiResource('equipos', EquipoController::class);
Route::apiResource('pilotos', PilotoController::class);
