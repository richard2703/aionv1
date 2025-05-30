<?php

namespace App\Http\Controllers;

use App\Models\encargado_flujo;
use App\Models\metas;
use Illuminate\Http\Request;
use Inertia\Inertia;
use Carbon\Carbon;
use App\Models\metatrimestres;
use App\Models\metaflujos;

class metasController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        // dd("metas");
        return Inertia::render('metas/MetasIndex');
    }

    public function findAllMetas(Request $request)
    {
        $query = metatrimestres::query();
        // if ($pageSize && $page) {
        //     $departamentos = $query->with('kpis')->paginate($pageSize, ['*'], 'page', $page);
        // } else {
        //     $departamentos = $query->with('kpis')->get();
        // }
        $pageSize = $request->get('rows', 10);
        $page = $request->get('page', 1);
        $filters = $request->get('filter', '');
        $sortField = $request->get('sortField', 'id');
        $sortOrder = $request->get('sortOrder', 'asc');

        $metasTrimestre = $query->orderBy('created_at', 'desc')->paginate($pageSize, ['*'], 'page', $page);

        // $metasTrimestre = $query->orderBy('created_at', 'desc')->get();


        return response()->json($metasTrimestre);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        return Inertia::render('metas/MetasCreate');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        // dd($request);
        // Obtener la fecha actual
        $fechaActual = Carbon::now();

        // Obtener el trimestre actual
        $trimestreActual = $fechaActual->quarter;

        // Obtener el siguiente trimestre
        $trimestreSiguiente = $trimestreActual + 1;

        // Si el trimestre actual es el cuarto, el siguiente sería el primero del próximo año
        if ($trimestreSiguiente > 4) {
            $trimestreSiguiente = 1;
            $añoSiguiente = $fechaActual->addYear()->year;
        } else {
            $añoSiguiente = $fechaActual->year;
        }

        $ultimoTrimestre = metatrimestres::where('trimestre', $trimestreSiguiente)->orderby('created_at', 'desc')->first();

        if ($añoSiguiente != isset($ultimoTrimestre->ano)) {
            // Determinar el primer y último día del siguiente trimestre
            switch ($trimestreSiguiente) {
                case 1: // Primer trimestre: Enero, Febrero, Marzo
                    $inicioTrimestre = Carbon::create($añoSiguiente, 1, 1);
                    $finTrimestre = Carbon::create($añoSiguiente, 3, 31);
                    break;
                case 2: // Segundo trimestre: Abril, Mayo, Junio
                    $inicioTrimestre = Carbon::create($añoSiguiente, 4, 1);
                    $finTrimestre = Carbon::create($añoSiguiente, 6, 30);
                    break;
                case 3: // Tercer trimestre: Julio, Agosto, Septiembre
                    $inicioTrimestre = Carbon::create($añoSiguiente, 7, 1);
                    $finTrimestre = Carbon::create($añoSiguiente, 9, 30);
                    break;
                case 4: // Cuarto trimestre: Octubre, Noviembre, Diciembre
                    $inicioTrimestre = Carbon::create($añoSiguiente, 10, 1);
                    $finTrimestre = Carbon::create($añoSiguiente, 12, 31);
                    break;
            }

            // Crear el nuevo trimestre
            $nuevoTrimestre = new metatrimestres();
            $nuevoTrimestre->trimestre = $trimestreSiguiente;
            $nuevoTrimestre->ano = $añoSiguiente;
            $nuevoTrimestre->inicio = $inicioTrimestre;
            $nuevoTrimestre->fin = $finTrimestre;
            $nuevoTrimestre->save();
        } else {
            $nuevoTrimestre = $ultimoTrimestre;
        }
        $ultimoMetaFlujo = metaflujos::where('trimestre_id', $nuevoTrimestre->id)->where('departamento_id', $request->departamento_id)->first();
        if ($ultimoMetaFlujo != null) {
            return back()->withErrors([
                'message' => 'Solo se puede un reporte por trimestre para este departamento.',
            ]);
        }
        // Crear el el registro del flujo
        $metaflujo = metaflujos::create([
            'departamento_id' => $request->departamento_id,
            'trimestre_id' => $nuevoTrimestre->id,
            'created_for' => auth()->id(),
        ]);

        // Guardar los treintas
        foreach ($request->treintas as $treinta) {
            if ($treinta != null) {
                # code...
                metas::create([
                    'departamento_id' => $request->departamento_id,
                    'trimestre_id' => $nuevoTrimestre->id,
                    'metaFlujo_id' => $metaflujo->id,
                    'tipo' => 1, // 1 para treintas
                    'meta' => $treinta,
                    'created_for' => auth()->id(), // Asignar al usuario autenticado
                ]);
            }
        }

        // Guardar los sesentas
        foreach ($request->sesentas as $sesenta) {
            if ($sesenta != null) {
                # code...
                metas::create([
                    'departamento_id' => $request->departamento_id,
                    'trimestre_id' => $nuevoTrimestre->id,
                    'metaFlujo_id' => $metaflujo->id,
                    'tipo' => 2, // 2 para sesentas
                    'meta' => $sesenta,
                    'created_for' => auth()->id(), // Asignar al usuario autenticado
                ]);
            }
        }

        // Guardar los noventas
        foreach ($request->noventas as $noventa) {
            if ($noventa != null) {
                # code...
                metas::create([
                    'departamento_id' => $request->departamento_id,
                    'trimestre_id' => $nuevoTrimestre->id,
                    'metaFlujo_id' => $metaflujo->id,
                    'tipo' => 3, // 3 para noventas
                    'meta' => $noventa,
                    'created_for' => auth()->id(), // Asignar al usuario autenticado
                ]);
            }
        }

        return redirect()->route('Mismetas.index');
    }

    /**
     * Display the specified resource.
     */
    public function show(metas $metas)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit($metaFlujo)
    {
        $metaFlujo = metaflujos::where('id', $metaFlujo)->with(['trimestre', 'departamento', 'treintas', 'sesentas', 'noventas'])->first();
        // dd($metaFlujo);
        return Inertia::render('metas/MetasEdit', ['metaFlujo' => $metaFlujo]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, $metaFlujo)
    {
        // dd($request);

        $validatedData = $request->validate([
            'departamento_id' => 'required|exists:departamentos,id',
            'treintas' => 'array',
            'sesentas' => 'array',
            'noventas' => 'array',
            'treintasStatus' => 'array',
            'sesentasStatus' => 'array',
            'noventasStatus' => 'array',
        ]);

        $metaFlujo = metaflujos::findOrFail($metaFlujo);
        $metaFlujo->update($validatedData);

        $metaFlujo->treintas()->delete(); // Elimina los existentes
        foreach ($validatedData['treintas'] as $index => $treinta) {
            // dd(!empty($highlight));
            if (!empty($treinta)) {
                metas::create([
                    'departamento_id' => $metaFlujo->departamento_id,
                    'trimestre_id' => $metaFlujo->trimestre_id,
                    'metaFlujo_id' => $metaFlujo->id,
                    'tipo' => 1,
                    'meta' => $treinta,
                    'created_for' => auth()->id(), // Asignar al usuario autenticado
                    // 'status' => $validatedData['treintasStatus'][$index], // Estado correspondiente
                    'status' => $validatedData['treintasStatus'][$index], // Estado correspondiente
                ]);
            }
        }
        $metaFlujo->sesentas()->delete(); // Elimina los existentes
        foreach ($validatedData['sesentas'] as $index => $sesenta) {
            // dd(!empty($highlight));
            if (!empty($sesenta)) {
                metas::create([
                    'departamento_id' => $metaFlujo->departamento_id,
                    'trimestre_id' => $metaFlujo->trimestre_id,
                    'metaFlujo_id' => $metaFlujo->id,
                    'tipo' => 2,
                    'meta' => $sesenta,
                    'created_for' => auth()->id(), // Asignar al usuario autenticado
                    'status' => $validatedData['sesentasStatus'][$index], // Estado correspondiente
                ]);
            }
        }

        $metaFlujo->noventas()->delete(); // Elimina los existentes
        foreach ($validatedData['noventas'] as $index => $noventa) {
            // dd(!empty($highlight));
            if (!empty($noventa)) {
                metas::create([
                    'departamento_id' => $metaFlujo->departamento_id,
                    'trimestre_id' => $metaFlujo->trimestre_id,
                    'metaFlujo_id' => $metaFlujo->id,
                    'tipo' => 3,
                    'meta' => $noventa,
                    'created_for' => auth()->id(), // Asignar al usuario autenticado
                    'status' => $validatedData['noventasStatus'][$index], // Estado correspondiente
                ]);
            }
        }

        return redirect()->route('Mismetas.index');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(metas $metas)
    {
        //
    }

    public function misMetas()
    {
        // $departamentosIds = encargado_flujo::where('user_id', auth()->id())
        //     ->pluck('departamento_id');
        // $metas = metaflujos::whereIn('departamento_id', $departamentosIds)
        //     ->with(['trimestre', 'departamento'])
        //     ->orderby('created_at', 'desc')
        //     ->get();
        // // dd($metas);
        // return Inertia::render('metas/MetasMisMetas', ['metas' => $metas]);
        return Inertia::render('metas/MetasMisMetas');
    }
    public function misMetasIndex(Request $request)
    {
        // $departamentosIds = encargado_flujo::where('user_id', auth()->id())
        //     ->pluck('departamento_id');
        // $metas = metaflujos::whereIn('departamento_id', $departamentosIds)
        //     ->with(['trimestre', 'departamento'])
        //     ->orderby('created_at', 'desc')
        //     ->get();
        // // dd($metas);

        $departamentosIds = encargado_flujo::where('user_id', auth()->id())
            ->pluck('departamento_id');
        $query = metaflujos::query();
        $pageSize = $request->get('rows', 10);
        $page = $request->get('page', 1);
        $filters = $request->get('filter', '');
        $sortField = $request->get('sortField', 'id');
        $sortOrder = $request->get('sortOrder', 'asc');
        $query->whereIn('departamento_id', $departamentosIds);

        $metas = $query->with(['trimestre', 'departamento'])->orderBy('created_at', 'desc')->paginate($pageSize, ['*'], 'page', $page);

        // $metasTrimestre = $query->orderBy('created_at', 'desc')->get();


        return response()->json($metas);
    }

    public function metas($trimestre)
    {
        // $metas = metaflujos::where('trimestre_id', $trimestre)->with(['trimestre', 'departamento'])->orderby('created_at', 'desc')->get();
        // dd($trimestre);
        return Inertia::render('metas/MetasTrimestre', ['trimestre' => $trimestre]);
    }

    public function getMetasTrimestre(Request $request)
    {
        // dd("getMetasTrimestre");
        $query = metaflujos::query();
        $pageSize = $request->get('rows', 10);
        $page = $request->get('page', 1);
        $filters = $request->get('filter', '');
        $sortField = $request->get('sortField', 'id');
        $sortOrder = $request->get('sortOrder', 'asc');

        $trimestre = $request->get('pediodo', '');

        $query->where('trimestre_id', $trimestre);

        $metas = $query->with(['trimestre', 'departamento'])->orderBy('created_at', 'desc')->paginate($pageSize, ['*'], 'page', $page);

        return response()->json($metas);
    }
}
