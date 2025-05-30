<?php

namespace App\Http\Controllers;

use App\Models\Opcion;
use Illuminate\Http\Request;
use Inertia\Inertia;

class opcionController extends Controller
{
    //
    function index()
    {
        return Inertia::render('Opcion/OpcionIndex');
    }

    public function findAll(Request $request)
    {
        $query = Opcion::query();
        $pageSize = $request->get('rows', 10);
        $page = $request->get('page', 1);
        $filter = $request->get('filter', '');
        $sortField = $request->get('sortField', 'id');
        $sortOrder = $request->get('sortOrder', 'asc');

        if ($filter) {
            $query->where(function ($q) use ($filter) {
                $q->where('opciones.id', 'like', '%' . $filter . '%')
                    ->orWhere('opciones.alias', 'like', '%' . $filter . '%')
                    ->orWhere('opciones.formal', 'like', '%' . $filter . '%')
                    ->orWhere('opciones.informal', 'like', '%' . $filter . '%')
                    ->orWhereHas('challenge', function ($q) use ($filter) {
                        $q->where('challenges.challenge', 'like', '%' . $filter . '%');
                    });
            });
        }

        if (in_array($sortField, ['id', 'alias', 'formal', 'informal', 'challenge.challenge'])) {
            if ($sortField == 'challenge.challenge') {
                $query->join('challenges', 'opciones.challenge_id', '=', 'challenges.id')
                    ->select('opciones.*', 'challenges.challenge as challenge_name') // Select distinct columns
                    ->orderBy('challenges.challenge', $sortOrder);
            } else {
                $query->orderBy($sortField, $sortOrder);
            }
        }

        $result = $query->with('challenge')->paginate($pageSize, ['*'], 'page', $page);

        return response()->json($result);
    }



    public function create()
    {
        return Inertia::render('Opcion/OpcionCreate');
    }

    public function store(Request $request)
    {
        Opcion::create($request->only('challenge_id', 'madurez', 'formal', 'informal'));
        return redirect()->route('opcion.index');
    }

    public function show($challenges)
    {
        //
    }

    public function edit($id)
    {
        $challenge = Opcion::with('challenge')->find($id);
        return Inertia::render('Opcion/OpcionEdit', ['opcion' => $challenge]);
    }

    public function update(Request $request, $id)
    {

        $challenge = Opcion::find($id);
        $challenge->update($request->only('challenge_id', 'madurez', 'formal', 'informal'));
        return redirect()->route('opcion.index');
    }

    public function destroy($id)
    {
        $challenge = Opcion::find($id);
        $challenge->delete();
        return response()->json(['opcion' => Opcion::with('challenge')->get(),]);
    }
}
