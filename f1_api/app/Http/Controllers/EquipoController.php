<?php

namespace App\Http\Controllers;

use App\Http\Requests\StoreEquipoRequest;
use App\Http\Requests\UpdateEquipoRequest;
use App\Http\Resources\EquipoResource;
use App\Models\Equipo;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;
use Illuminate\Http\Response;

class EquipoController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(): AnonymousResourceCollection
    {
        return EquipoResource::collection(Equipo::all());
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(StoreEquipoRequest $request): EquipoResource
    {
        $equipo = Equipo::create($request->validated());

        return EquipoResource::make($equipo);
    }

    /**
     * Display the specified resource.
     */
    public function show(Equipo $equipo): EquipoResource
    {
        return EquipoResource::make($equipo->load('pilotos'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(UpdateEquipoRequest $request, Equipo $equipo): EquipoResource
    {
        $equipo->update($request->validated());

        return EquipoResource::make($equipo);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Equipo $equipo): Response
    {
        $equipo->delete();

        return response()->noContent();
    }
}
