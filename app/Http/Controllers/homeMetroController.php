<?php

namespace App\Http\Controllers;

use App\Models\Departamento;
use App\Models\Estandar;
use App\Models\Procedimiento;
use App\Models\Proceso;
use Illuminate\Http\Request;

class homeMetroController extends Controller
{
    public function getDepartamentos(Request $request)
    {
        $query = Departamento::query();
        $pilar = $request->get('pilar');
        $pageSize = $request->get('rows');
        $page = $request->get('page');
        $filter = $request->get('filter', '');
        $sortField = $request->get('sortField', 'id');
        $sortOrder = $request->get('sortOrder', 'asc');

        // Filtrar por pilar (area_id)
        if ($pilar) {
            $query->where('area_id', $pilar);
        }

        // Filtros de búsqueda
        if ($filter) {
            $query->where(function ($q) use ($filter) {
                $q->where('departamentos.id', 'like', '%' . $filter . '%')
                    ->orWhere('departamentos.nombre', 'like', '%' . $filter . '%')
                    ->orWhere('departamentos.descripcion', 'like', '%' . $filter . '%');
            });
        }

        // Ordenamiento
        if (in_array($sortField, ['id', 'nombre', 'descripcion', 'area.nombre'])) {
            if (strpos($sortField, 'area.') === 0) {
                $query->join('areas', 'departamentos.area_id', '=', 'areas.id')
                    ->select('departamentos.*', 'areas.nombre as area_nombre') // Select distinct columns
                    ->orderBy('areas.' . substr($sortField, 5), $sortOrder);
            } else {
                $query->orderBy($sortField, $sortOrder);
            }
        }

        if ($pageSize && $page) {
            $departamentos = $query->with('kpis')->paginate($pageSize, ['*'], 'page', $page);
        } else {
            $departamentos = $query->with('kpis')->get();
        }

        return response()->json($departamentos);
    }

    public function getProcesos(Request $request)
    {
        $query = Proceso::query();
        $departamento = $request->get('departamento');
        $pageSize = $request->get('rows');
        $page = $request->get('page');
        $filter = $request->get('filter', '');
        $sortField = $request->get('sortField', 'id');
        $sortOrder = $request->get('sortOrder', 'asc');

        // Filtrar por pilar (area_id)
        if ($departamento) {
            $query->where('departamento_id', $departamento);
        }

        // Filtros de búsqueda
        if ($filter) {
            $query->where(function ($q) use ($filter) {
                $q->where('id', 'like', '%' . $filter . '%')
                    ->orWhere('nombre', 'like', '%' . $filter . '%');
            });
        }

        // Ordenamiento
        if (in_array($sortField, ['id', 'nombre', 'descripcion', 'area.nombre'])) {
            if (strpos($sortField, 'area.') === 0) {
                $query->join('areas', 'departamentos.area_id', '=', 'areas.id')
                    ->select('departamentos.*', 'areas.nombre as area_nombre') // Select distinct columns
                    ->orderBy('areas.' . substr($sortField, 5), $sortOrder);
            } else {
                $query->orderBy($sortField, $sortOrder);
            }
        }

        // Paginación y resultados
        // if ($pageSize && $page) {
        //     $departamentos = $query->with(['area', 'procesos.procedimientos'])->paginate($pageSize, ['*'], 'page', $page);
        // } else {
        //     $departamentos = $query->with(['area', 'procesos.procedimientos'])->get();
        // }

        if ($pageSize && $page) {
            $procesos = $query->paginate($pageSize, ['*'], 'page', $page);
        } else {
            $procesos = $query->get();
        }

        return response()->json($procesos);
    }

    public function getProcedimientos(Request $request)
    {
        $query = Procedimiento::query();
        $proceso = $request->get('proceso');
        $pageSize = $request->get('rows');
        $page = $request->get('page');
        $filter = $request->get('filter', '');
        $sortField = $request->get('sortField', 'id');
        $sortOrder = $request->get('sortOrder', 'asc');

        // Filtrar por pilar (area_id)
        if ($proceso) {
            $query->where('proceso_id', $proceso);
        }

        // Filtros de búsqueda
        if ($filter) {
            $query->where(function ($q) use ($filter) {
                $q->where('id', 'like', '%' . $filter . '%')
                    ->orWhere('nombre', 'like', '%' . $filter . '%');
            });
        }

        // Ordenamiento
        if (in_array($sortField, ['id', 'nombre', 'descripcion', 'area.nombre'])) {
            if (strpos($sortField, 'area.') === 0) {
                $query->join('areas', 'departamentos.area_id', '=', 'areas.id')
                    ->select('departamentos.*', 'areas.nombre as area_nombre') // Select distinct columns
                    ->orderBy('areas.' . substr($sortField, 5), $sortOrder);
            } else {
                $query->orderBy($sortField, $sortOrder);
            }
        }

        // Paginación y resultados
        // if ($pageSize && $page) {
        //     $departamentos = $query->with(['area', 'procesos.procedimientos'])->paginate($pageSize, ['*'], 'page', $page);
        // } else {
        //     $departamentos = $query->with(['area', 'procesos.procedimientos'])->get();
        // }

        if ($pageSize && $page) {
            $procedimientos = $query->paginate($pageSize, ['*'], 'page', $page);
        } else {
            $procedimientos = $query->get();
        }

        return response()->json($procedimientos);
    }

    public function getEstandares(Request $request)
    {
        $query = Estandar::query();
        $procedimiento = $request->get('procedimiento');
        $pageSize = $request->get('rows');
        $page = $request->get('page');
        $filter = $request->get('filter', '');
        $sortField = $request->get('sortField', 'id');
        $sortOrder = $request->get('sortOrder', 'asc');

        // Filtrar por pilar (area_id)
        if ($procedimiento) {
            $query->where('procedimiento_id', $procedimiento);
        }

        // Filtros de búsqueda
        if ($filter) {
            $query->where(function ($q) use ($filter) {
                $q->where('id', 'like', '%' . $filter . '%')
                    ->orWhere('nombre', 'like', '%' . $filter . '%');
            });
        }

        // Ordenamiento
        if (in_array($sortField, ['id', 'nombre', 'descripcion', 'area.nombre'])) {
            if (strpos($sortField, 'area.') === 0) {
                $query->join('areas', 'departamentos.area_id', '=', 'areas.id')
                    ->select('departamentos.*', 'areas.nombre as area_nombre') // Select distinct columns
                    ->orderBy('areas.' . substr($sortField, 5), $sortOrder);
            } else {
                $query->orderBy($sortField, $sortOrder);
            }
        }

        // Paginación y resultados
        // if ($pageSize && $page) {
        //     $departamentos = $query->with(['area', 'procesos.procedimientos'])->paginate($pageSize, ['*'], 'page', $page);
        // } else {
        //     $departamentos = $query->with(['area', 'procesos.procedimientos'])->get();
        // }

        if ($pageSize && $page) {
            $estandares = $query->paginate($pageSize, ['*'], 'page', $page);
        } else {
            $estandares = $query->get();
        }

        return response()->json($estandares);
    }
}
