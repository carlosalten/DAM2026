<?php

namespace App\Http\Controllers;

use App\Http\Requests\StorePilotoRequest;
use App\Http\Requests\UpdatePilotoRequest;
use App\Http\Resources\PilotoResource;
use App\Models\Piloto;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;
use Illuminate\Http\Response;

class PilotoController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(): AnonymousResourceCollection
    {
        return PilotoResource::collection(Piloto::with('equipo')->get());
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(StorePilotoRequest $request): PilotoResource
    {
        $piloto = Piloto::create($request->validated());

        return PilotoResource::make($piloto);
    }

    /**
     * Display the specified resource.
     */
    public function show(Piloto $piloto): PilotoResource
    {
        return PilotoResource::make($piloto->load('equipo'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(UpdatePilotoRequest $request, Piloto $piloto): PilotoResource
    {
        $piloto->update($request->validated());

        return PilotoResource::make($piloto);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Piloto $piloto): Response
    {
        $piloto->delete();

        return response()->noContent();
    }
}
