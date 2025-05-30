<?php

namespace App\Http\Controllers;

use App\Models\TipoMinuta;
use Illuminate\Http\Request;

class tipoMinutaController extends Controller
{
    //
    public function index()
    {
        return response()->json(TipoMinuta::all());
    }

    public function create()
    {
    }

    public function edit(TipoMinuta $tipoMinuta)
    {
        return response()->json($tipoMinuta);
    }

    public function show()
    {
    }

    public function store(Request $request)
    {
        TipoMinuta::create($request->only('titulo', 'definicion'));
        return response()->json(['success' => true]);
    }

    public function update(Request $request, TipoMinuta $tipoMinuta)
    {
        $tipoMinuta->update($request->only('titulo', 'definicion'));
        return response()->json(['success' => true]);
    }

    public function destroy(TipoMinuta $tipoMinuta)
    {
        $tipoMinuta->delete();
        return response()->json(['success' => true]);
    }
}
