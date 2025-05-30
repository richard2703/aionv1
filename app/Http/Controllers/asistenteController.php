<?php

namespace App\Http\Controllers;

use App\Models\Asistente;
use Illuminate\Http\Request;

class asistenteController extends Controller
{
    //
    public function findByMinutaId($id)
    {
        $asistentes = Asistente::with('user')->where('minuta_id', $id)->get();
        return response()->json($asistentes);
    }

    public function store(Request $request)
    {
        // return response()->json(['success' => true], 200);

        $asistente = new Asistente();
        $asistente->minuta_id = $request->minuta_id;
        $asistente->user_id = $request->user_id['id'];
        // $asistente->minuta_id = 3;
        // $asistente->user_id = 1;
        $asistente->save();
        return response()->json(['success' => true]);
    }

    public function destroy(Asistente $asistente)
    {
        $asistente->delete();
        return response()->json(['success' => true]);
    }
}
