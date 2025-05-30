<?php

namespace App\Http\Controllers;

use App\Models\Proceso;
use Illuminate\Http\Request;
use Inertia\Inertia;

class procesoController extends Controller
{
    //

    public function index()
    {
        return Inertia::render('Proceso/ProcesoIndex', [
            'procesos' => Proceso::with('area', 'departamento')->get(),
        ]);
    }

    function byDepartamento($departamento_id)
    {
        return response()->json(['procesos' => Proceso::with('procedimientos')->where('departamento_id', $departamento_id)->get()]);
    }

    public function findAll(Request $request)
    {
        $query = Proceso::query();
        $pageSize = $request->get('rows', 10);
        $page = $request->get('page', 1);
        $filter = $request->get('filter', '');
        $sortField = $request->get('sortField', 'id');
        $sortOrder = $request->get('sortOrder', 'asc');

        if ($filter) {
            $query->where(function ($q) use ($filter) {
                $q->where('procesos.id', 'like', '%' . $filter . '%')
                    ->orWhere('procesos.nombre', 'like', '%' . $filter . '%')
                    ->orWhere('procesos.descripcion', 'like', '%' . $filter . '%')
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

        if (in_array($sortField, ['id', 'nombre', 'descripcion', 'area.nombre', 'departamento.nombre'])) {
            if (strpos($sortField, 'area.') === 0) {
                $query->join('areas', 'procesos.area_id', '=', 'areas.id')
                    ->select('procesos.*', 'areas.nombre as area_nombre') // Select distinct columns
                    ->orderBy('areas.nombre', $sortOrder);
            } else if (strpos($sortField, 'departamento.') === 0) {
                $query->join('departamentos', 'procesos.departamento_id', '=', 'departamentos.id')
                    ->select('procesos.*', 'departamentos.nombre as departamento_nombre') // Select distinct columns
                    ->orderBy('departamentos.nombre', $sortOrder);
            } else {
                $query->orderBy('procesos.' . $sortField, $sortOrder);
            }
        }

        $procesos = $query->with('area', 'departamento')->paginate($pageSize, ['*'], 'page', $page);

        return response()->json($procesos);
    }

    public function findAllSP(Request $request)
    {
        // return response()->json(['procesos' => Proceso::all()]);
        // dd('procesos');
        $query = Proceso::query();
        $pageSize = $request->get('rows', 10);
        $page = $request->get('page', 1);
        $filter = $request->get('filter', '');
        $sortField = $request->get('sortField', 'nombre');
        $sortOrder = $request->get('sortOrder', 'asc');

        if ($filter) {
            $query->where(function ($q) use ($filter) {
                $q->where('procesos.id', 'like', '%' . $filter . '%')
                    ->orWhere('procesos.nombre', 'like', '%' . $filter . '%')
                    ->orWhere('procesos.descripcion', 'like', '%' . $filter . '%')
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

        if (in_array($sortField, ['id', 'nombre', 'descripcion', 'area.nombre', 'departamento.nombre'])) {
            if (strpos($sortField, 'area.') === 0) {
                $query->join('areas', 'procesos.area_id', '=', 'areas.id')
                    ->select('procesos.*', 'areas.nombre as area_nombre') // Select distinct columns
                    ->orderBy('areas.nombre', $sortOrder);
            } else if (strpos($sortField, 'departamento.') === 0) {
                $query->join('departamentos', 'procesos.departamento_id', '=', 'departamentos.id')
                    ->select('procesos.*', 'departamentos.nombre as departamento_nombre') // Select distinct columns
                    ->orderBy('departamentos.nombre', $sortOrder);
            } else {
                $query->orderBy('procesos.' . $sortField, $sortOrder);
            }
        }

        $procesos = $query->with('area', 'departamento')->get();

        return response()->json($procesos);
    }



    function create()
    {
        return Inertia::render('Proceso/ProcesoCreate');
    }

    function edit(Proceso $proceso)
    {
        return Inertia::render('Proceso/ProcesoEdit', [
            'proceso' => $proceso,
        ]);
    }

    function store(Request $request)
    {
        $proceso = Proceso::create($request->only(['area_id', 'departamento_id', 'nombre', 'descripcion', 'link_externo', 'link_herramienta']));
        return redirect()->route('proceso.index');
    }

    function update(Request $request, Proceso $proceso)
    {
        $proceso->update($request->only(['area_id', 'departamento_id', 'nombre', 'descripcion', 'link_externo', 'link_herramienta']));
        return redirect()->route('proceso.index');
    }

    function destroy(Proceso $proceso)
    {
        $proceso->delete();
        return response()->json(['success' => true]);
    }

    function byArea($area_id)
    {
        $procesos = Proceso::where('area_id', $area_id)->get();
        return response()->json($procesos);
    }
}
