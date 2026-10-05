<?php

namespace App\Http\Requests;

use App\Models\Piloto;
use Illuminate\Contracts\Validation\ValidationRule;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Support\Str;
use Illuminate\Validation\Validator;

class UpdatePilotoRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Normaliza nombre y apellido (primera letra de cada palabra en mayúscula) antes de validar.
     */
    protected function prepareForValidation(): void
    {
        foreach (['nombre', 'apellido'] as $campo) {
            if (is_string($this->input($campo))) {
                $this->merge([$campo => Str::title(trim($this->input($campo)))]);
            }
        }
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            'nombre' => ['bail', 'sometimes', 'required', 'string', 'max:20'],
            'apellido' => ['bail', 'sometimes', 'required', 'string', 'max:20'],
            'pais' => ['bail', 'sometimes', 'required', 'string', 'max:30'],
            'puntos' => ['bail', 'sometimes', 'required', 'integer', 'min:0', 'max:1000'],
            'equipo_id' => ['bail', 'sometimes', 'required', 'integer', 'min:1', 'exists:equipos,id'],
        ];
    }

    /**
     * Valida que la combinación de nombre y apellido sea única.
     *
     * @return array<int, callable>
     */
    public function after(): array
    {
        return [
            function (Validator $validator) {
                if ($validator->errors()->hasAny(['nombre', 'apellido'])) {
                    return;
                }

                $piloto = $this->route('piloto');
                $nombre = $this->input('nombre', $piloto?->nombre);
                $apellido = $this->input('apellido', $piloto?->apellido);

                $existe = Piloto::query()
                    ->where('nombre', $nombre)
                    ->where('apellido', $apellido)
                    ->when($piloto, fn ($query) => $query->whereKeyNot($piloto->getKey()))
                    ->exists();

                if ($existe) {
                    $validator->errors()->add('nombre', 'Ya existe un piloto con ese nombre y apellido.');
                }
            },
        ];
    }

    /**
     * Mensajes de error personalizados.
     *
     * @return array<string, string>
     */
    public function messages(): array
    {
        return [
            'required' => 'El campo :attribute es obligatorio.',
            'string' => 'El campo :attribute debe ser un texto.',
            'integer' => 'El campo :attribute debe ser un número entero.',
            'nombre.max' => 'El campo nombre no puede tener más de :max caracteres.',
            'apellido.max' => 'El campo apellido no puede tener más de :max caracteres.',
            'pais.max' => 'El campo pais no puede tener más de :max caracteres.',
            'puntos.min' => 'El campo puntos no puede ser menor que :min.',
            'puntos.max' => 'El campo puntos no puede ser mayor que :max.',
            'equipo_id.min' => 'El campo equipo_id no puede ser menor que :min.',
            'equipo_id.exists' => 'El equipo seleccionado no existe.',
        ];
    }
}
