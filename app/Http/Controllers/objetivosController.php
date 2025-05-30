<?php

namespace App\Http\Controllers;

use App\Models\objetivos;
use Illuminate\Http\Request;
use Inertia\Inertia;

class objetivosController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return Inertia::render('Objetivos/ObjetivosIndex');
    }

    public function findAll(Request $request)
    {
        $query = objetivos::query();
        $pageSize = $request->get('rows', 10);
        $page = $request->get('page', 1);
        $filter = $request->get('filter', '');
        $sortField = $request->get('sortField', 'id');
        $sortOrder = $request->get('sortOrder', 'asc');

        if ($filter) {
            $query->where(function ($q) use ($filter) {
                $q->where('id', 'like', '%' . $filter . '%')
                    ->orWhere('objetivo', 'like', '%' . $filter . '%')
                    ->orWhere('meta', 'like', '%' . $filter . '%');
            });
        }

        if (in_array($sortField, ['id', 'meta', 'objetivo'])) {
            $query->orderBy($sortField, $sortOrder);
        }

        $result = $query->paginate($pageSize, ['*'], 'page', $page);

        return response()->json($result);
    }


    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        return Inertia::render('Objetivos/ObjetivoCreate');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $objetivos = objetivos::create($request->only('meta', 'objetivo'));
        return redirect()->route('objetivo.index');
    }

    /**
     * Display the specified resource.
     */
    public function show(objetivos $objetivos)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(objetivos $objetivo)
    {

        return Inertia::render('Objetivos/ObjetivoEdit', ['objetivo' => $objetivo]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, objetivos $objetivo)
    {
        //
        $objetivo->update($request->only('meta', 'objetivo'));
        return redirect()->route('objetivo.index');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(objetivos $objetivo)
    {

        $objetivo->delete();
        return response()->json(['objetivos' => "ok"]);
    }
}
