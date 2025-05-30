<?php

namespace App\Http\Controllers;

use App\Models\tareaEvidencia;
use ArrayObject;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;

class tareaEvidenciaController extends Controller
{
    //
    public function getByTarea($tarea_id)
    {
        $tareaEvidencia = tareaEvidencia::where('tarea_id', $tarea_id)->get();
        $evidencia = new ArrayObject();
        foreach ($tareaEvidencia as $key => $evidenciaValue) {
            $img_ref = Storage::disk('public')->url($evidenciaValue->img_ref);

            $evidencia->append([
                'id' => $evidenciaValue->id,
                'img_ref' => $img_ref
            ]);
        }

        // $img_ref = ("public/storage/$evidenciaValue->img_ref");
        // asset($img_ref); // esto va al push, o eso creo yo


        return response()->json($evidencia);
    }

    public function store(Request $request)
    {
        $user = Auth::user();
        $data = [
            'tarea_id' => $request->tarea_id,
            'created_for' => $user->id,

        ];

        $tareaEvidencia = new tareaEvidencia();
        // Manejar la carga del img_ref
        if ($request->hasFile('img_ref')) {
            // Eliminar el archivo anterior si existe
            // if ($tareaEvidencia->img_ref) {
            //     Storage::disk('public')->delete($tareaEvidencia->img_ref);
            // }

            // Guardar el nuevo archivo
            $img_ref = $request->file('img_ref');
            $path = $img_ref->store('tareas', 'public');
            $data['img_ref'] = $path;
        }

        $tareaEvidencia->fill($data);
        $tareaEvidencia->save();
        return response()->json(['message' => 'Updated successfully', 'personalizar' => $tareaEvidencia->fresh()]);
    }

    function destroy(tareaEvidencia $tareaEvidencia)
    {

        // Eliminar el archivo anterior si existe
        if ($tareaEvidencia->img_ref) {
            Storage::disk('public')->delete($tareaEvidencia->img_ref);
        }

        $tareaEvidencia->delete();
        return response()->json(['success' => true]);
    }
}
