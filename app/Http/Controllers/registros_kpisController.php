<?php

namespace App\Http\Controllers;

use App\Models\Kpis;
use App\Models\registros_kpi;
use Illuminate\Http\Request;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;

class registros_kpisController extends Controller
{
    public function store(Request $request)
    {
        // Registrar valor de kpi
        $registro_kpi = new registros_kpi();
        $registro_kpi->kpi_id = $request->kpi_id;
        $registro_kpi->actual = $request->actual;
        $registro_kpi->objetivo = $request->objetivo;
        $registro_kpi->medicion = $request->medicion;
        $registro_kpi->regla = $request->regla;
        $registro_kpi->created_for = auth()->user()->id;
        $registro_kpi->save();

        // Actualizar promedio y actual de kpi
        $promedio = registros_kpi::where('kpi_id', $request->kpi_id)
            ->latest('created_at')
            ->take(12)
            ->avg('actual');
        $kpi = Kpis::find($request->kpi_id);
        $kpi->promedio = $promedio;
        $kpi->actual = $request->actual;
        $kpi->save();

        return response()->json(['success' => 'KPI Creado'], 200);
    }

    public function edit(registros_kpi $registros_kpi)
    {
        $registros_kpi->load('kpis');
        return response()->json($registros_kpi);
    }

    public function update(Request $request, registros_kpi $registros_kpi)
    {
        $latestRegistro = registros_kpi::where('kpi_id', $registros_kpi->kpi_id)
            ->latest('created_at')
            ->first();

        if ($latestRegistro->id === $registros_kpi->id) {
            $registros_kpi->update($request->only('actual'));
            $kpi = Kpis::find($registros_kpi->kpi_id);
            $kpi->actual = $request->actual;
            $kpi->save();
        } else {
            $registros_kpi->update($request->only('actual'));
        }


        $promedio = registros_kpi::where('kpi_id', $registros_kpi->kpi_id)
            ->latest('created_at')
            ->take(12)
            ->avg('actual');

        $kpi = Kpis::find($registros_kpi->kpi_id);
        $kpi->promedio = $promedio;
        $kpi->save();

        return response()->json(['success' => true]);
    }

    public function promedio(Kpis $kpi)
    {
        $promedio = registros_kpi::where('kpi_id', $kpi->id)
            ->whereYear('created_at', now()->year)
            ->latest('created_at')
            ->take(12)
            ->avg('actual');

        return response()->json(['promedio' => $promedio], 200);
    }

    public function registros($id)
    {
        // $registros = registros_kpi::select(
        //     'id',
        //     'kpi_id',
        //     'actual',
        //     'promedio',
        //     'created_at',
        // )
        //     ->where('kpi_id', $id)
        //     ->whereYear('created_at', Carbon::now()->year)
        //     ->orderBy('created_at', 'asc')
        //     ->skip(registros_kpi::where('kpi_id', $id)->count() - 22)
        //     ->take(22)
        //     ->get();

        $total = registros_kpi::where('kpi_id', $id)
            ->whereYear('created_at', Carbon::now()->year)
            ->count();

        $offset = max(0, $total - 22);

        $registros = registros_kpi::select('id', 'kpi_id', 'actual', 'promedio', 'created_at')
            ->where('kpi_id', $id)
            ->whereYear('created_at', Carbon::now()->year)
            ->orderBy('created_at', 'asc')
            ->skip($offset)
            ->take(22)
            ->get();

        Carbon::setLocale('es');

        return response()->json($registros);
    }
}
