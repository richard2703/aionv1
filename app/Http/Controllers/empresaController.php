<?php

namespace App\Http\Controllers;

use App\Models\Empresa;
use Illuminate\Http\Request;
use Inertia\Inertia;

class empresaController extends Controller
{
    function index()
    {
        return Inertia::render('Empresa/EmpresaIndex');
    }
    //
    function findAll(Request $request)
    {
        $query = Empresa::query();

        $pageSize = $request->get('rows');
        $page = $request->get('page');
        $filter = $request->get('filter', '');
        $sortField = $request->get('sortField', 'id');
        $sortOrder = $request->get('sortOrder', 'asc');

        if ($filter) {
            $query->where(function ($q) use ($filter) {
                $q->where('empresa.id', 'like', '%' . $filter . '%')
                    ->orWhere('empresa.nombre', 'like', '%' . $filter . '%')
                    ->orWhere('empresa.direccion', 'like', '%' . $filter . '%')
                    ->orWhere('empresa.ciudad', 'like', '%' . $filter . '%')
                    ->orWhere('empresa.estado', 'like', '%' . $filter . '%')
                    ->orWhere('empresa.cp', 'like', '%' . $filter . '%')
                    ->orWhere('empresa.pais', 'like', '%' . $filter . '%')
                    ->orWhere('empresa.telefono', 'like', '%' . $filter . '%')
                    ->orWhereHas('membresia', function ($q) use ($filter) {
                        $q->where('membresias.nombre', 'like', '%' . $filter . '%');
                    });
            });
        }

        if (in_array($sortField, ['id', 'nombre', 'direccion', 'ciudad', 'estado', 'cp', 'pais', 'telefono', 'membresia.nombre'])) {
            if (strpos($sortField, 'membresia.') === 0) {
                $query->join('membresias', 'empresa.membresia_id', '=', 'membresias.id')
                    ->select('empresa.*', 'membresias.nombre as membresia_nombre') // Select distinct columns
                    ->orderBy('membresias.' . substr($sortField, 10), $sortOrder);
            } else {
                $query->orderBy($sortField, $sortOrder);
            }
        }

        if (!$pageSize && !$page) {
            $empresas = $query->with('membresia')->get();
            return response()->json($empresas);
        }

        if ($pageSize && $page) {
            $empresas = $query->with('membresia')->paginate($pageSize, ['*'], 'page', $page);
            return response()->json($empresas);
        }

        // Default case if only one of the pagination parameters is missing, return all without pagination
        $empresas = $query->with('membresia')->get();
        return response()->json($empresas);
    }

    function create()
    {
        return Inertia::render('Empresa/EmpresaCreate');
    }

    function edit(Empresa $empresa)
    {
        return Inertia::render('Empresa/EmpresaEdit', [
            'empresa' => $empresa
        ]);
    }

    function store(Request $request)
    {
        $empresa = Empresa::create($request->all());
        return redirect()->route('empresas.index');
    }

    function update(Request $request, Empresa $empresa)
    {
        $empresa->update($request->all());
        return redirect()->route('empresas.index');
    }

    function destroy(Empresa $empresa)
    {
        $empresa->delete();
        return response()->json(['success' => true]);
    }
}
