<?php

namespace App\Http\Controllers;

use App\Models\Evento;
use Illuminate\Http\Request;
use Inertia\Inertia;
use Carbon\Carbon;

class eventoController extends Controller
{
    //
    function index()
    {
        return Inertia::render('Evento/EventoIndex', [
            'eventos' => Evento::with('area')->get()
        ]);
    }

    function findAll()
    {
        $eventos = Evento::where('fecha_inicio', '>=', date('Y-m-d'))
            ->orderBy('fecha_inicio', 'asc')
            ->with('area')
            ->get();
        return response()->json($eventos);
    }

    function byDate($date)
    {
        $eventos = Evento::where('fecha_inicio', '=', $date)
            ->orderBy('fecha_inicio', 'asc')
            ->with('area')
            ->get();
        return response()->json($eventos);
    }

    function edit() {}

    function show() {}

    function create() {}

    // function store(Request $request)
    // {
    //     $data = [
    //         'titulo' => $request->titulo,
    //         'descripcion' => $request->descripcion,
    //         'fecha_inicio' => $request->fecha_inicio,
    //         'fecha_final' => $request->fecha_final,
    //         'area_id' => $request->area_id
    //     ];
    //     Evento::create($data);
    //     return response()->json(['success' => true]);
    // }

    function store(Request $request)
    {
        $data = $request->validate([
            'titulo' => 'required|string|max:255',
            'descripcion' => 'nullable|string',
            'fecha_inicio' => 'required|date',
            'fecha_final' => 'nullable|date|after_or_equal:fecha_inicio',
            'area_id' => 'required|exists:areas,id',
            'recurrencia' => 'required|in:none,daily,weekly,monthly',
            'dia_semana' => 'nullable|integer|min:0|max:6',
            'dia_mes' => 'nullable|string',
            'num_repeticiones' => 'nullable|integer|min:1',
            'ubicacion' => 'nullable|string|min:1',
            'link' => 'nullable|string|min:1',
        ]);

        $fechaInicio = Carbon::parse($data['fecha_inicio']);
        $eventosCreados = [];

        if ($data['recurrencia'] === 'none') {
            $evento = Evento::create($data);
            $eventosCreados[] = $evento;
        } else {
            for ($i = 0; $i < $data['num_repeticiones']; $i++) {
                switch ($data['recurrencia']) {
                    case 'daily':
                        $nuevaFecha = $fechaInicio->copy()->addDays($i);
                        break;

                    case 'weekly':
                        $nuevaFecha = $fechaInicio->copy()->addWeeks($i)->next($data['dia_semana']);
                        break;

                    case 'monthly':
                        $diaMes = str_replace('_', ' ', strtolower($data['dia_mes'])); // Reemplaza _ con espacios y convierte a minúsculas
                        $nuevaFecha = $fechaInicio->copy()->addMonths($i)->modify($diaMes);
                        break;
                }

                $evento = Evento::create([
                    'titulo' => $data['titulo'],
                    'descripcion' => $data['descripcion'],
                    'fecha_inicio' => $nuevaFecha,
                    'fecha_final' => isset($data['fecha_final']) ? $nuevaFecha->copy()->addDays(1) : null,
                    'area_id' => $data['area_id'],
                    'recurrencia' => $data['recurrencia'],
                    'dia_semana' => $data['dia_semana'] ?? null,
                    'dia_mes' => $data['dia_mes'] ?? null,
                    'num_repeticiones' => $data['num_repeticiones'],
                    'ubicacion' => $data['ubicacion'],
                    'link' => $data['link'],
                ]);

                $eventosCreados[] = $evento;
            }
        }

        return response()->json(['success' => true, 'eventos' => $eventosCreados]);
    }

    function update(Request $request, Evento $evento)
    {
        $data = [
            'titulo' => $request->titulo,
            'descripcion' => $request->descripcion,
            'fecha_inicio' => $request->fecha_inicio,
            'fecha_final' => $request->fecha_final,
            'area_id' => $request->area_id
        ];
        $evento->update($data);
        return response()->json(['success' => true]);
    }

    function destroy(Evento $evento)
    {
        $evento->delete();
        return response()->json(['success' => true]);
    }
}
