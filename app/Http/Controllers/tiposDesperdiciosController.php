<?php

namespace App\Http\Controllers;

use App\Models\tiposDesperdicios;
use Illuminate\Http\Request;
use Inertia\Inertia;

class tiposDesperdiciosController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return Inertia::render('tiposDesperdicios/tiposDesperdiciosIndex');
    }

    public function findAll(Request $request)
    {

        $query = tiposDesperdicios::query();
        $pageSize = $request->get('rows', 10);
        $page = $request->get('page', 1);
        $filter = $request->get('filter', '');
        $sortField = $request->get('sortField', 'id');
        $sortOrder = $request->get('sortOrder', 'asc');

        // Filter logic
        // if ($filter) {
        //     $query->where(function ($q) use ($filter) {
        //         $q->where('estandares.id', 'like', '%' . $filter . '%')
        //             ->orWhere('estandares.nombre', 'like', '%' . $filter . '%')
        //             ->orWhere('estandares.descripcion', 'like', '%' . $filter . '%')
        //             ->orWhere('estandares.link_externo', 'like', '%' . $filter . '%')
        //             ->orWhereHas('procedimiento', function ($q) use ($filter) {
        //                 $q->where('procedimientos.nombre', 'like', '%' . $filter . '%')
        //                     ->orWhere('procedimientos.descripcion', 'like', '%' . $filter . '%');
        //             });
        //     });
        // }

        // Filter logic
        // if ($filter) {
        //     $query->where(function ($q) use ($filter) {
        //         $q->where('estandares.id', 'like', '%' . $filter . '%')
        //             ->orWhere('estandares.nombre', 'like', '%' . $filter . '%')
        //             ->orWhere('estandares.descripcion', 'like', '%' . $filter . '%')
        //             ->orWhere('estandares.link_externo', 'like', '%' . $filter . '%')
        //             ->orWhereHas('procedimiento', function ($q) use ($filter) {
        //                 $q->where('procedimientos.nombre', 'like', '%' . $filter . '%')
        //                     ->orWhere('procedimientos.descripcion', 'like', '%' . $filter . '%');
        //             });
        //     });
        // }

        // Sorting logic
        // if (in_array($sortField, ['id', 'nombre', 'descripcion', 'link_externo', 'procedimiento.nombre'])) {
        //     if (strpos($sortField, 'procedimiento.') === 0) {
        //         $query->join('procedimientos', 'estandares.procedimiento_id', '=', 'procedimientos.id')
        //             ->select('estandares.*', 'procedimientos.nombre as procedimiento_nombre') // Select distinct columns
        //             ->orderBy('procedimientos.nombre', $sortOrder);
        //     } else {
        //         $query->orderBy('estandares.' . $sortField, $sortOrder);
        //     }
        // } else {
        //     // Default sorting if the provided sortField is not allowed
        //     $query->orderBy('id', $sortOrder);
        // }

        $tipos = $query->with('usuario', 'area', 'departamento')->orderBy('tipo', 'desc')->paginate($pageSize, ['*'], 'page', $page);

        return response()->json($tipos);
    }

    function byDepartamento($departamento_id)
    {
        // return response()->json(['tipos' => tiposDesperdicios::where('departamento_id', $departamento_id)->get()]);
        return response()->json(['tipos' => tiposDesperdicios::orderBy('tipo', 'desc')->get()]);
    }

    public function create()
    {
        return Inertia::render('tiposDesperdicios/tipoDesperdicioCreate');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $tipo = new tiposDesperdicios();
        $tipo->area_id = $request->area_id;
        $tipo->departamento_id = $request->departamento_id;
        $tipo->created_for = auth()->id();
        $tipo->nombre = $request->nombre;
        $tipo->descripcion = $request->descripcion;
        $tipo->tipo = $request->tipo;
        $tipo->save();

        return redirect()->route('tiposDesperdicios.index');
    }

    /**
     * Display the specified resource.
     */
    public function show(tiposDesperdicios $tipoDesperdicio) {}

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(tiposDesperdicios $tipoDesperdicio)
    {
        // dd($tipoDesperdicio);
        return Inertia::render('tiposDesperdicios/tipoDesperdicioEdit', [
            'tipoDesperdicio' => $tipoDesperdicio
        ]);
    }

    public function update(Request $request, tiposDesperdicios $tipoDesperdicio)
    {
        $tipoDesperdicio->update($request->only('area_id', 'departamento_id', 'nombre', 'descripcion', 'tipo'));
        return redirect()->route('tiposDesperdicios.index');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(tiposDesperdicios $tipoDesperdicio)
    {
        $tipoDesperdicio->delete();
        return response()->json(['success' => true]);
    }
}
