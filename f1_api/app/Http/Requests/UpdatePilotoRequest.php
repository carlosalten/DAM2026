<?php

namespace App\Http\Requests;

use Illuminate\Contracts\Validation\ValidationRule;
use Illuminate\Foundation\Http\FormRequest;

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
     * Get the validation rules that apply to the request.
     *
     * @return array<string, ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            'nombre' => ['sometimes', 'required', 'string', 'max:20'],
            'apellido' => ['sometimes', 'required', 'string', 'max:20'],
            'pais' => ['sometimes', 'required', 'string', 'max:30'],
            'puntos' => ['sometimes', 'required', 'integer'],
            'equipo_id' => ['sometimes', 'required', 'integer', 'exists:equipos,id'],
        ];
    }
}
