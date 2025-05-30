<?php

namespace App\Http\Controllers;

use App\Models\Seccion;
use Illuminate\Http\Request;
use Inertia\Inertia;

class seccionController extends Controller
{
    public function index()
    {
        $sercciones = Seccion::get();
        return Inertia::render('Seccion/SeccionIndex');
    }

    public function findAll(Request $request)
    {

        $query = Seccion::query();
        $pageSize = $request->get('rows', 10);
        $page = $request->get('page', 1);
        $filter = $request->get('filter', '');
        $sortField = $request->get('sortField', 'id');
        $sortOrder = $request->get('sortOrder', 'asc');

        if ($filter) {
            $query->where(function ($q) use ($filter) {
                $q->where('secciones.id', 'like', '%' . $filter . '%')
                    ->orWhereHas('area', function ($q) use ($filter) {
                        $q->where('areas.nombre', 'like', '%' . $filter . '%')
                            ->orWhere('areas.descripcion', 'like', '%' . $filter . '%');
                    })
                    ->orWhereHas('departamento', function ($q) use ($filter) {
                        $q->where('departamentos.nombre', 'like', '%' . $filter . '%')
                            ->orWhere('departamentos.descripcion', 'like', '%' . $filter . '%');
                    });
            });
        }

        if ($sortField) {
            if (in_array($sortField, ['id', 'area.nombre', 'departamento.nombre'])) {
                if (strpos($sortField, 'area.') === 0) {
                    $query->join('areas', 'secciones.area_id', '=', 'areas.id')
                        ->select('secciones.*', 'areas.nombre as area_nombre') // Select distinct columns
                        ->orderBy('areas.' . substr($sortField, 5), $sortOrder);
                } else if (strpos($sortField, 'departamento.') === 0) {
                    $query->join('departamentos', 'secciones.departamento_id', '=', 'departamentos.id')
                        ->select('secciones.*', 'departamentos.nombre as departamento_nombre') // Select distinct columns
                        ->orderBy('departamentos.' . substr($sortField, 12), $sortOrder);
                } else {
                    $query->orderBy($sortField, $sortOrder);
                }
            }
        }

        $result = $query->with('area', 'departamento')->paginate($pageSize, ['*'], 'page', $page);

        return response()->json($result);
    }

    public function create()
    {
        $secciones = Seccion::get();
        return Inertia::render('Seccion/SeccionCreate', [
            'secciones' => $secciones
        ]);
    }

    public function edit(Seccion $seccion)
    {
        $sercciones = Seccion::get();
        return Inertia::render('Seccion/SeccionEdit', [
            'seccion' => $seccion,
            'secciones' => $sercciones
        ]);
    }

    public function byArea($area_id)
    {
        $secciones = Seccion::where('area_id', $area_id)->get();
        return response()->json($secciones);
    }

    public function store(Request $request)
    {
        $data = [
            'area_id' => $request->area_id,
            'departamento_id' => $request->departamento_id,
            'titulo' => $request->titulo,
            'descripcion' => $request->descripcion,
            'created_by' => auth()->user()->id,
        ];
        Seccion::create($data);
        return redirect()->route('seccion.index');
    }

    public function update(Seccion $seccion, Request $request)
    {
        $seccion->update($request->only('area_id', 'departamento_id', 'titulo'));
        return redirect()->route('seccion.index');
    }

    public function destroy(Seccion $seccion)
    {

        $seccion->delete();
        return response()->json(['seccion' => Seccion::with('challenge')->get(),]);
    }
}
