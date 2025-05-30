<?php

namespace App\Http\Controllers;

use App\Models\Area;
use Illuminate\Http\Request;
use Inertia\Inertia;
use Throwable;

class areaController extends Controller
{
    //

    public function index()
    {

        return Inertia::render('Area/AreaIndex', [
            'areas' => Area::all(),
        ]);
    }

    public function findAll(Request $request)
    {
        $query = Area::query();

        $pageSize = $request->get('rows');
        $page = $request->get('page');
        $filter = $request->get('filter', '');
        $sortField = $request->get('sortField', 'id');
        $sortOrder = $request->get('sortOrder', 'asc');

        if (!$pageSize && !$page) {
            if ($filter) {
                $query->where('id', 'like', '%' . $filter . '%')
                    ->orWhere('nombre', 'like', '%' . $filter . '%')
                    ->orWhere('descripcion', 'like', '%' . $filter . '%');
            }

            if (in_array($sortField, ['id', 'nombre', 'descripcion'])) {
                $query->orderBy($sortField, $sortOrder);
            }

            $areas = $query->get();
            return response()->json($areas);
        }

        if ($pageSize && $page) {
            if ($filter) {
                $query->where('id', 'like', '%' . $filter . '%')
                    ->orWhere('nombre', 'like', '%' . $filter . '%')
                    ->orWhere('descripcion', 'like', '%' . $filter . '%');
            }

            if (in_array($sortField, ['id', 'nombre', 'descripcion'])) {
                $query->orderBy($sortField, $sortOrder);
            }

            $areas = $query->where('deleted_at', null)->paginate($pageSize, ['*'], 'page', $page);
            return response()->json($areas);
        }
    }


    function create()
    {
        return Inertia::render('Area/AreaCreate', [
            'areas' => Area::all(),
        ]);
    }

    function store(Request $request)
    {

        $area = Area::create($request->only('nombre', 'descripcion', 'color'));
        return redirect()->route('area.index');
    }

    function edit($id)
    {
        return Inertia::render('Area/AreaEdit', [
            'area' => Area::find($id),
            'areas' => Area::all(),
        ]);
    }

    function update(Request $request, $id)
    {
        $area = Area::find($id);
        $area->update($request->only('nombre', 'descripcion', 'color'));
        return redirect()->route('area.index');
    }

    function destroy($id)
    {
        $area = Area::find($id);
        $area->delete();
        return response()->json(['areas' => Area::all()]);
    }
}
