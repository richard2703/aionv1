<?php

namespace App\Http\Controllers;

use App\Models\Challenge;
use Illuminate\Http\Request;
use Inertia\Inertia;

class challengesController extends Controller
{

    public function index()
    {

        return Inertia::render('Challenges/ChallengesIndex', [
            'challenges' => Challenge::with('area', 'departamento')->get(),
        ]);
    }

    function byArea($area_id)
    {
        return response()->json(['challenges' => Challenge::where('area_id', $area_id)->get()]);
    }

    public function findAll(Request $request)
    {
        $query = Challenge::query();
        $pageSize = $request->get('rows', 10);
        $page = $request->get('page', 1);
        $filter = $request->get('filter', '');
        $sortField = $request->get('sortField', 'id');
        $sortOrder = $request->get('sortOrder', 'asc');

        if ($filter) {
            $query->where(function ($q) use ($filter) {
                $q->where('challenges.id', 'like', '%' . $filter . '%')
                    ->orWhere('challenges.challenge', 'like', '%' . $filter . '%')
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

        if (in_array($sortField, ['id', 'challenge', 'area.nombre', 'departamento.nombre'])) {
            if (strpos($sortField, 'area.') === 0) {
                $query->join('areas', 'challenges.area_id', '=', 'areas.id')
                    ->select('challenges.*', 'areas.nombre as area_nombre') // Select distinct columns
                    ->orderBy('areas.' . substr($sortField, 5), $sortOrder);
            } else if (strpos($sortField, 'departamento.') === 0) {
                $query->join('departamentos', 'challenges.departamento_id', '=', 'departamentos.id')
                    ->select('challenges.*', 'departamentos.nombre as departamento_nombre') // Select distinct columns
                    ->orderBy('departamentos.' . substr($sortField, 12), $sortOrder);
            } else {
                $query->orderBy($sortField, $sortOrder);
            }
        }

        $challenges = $query->with('area', 'departamento', 'seccion')->paginate($pageSize, ['*'], 'page', $page);

        return response()->json($challenges);
    }


    public function create()
    {
        return Inertia::render('Challenges/ChallengesCreate');
    }

    public function store(Request $request)
    {

        $challenge = Challenge::create($request->only('challenge', 'area_id', 'departamento_id', 'seccion_id'));
        return redirect()->route('challenge.index');
    }

    public function show($challenges)
    {
        //
    }

    public function edit($id)
    {
        $challenge = Challenge::find($id);
        return Inertia::render('Challenges/ChallengesEdit', ['challenge' => $challenge]);
    }

    public function update(Request $request, $id)
    {

        $challenge = Challenge::find($id);
        $challenge->update($request->only('challenge', 'area_id', 'departamento_id', 'seccion_id'));
        return redirect()->route('challenge.index');
    }

    public function destroy($id)
    {
        $challenge = Challenge::find($id);
        $challenge->delete();
        return response()->json(['challenge' => Challenge::with('area', 'departamento')->get(),]);
    }
}
