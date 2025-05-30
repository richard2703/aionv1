<?php

namespace App\Http\Controllers;

use App\Models\Procedimiento;
use App\Models\Proceso;
use Illuminate\Http\Request;
use Inertia\Inertia;

class procedimientoController extends Controller
{
    //
    public function index()
    {
        return Inertia::render('Procedimiento/ProcedimientoIndex');
    }

    function byProceso($proceso_id)
    {
        return response()->json(['procedimientos' => Procedimiento::where('proceso_id', $proceso_id)->get()]);
    }

    public function findAll(Request $request)
    {
        $query = Procedimiento::query();
        $pageSize = $request->get('rows', 10);
        $page = $request->get('page', 1);
        $filter = $request->get('filter', '');
        $sortField = $request->get('sortField', 'id');
        $sortOrder = $request->get('sortOrder', 'asc');

        // Filter logic
        if ($filter) {
            $query->where(function ($q) use ($filter) {
                $q->where('procedimientos.id', 'like', '%' . $filter . '%')
                    ->orWhere('procedimientos.nombre', 'like', '%' . $filter . '%')
                    ->orWhere('procedimientos.descripcion', 'like', '%' . $filter . '%')
                    ->orWhere('procedimientos.link_externo', 'like', '%' . $filter . '%')
                    ->orWhereHas('proceso', function ($q) use ($filter) {
                        $q->where('procesos.nombre', 'like', '%' . $filter . '%')
                            ->orWhere('procesos.descripcion', 'like', '%' . $filter . '%');
                    });
            });
        }

        // Sorting logic
        if (in_array($sortField, ['id', 'nombre', 'descripcion', 'link_externo', 'proceso.nombre'])) {
            if (strpos($sortField, 'proceso.') === 0) {
                $query->join('procesos', 'procedimientos.proceso_id', '=', 'procesos.id')
                    ->select('procedimientos.*', 'procesos.nombre as proceso_nombre') // Select distinct columns
                    ->orderBy('procesos.nombre', $sortOrder);
            } else {
                $query->orderBy('procedimientos.' . $sortField, $sortOrder);
            }
        } else {
            // Default sorting if the provided sortField is not allowed
            $query->orderBy('id', $sortOrder);
        }

        $procedimientos = $query->with('proceso')->paginate($pageSize, ['*'], 'page', $page);

        return response()->json($procedimientos);
    }


    public function create()
    {
        return Inertia::render('Procedimiento/ProcedimientoCreate');
    }

    public function edit(Procedimiento $procedimiento)
    {
        $proceso = Proceso::find($procedimiento->proceso_id);
        return Inertia::render('Procedimiento/ProcedimientoEdit', [
            'procedimiento' => $procedimiento,
            'proceso' => $proceso
        ]);
    }

    public function store(Request $request)
    {
        $procedimiento = Procedimiento::create($request->only(['proceso_id', 'nombre', 'descripcion', 'link_externo', 'link_herramienta']));
        return redirect()->route('procedimiento.index');
    }

    public function update(Request $request, Procedimiento $procedimiento)
    {
        $procedimiento->update($request->only('proceso_id', 'nombre', 'descripcion', 'link_externo', 'link_herramienta'));
        return redirect()->route('procedimiento.index');
    }

    public function destroy(Procedimiento $procedimiento)
    {
        $procedimiento->delete();
        return response()->json(['success' => true]);
    }
}
