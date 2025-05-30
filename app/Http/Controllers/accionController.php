<?php

namespace App\Http\Controllers;

use App\Models\Accion;
use Illuminate\Http\Request;

class accionController extends Controller
{
    //
    public function index()
    {
        // return Inertia::render('Acciones/Index');
    }

    public function create() {}

    public function edit(Accion $accion)
    {
        $accion->load('responsable');
        return response()->json($accion);
    }

    public function store(Request $request)
    {
        $data = [
            'proceso_id' => $request->proceso_id,
            'area_id' => $request->area_id,
            'departamento_id' => $request->departamento_id,
            'tipo_id' => $request->tipo_id,
            'titulo' => $request->titulo,
            'link' => $request->link,
            'estatus_id' => $request->estatus_id,
        ];

        if (is_array($request->responsable_id)) {
            $data['responsable_id'] = $request->responsable_id["id"];
        }
        Accion::create($data);
        return response()->json(['success' => true]);
    }

    public function update(Request $request, Accion $accion)
    {
        if (is_array($request->responsable_id)) {
            $accion->responsable_id = $request->responsable_id["id"];
        }
        $accion->proceso_id = $request->proceso_id;
        $accion->area_id = $request->area_id;
        $accion->departamento_id = $request->departamento_id;
        $accion->tipo_id = $request->tipo_id;
        $accion->titulo = $request->titulo;
        $accion->link = $request->link;
        $accion->estatus_id = $request->estatus_id;

        $accion->save();
        return response()->json(['success' => true]);
    }

    public function destroy(Accion $accion)
    {
        $accion->delete();
        return response()->json(['success' => true]);
    }

    public function byDepartamento($departamento_id, $tipo)
    {
        // dd($departamento_id, $tipo);
        switch ($tipo) {
            case 'correctiva':
                $tipo_id = 1;
                break;

            case 'preventiva':
                $tipo_id = 2;
                break;

            case 'mejora':
                $tipo_id = 3;
                break;

            default:
                $tipo_id = 1;
                break;
        }

        $accion = Accion::with('area', 'proceso', 'tipo', 'responsable', 'estatus')->where('departamento_id', $departamento_id)->where('tipo_id', $tipo_id)->orderBy('proceso_id', 'asc')->get();
        return response()->json($accion);
    }
}
