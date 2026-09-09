<?php

namespace App\Http\Requests;

use Illuminate\Contracts\Validation\ValidationRule;
use Illuminate\Foundation\Http\FormRequest;

class UpdateEquipoRequest extends FormRequest
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
            'nombre' => ['sometimes', 'required', 'string', 'max:100'],
            'jefe' => ['sometimes', 'required', 'string', 'max:50'],
            'pais' => ['sometimes', 'required', 'string', 'max:30'],
            'color' => ['sometimes', 'required', 'string', 'regex:/^[0-9A-Fa-f]{6}$/'],
        ];
    }
}
