<?php

namespace App\Http\Controllers;

use App\Models\encargado_flujo;
use Illuminate\Http\Request;
use Inertia\Inertia;

class encargado_flujoController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return Inertia::render('EncargadoFlujo/EncargadoFlujoIndex');
    }


    public function findAll(Request $request)
    {

        $query = encargado_flujo::query();
        $pageSize = $request->get('rows', 10);
        $page = $request->get('page', 1);
        $filter = $request->get('filter', '');
        $sortField = $request->get('sortField', 'id');
        $sortOrder = $request->get('sortOrder', 'asc');

        // Filter logic
        if ($filter) {
            $query->where(function ($q) use ($filter) {
                $q->where('encargado_flujos.id', 'like', '%' . $filter . '%')
                    ->orWhereHas('usuario', function ($q) use ($filter) {
                        $q->where('users.name', 'like', '%' . $filter . '%');
                    })
                    ->orWhereHas('departamento', function ($q) use ($filter) {
                        $q->where('departamentos.nombre', 'like', '%' . $filter . '%');
                    });
            });
        }
        // Sorting logic
        if (in_array($sortField, ['id', 'departamento.nombre', 'usuario.name'])) {
            if (strpos($sortField, 'usuario.') === 0) {
                $query->join('users', 'encargado_flujos.user_id', '=', 'users.id')
                    ->select('encargado_flujos.*', 'users.name as users_nombre') // Select distinct columns
                    ->orderBy('users.name', $sortOrder);
            } else if (strpos($sortField, 'departamento.') === 0) {
                $query->join('departamentos', 'encargado_flujos.departamento_id', '=', 'departamentos.id')
                    ->select('encargado_flujos.*', 'departamentos.nombre as departamento_nombre') // Select distinct columns
                    ->orderBy('departamentos.nombre', $sortOrder);
            } else {
                $query->orderBy('encargado_flujos.' . $sortField, $sortOrder);
            }
        } else {
            $query->orderBy('id', $sortOrder);
        }

        $encargados = $query->with('usuario', 'departamento')->paginate($pageSize, ['*'], 'page', $page);

        return response()->json($encargados);
    }


    public function create()
    {
        return Inertia::render('EncargadoFlujo/EncargadoFlujoCreate');
    }

    public function store(Request $request)
    {
        // $encargado_flujo = new encargado_flujo();
        // $encargado_flujo->area_id = $request->area_id;
        // $encargado_flujo->departamento_id = $request->departamento_id;
        // $encargado_flujo->user_id = $request->lider_id["id"];
        // $revision = encargado_flujo::where('departamento_id', $request->departamento_id)->where('user_id', $request->lider_id["id"])->first();
        // if ($revision) {
        //     // dd("no hay revision");
        //     return redirect()->route('encargadoFlujo.index');
        // }
        // dd("si hay revision");
        // $encargado_flujo->save();

        // return redirect()->route('encargadoFlujo.index');
        // Verificar si ya existe un líder para el departamento
        $encargado_flujo = encargado_flujo::where('departamento_id', $request->departamento_id)->first();

        if ($encargado_flujo) {
            // Si ya existe un líder, actualizar el registro existente
            $encargado_flujo->user_id = $request->lider_id["id"];
            $encargado_flujo->save();
        } else {
            // Si no existe un líder, crear uno nuevo
            $encargado_flujo = new encargado_flujo();
            $encargado_flujo->departamento_id = $request->departamento_id;
            $encargado_flujo->user_id = $request->lider_id["id"];
            $encargado_flujo->save();
        }

        return redirect()->route('encargadoFlujo.index');
    }

    /**
     * Display the specified resource.
     */
    public function show(encargado_flujo $encargado_flujo)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(encargado_flujo $encargado_flujo)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, encargado_flujo $encargado_flujo)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(encargado_flujo $encargado_flujo)
    {
        $encargado_flujo->delete();
        return response()->json(['success' => true]);
    }
}
