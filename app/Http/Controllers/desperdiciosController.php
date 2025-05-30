<?php

namespace App\Http\Controllers;

use App\Models\desperdicios;
use App\Models\tiposDesperdicios;
use Illuminate\Http\Request;
use Inertia\Inertia;

class desperdiciosController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return Inertia::render('desperdicio/desperdiciosIndex');
    }

    public function findAll(Request $request)
    {

        $query = desperdicios::query();
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

        $desperdicios = $query->with('usuario', 'area', 'departamento', 'tipo')->orderBy('created_at', 'desc')->paginate($pageSize, ['*'], 'page', $page);

        return response()->json($desperdicios);
    }

    public function create()
    {
        return Inertia::render('desperdicio/desperdicioCreate');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $item = new desperdicios();
        $item->area_id = $request->area_id;
        $item->departamento_id = $request->departamento_id;
        $item->tipoDesperdicio_id = $request->tipoDesperdicio_id;
        $item->created_for = auth()->id();
        $item->monto = $request->monto;
        $item->descripcion = $request->descripcion;
        $item->rango = $request->rango;
        $item->recurrencia = $request->recurrencia;
        $item->detectabilidad = $request->detectabilidad;
        $item->save();

        return redirect()->route('desperdicio.index');
    }

    /**
     * Display the specified resource.
     */
    public function show(desperdicios $desperdicios)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(desperdicios $desperdicio)
    {
        return Inertia::render('desperdicio/desperdicioEdit', [
            'desperdicio' => $desperdicio
        ]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, desperdicios $desperdicio)
    {
        // dd($request);
        // $reporte = desperdicios::findOrFail($desperdicio);
        $desperdicio->update($request->only('area_id', 'departamento_id', 'tipoDesperdicio_id', 'descripcion', 'monto', 'rango', 'recurrencia', 'detectabilidad'));

        return redirect()->route('desperdicio.index');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(desperdicios $desperdicio)
    {
        $desperdicio->delete();
        return response()->json(['success' => true]);
    }
}
