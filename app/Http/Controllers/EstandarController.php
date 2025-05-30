<?php

namespace App\Http\Controllers;

use App\Models\Estandar;
use App\Models\Procedimiento;
use App\Models\Proceso;
use Illuminate\Http\Request;
use Inertia\Inertia;

class EstandarController extends Controller
{
    //
    public function index()
    {
        return Inertia::render('Estandar/EstandarIndex');
    }

    public function findAll(Request $request)
    {
        $query = Estandar::query();
        $pageSize = $request->get('rows', 10);
        $page = $request->get('page', 1);
        $filter = $request->get('filter', '');
        $sortField = $request->get('sortField', 'id');
        $sortOrder = $request->get('sortOrder', 'asc');

        // Filter logic
        if ($filter) {
            $query->where(function ($q) use ($filter) {
                $q->where('estandares.id', 'like', '%' . $filter . '%')
                    ->orWhere('estandares.nombre', 'like', '%' . $filter . '%')
                    ->orWhere('estandares.descripcion', 'like', '%' . $filter . '%')
                    ->orWhere('estandares.link_externo', 'like', '%' . $filter . '%')
                    ->orWhereHas('procedimiento', function ($q) use ($filter) {
                        $q->where('procedimientos.nombre', 'like', '%' . $filter . '%')
                            ->orWhere('procedimientos.descripcion', 'like', '%' . $filter . '%');
                    });
            });
        }

        // Sorting logic
        if (in_array($sortField, ['id', 'nombre', 'descripcion', 'link_externo', 'procedimiento.nombre'])) {
            if (strpos($sortField, 'procedimiento.') === 0) {
                $query->join('procedimientos', 'estandares.procedimiento_id', '=', 'procedimientos.id')
                    ->select('estandares.*', 'procedimientos.nombre as procedimiento_nombre') // Select distinct columns
                    ->orderBy('procedimientos.nombre', $sortOrder);
            } else {
                $query->orderBy('estandares.' . $sortField, $sortOrder);
            }
        } else {
            // Default sorting if the provided sortField is not allowed
            $query->orderBy('id', $sortOrder);
        }

        $estandares = $query->with('procedimiento')->paginate($pageSize, ['*'], 'page', $page);

        return response()->json($estandares);
    }


    public function create()
    {
        return Inertia::render('Estandar/EstandarCreate');
    }

    public function edit(Estandar $estandar)
    {
        $procedimiento = Procedimiento::find($estandar->procedimiento_id);
        $proceso = Proceso::find($procedimiento->proceso_id);

        return Inertia::render('Estandar/EstandarEdit', [
            'estandar' => $estandar,
            'procedimiento' => $procedimiento,
            'proceso' => $proceso
        ]);
    }

    public function store(Request $request)
    {
        $estandar = Estandar::create($request->only(['procedimiento_id', 'nombre', 'descripcion', 'link_externo']));
        return redirect()->route('estandar.index');
    }

    public function update(Request $request, Estandar $estandar)
    {
        $estandar->update($request->only(['procedimiento_id', 'nombre', 'descripcion', 'link_externo']));
        return redirect()->route('estandar.index');
    }

    public function destroy(Estandar $estandar)
    {
        $estandar->delete();
        return response()->json(['success' => true]);
    }
}
