<?php

namespace App\Http\Controllers;

use App\Models\Departamento;
use App\Models\Kpis;
use App\Models\Proceso;
use App\Models\registros_kpi;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Inertia\Inertia;
use Carbon\Carbon;

class sysGestionController extends Controller
{
    public function index()
    {
        $user = auth()->user();
        return Inertia::render(
            'sysGestion/sysGestionIndex',
            [
                'user' => $user
            ]
        );
    }

    public function dashboard()
    {
        return Inertia::render('sysGestion/Dashboard');
    }

    public function kpis(Request $request)
    {
        $query = Kpis::query();
        $pageSize = $request->get('rows', 10);
        $page = $request->get('page', 1);
        $filter = $request->get('filter', '');
        $sortField = $request->get('sortField', 'id');
        $sortOrder = $request->get('sortOrder', 'asc');

        // Filter logic
        if ($filter) {
            $query->where(function ($q) use ($filter) {
                $q->where('kpis.id', 'like', '%' . $filter . '%')
                    ->orWhere('kpis.nombre', 'like', '%' . $filter . '%')
                    ->orWhere('kpis.descripcion', 'like', '%' . $filter . '%')
                    ->orWhere('kpis.link_externo', 'like', '%' . $filter . '%')
                    ->orWhereHas('procedimiento', function ($q) use ($filter) {
                        $q->where('procedimientos.nombre', 'like', '%' . $filter . '%')
                            ->orWhere('procedimientos.descripcion', 'like', '%' . $filter . '%');
                    });
            });
        }

        // Sorting logic
        if (in_array($sortField, ['id', 'nombre', 'descripcion', 'link_externo', 'procedimiento.nombre'])) {
            if (strpos($sortField, 'procedimiento.') === 0) {
                $query->join('procedimientos', 'kpis.procedimiento_id', '=', 'procedimientos.id')
                    ->select('kpis.*', 'procedimientos.nombre as procedimiento_nombre') // Select distinct columns
                    ->orderBy('procedimientos.nombre', $sortOrder);
            } else {
                $query->orderBy('kpis.' . $sortField, $sortOrder);
            }
        } else {
            // Default sorting if the provided sortField is not allowed
            $query->orderBy('id', $sortOrder);
        }

        $kpis = $query->with('area', 'departamento', 'proceso', 'procedimiento')->paginate($pageSize, ['*'], 'page', $page);

        return response()->json($kpis);
    }

    public function departamento(Departamento $departamento_id)
    {
        $departamento = $departamento_id->load('procesos');
        // $departamento = $departamento->load('kpis');
        $kpis = Kpis::where('departamento_id', $departamento_id->id)
            ->where('tipo', 2)->get();
        // $registros = registros_kpi::select('kpi_id', 'actual', 'created_at')->where('kpi_id', $kpis[0]->id)->get();
        $registros = registros_kpi::select(
            'id',
            'kpi_id',
            'actual',
            'promedio',
            'created_at',
        )->where('kpi_id', $kpis[0]->id)->get();

        Carbon::setLocale('es');

        // $registros->transform(function ($item) {
        //     $item->mes = Carbon::parse($item->created_at)->translatedFormat('F');
        //     return $item;
        // });
        return response()->json(['departamento' => $departamento, 'kpis' => $kpis, 'registros' => $registros]);
    }
}
