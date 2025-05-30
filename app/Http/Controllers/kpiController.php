<?php

namespace App\Http\Controllers;

use App\Models\Kpis;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Inertia\Inertia;

class kpiController extends Controller
{
    //
    function index()
    {
        return Inertia::render('Kpi/KpiIndex');
    }

    public function findAll(Request $request)
    {
        $query = Kpis::query();
        $pageSize = $request->get('rows', 10);
        $page = $request->get('page', 1);
        $filter = $request->get('filter', '');
        $sortField = $request->get('sortField', 'id');
        $sortOrder = $request->get('sortOrder', 'asc');

        // Filter logic
        if ($filter) {
            $query->where(function ($q) use ($filter) {
                $q->where('kpis.id', 'like', '%' . $filter . '%')
                    ->orWhere('kpis.titulo', 'like', '%' . $filter . '%')
                    ->orWhere('kpis.descripcion', 'like', '%' . $filter . '%')
                    ->orWhereHas('area', function ($q) use ($filter) {
                        $q->where('areas.nombre', 'like', '%' . $filter . '%')
                            ->orWhere('areas.descripcion', 'like', '%' . $filter . '%');
                    })
                    ->orWhereHas('departamento', function ($q) use ($filter) {
                        $q->where('departamentos.nombre', 'like', '%' . $filter . '%')
                            ->orWhere('departamentos.descripcion', 'like', '%' . $filter . '%');
                    })
                    ->orWhereHas('proceso', function ($q) use ($filter) {
                        $q->where('procesos.nombre', 'like', '%' . $filter . '%');
                    })
                    ->orWhereHas('procedimiento', function ($q) use ($filter) {
                        $q->where('procedimientos.nombre', 'like', '%' . $filter . '%');
                    });
            });
        }

        // Sorting logic
        if (in_array($sortField, ['id', 'nombre', 'descripcion', 'link_externo', 'procedimiento.nombre'])) {
            if (strpos($sortField, 'procedimiento.') === 0) {
                $query->join('procedimientos', 'kpis.procedimiento_id', '=', 'procedimientos.id')
                    ->select('kpis.*', 'procedimientos.nombre as procedimiento_nombre') // Select distinct columns
                    ->orderBy('procedimientos.nombre', $sortOrder);
            } else {
                $query->orderBy('kpis.' . $sortField, $sortOrder);
            }
        } else {
            // Default sorting if the provided sortField is not allowed
            $query->orderBy('id', $sortOrder);
        }

        $kpis = $query->with('area', 'departamento', 'proceso', 'procedimiento')->paginate($pageSize, ['*'], 'page', $page);

        return response()->json($kpis);
    }

    public function byDepartamento($departamento_id)
    {
        $kpis = Kpis::with(['area', 'departamento', 'proceso', 'procedimiento', 'registros' => function ($query) {
            $query
                ->whereYear('created_at', Carbon::now()->year)
                ->latest()
                ->take(22); // Limit to latest 22 registros
        }])
            ->where('departamento_id', $departamento_id)
            ->where('archivado', null)
            ->get();

        return response()->json($kpis);
    }

    public function byArea($area_id)
    {
        $kpis = Kpis::with(['area', 'departamento', 'proceso', 'procedimiento', 'registros'])
            ->where('area_id', $area_id)
            ->get();
        return response()->json($kpis);
    }

    public function create()
    {
        return Inertia::render('Kpi/KpiCreate');
    }

    public function edit(Kpis $kpi)
    {
        return Inertia::render('Kpi/KpiEdit', [
            'kpi' => $kpi
        ]);
    }
    public function byId(Kpis $kpi)
    {
        return response()->json($kpi);
    }

    public function store(Request $request)
    {
        // dd($request);
        $kpis = new Kpis();
        $kpis->titulo = $request->titulo;
        $kpis->actual = $request->actual;
        $kpis->objetivo = $request->objetivo;
        $kpis->descripcion = $request->descripcion;
        $kpis->medicion = $request->medicion;
        $kpis->regla = $request->regla;
        $kpis->area_id = $request->area_id;
        $kpis->departamento_id = $request->departamento_id;
        $kpis->proceso_id = $request->proceso_id;
        $kpis->procedimiento_id = $request->procedimiento_id;
        $kpis->archivado = null;
        $kpis->tipo = 1;

        if ($request->departamento_id !== null) {
            $kpis->tipo = 2;
            $conteo = Kpis::where('departamento_id', $request->departamento_id)->count();
            // if ($conteo >= 3) {
            //     return response()->json(['error' => 'El departamento ya tiene 3 KPIs'], 200);
            // }
        }
        if ($request->proceso_id !== null) {
            $kpis->tipo = 3;
            $conteo = Kpis::where('proceso_id', $request->proceso_id)->count();
            // if ($conteo >= 3) {
            //     return response()->json(['error' => 'El proceso ya tiene 3 KPIs'], 200);
            // }
        }
        if ($request->procedimiento_id !== null) {
            $kpis->tipo = 4;
            $conteo = Kpis::where('procedimiento_id', $request->procedimiento_id)->count();
            // if ($conteo >= 3) {
            //     return response()->json(['error' => 'El procedimiento ya tiene 3 KPIs'], 200);
            // }
        }
        $kpis->save();
        return response()->json(['success' => 'KPI Creado'], 200);
    }

    public function update(Request $request, Kpis $kpi)
    {
        // $kpi->update($request->only('procedimiento_id', 'nombre', 'descripcion', 'link_externo'));
        // return redirect()->route('kpi.index');
        $kpi->titulo = $request->titulo;
        $kpi->actual = $request->actual;
        $kpi->objetivo = $request->objetivo;
        $kpi->descripcion = $request->descripcion;
        $kpi->medicion = $request->medicion;
        $kpi->regla = $request->regla;
        $kpi->area_id = $request->area_id;
        $kpi->departamento_id = $request->departamento_id;
        $kpi->proceso_id = $request->proceso_id;
        $kpi->procedimiento_id = $request->procedimiento_id;
        $request->archivar ? $kpi->archivado = 1 : $kpi->archivado = null;
        $kpi->tipo = 1;
        if ($request->departamento_id !== null) {
            $kpi->tipo = 2;
            $conteo = Kpis::where('departamento_id', $request->departamento_id)->count();
            // if ($conteo >= 3) {
            //     return response()->json(['error' => 'El departamento ya tiene 3 KPIs'], 200);
            // }
        }
        if ($request->proceso_id !== null) {
            $kpi->tipo = 3;
            $conteo = Kpis::where('proceso_id', $request->proceso_id)->count();
            // if ($conteo >= 3) {
            //     return response()->json(['error' => 'El proceso ya tiene 3 KPIs'], 200);
            // }
        }
        if ($request->procedimiento_id !== null) {
            $kpi->tipo = 4;
            $conteo = Kpis::where('procedimiento_id', $request->procedimiento_id)->count();
            // if ($conteo >= 3) {
            //     return response()->json(['error' => 'El procedimiento ya tiene 3 KPIs'], 200);
            // }
        }
        $kpi->save();
        return redirect()->route('kpi.index');
    }

    public function destroy(Kpis $kpi)
    {
        $kpi->delete();
        return response()->json(['success' => true]);
    }
}
