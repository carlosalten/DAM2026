<?php

namespace App\Http\Requests;

use Illuminate\Contracts\Validation\ValidationRule;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Support\Str;

class StoreEquipoRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Normaliza nombre y jefe (primera letra de cada palabra en mayúscula) y color (mayúsculas) antes de validar.
     */
    protected function prepareForValidation(): void
    {
        foreach (['nombre', 'jefe'] as $campo) {
            if (is_string($this->input($campo))) {
                $this->merge([$campo => Str::title(trim($this->input($campo)))]);
            }
        }

        if (is_string($this->input('color'))) {
            $this->merge(['color' => Str::upper($this->input('color'))]);
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
            'nombre' => ['bail', 'required', 'string', 'max:100', 'unique:equipos,nombre'],
            'jefe' => ['bail', 'required', 'string', 'max:50', 'unique:equipos,jefe'],
            'pais' => ['bail', 'required', 'string', 'max:30'],
            'color' => ['bail', 'required', 'string', 'regex:/^[0-9A-Fa-f]{6}$/'],
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
            'max' => 'El campo :attribute no puede tener más de :max caracteres.',
            'nombre.unique' => 'Ya existe un equipo con ese nombre.',
            'jefe.unique' => 'Ya existe un equipo con ese jefe.',
            'color.regex' => 'El campo color debe ser un código hexadecimal de 6 caracteres, sin #.',
        ];
    }
}
