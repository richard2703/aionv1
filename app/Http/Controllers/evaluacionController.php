<?php

namespace App\Http\Controllers;

use App\Models\AreaEvaluacion;
use App\Models\Assessment;
use App\Models\AssessmentAsignado;
use App\Models\DepartamentoEvaluacion;
use App\Models\Respuesta;
use App\Models\Seccion;
use Illuminate\Http\Request;
use Inertia\Inertia;

class evaluacionController extends Controller
{

    public function index()
    {
        return Inertia::render('Evaluacion/EvaluacionIndex');
    }

    public function findAll(Request $request)
    {

        $query = Assessment::query();
        $pageSize = $request->get('rows', 10);
        $page = $request->get('page', 1);
        $filter = $request->get('filter', '');
        $sortField = $request->get('sortField', 'id');
        $sortOrder = $request->get('sortOrder', 'asc');

        // if ($filter) {
        //     $query->where(function ($q) use ($filter) {
        //         $q->where('assessments.id', 'like', '%' . $filter . '%')
        //             ->orWhere('assessments.titulo', 'like', '%' . $filter . '%');
        //     });
        // }

        // $query->withCount(['AssessmentAsignado as seccion_incompleta' => function ($query) {
        //     $query->where('estatus', 'INCOMPLETO');
        // }]);

        $query->withCount('AssessmentAsignado as seccion_total');

        $query->withCount(['AssessmentAsignado as seccion_completa' => function ($query) {
            $query->where('estatus', 'COMPLETADO');
        }]);

        if ($sortField) {
            $query->orderBy($sortField, $sortOrder);
        }

        $result = $query->paginate($pageSize, ['*'], 'page', $page);

        return response()->json($result);
    }

    public function edit() {}

    public function create()
    {
        $userId = auth()->user()->id;

        // Get the latest assessment for the authenticated user
        $lastAssessment = Assessment::latest('created_at')
            ->first();
        // Check if the latest assessment is older than 3 months or doesn't exist
        if (!$lastAssessment || $lastAssessment->created_at->lt(now()->subMonths(3))) {
            // Create a new assessment
            $assessment = new Assessment;
            $assessment->created_by = $userId;
            $assessment->save();

            // Fetch all sections and create associated records
            $secciones = Seccion::get();
            foreach ($secciones as $seccion) {
                AssessmentAsignado::create([
                    'assessment_id' => $assessment->id,
                    'seccion_id' => $seccion->id,
                    'estatus' => 'INCOMPLETO',
                ]);
            }

            // Redirect to the evaluation selection route
            return redirect(route('evaluacion.select', $assessment->id));
        }

        // If the last assessment is less than 3 months old, return with an error message or redirect
        return redirect()->back()->with('error', 'Solo puede crear una nueva evaluación cada 3 meses.');
    }


    public function show(Assessment $evaluacion) {}

    public function select(Assessment $evaluacion)
    {
        $user = auth()->user();
        $evaluacion->load(
            'AssessmentAsignado',
            'AssessmentAsignado.seccion',
            'AssessmentAsignado.seccion.area',
        );

        $promedios = Respuesta::where('assessment_id', $evaluacion->id)
            ->selectRaw('seccion_id, AVG(valor_opcion) as promedio_seccion')
            ->groupBy('seccion_id')
            ->get()
            ->keyBy('seccion_id');

        $asignadosPorArea = $evaluacion->AssessmentAsignado->groupBy(function ($asignado) {
            return $asignado->seccion->area->nombre;
        });

        // Merge the averages with the existing data
        foreach ($asignadosPorArea as $area => $asignados) {
            foreach ($asignados as $asignado) {
                $asignado->promedio_seccion = $promedios[$asignado->seccion_id]->promedio_seccion ?? null;
            }
        }

        return Inertia::render(
            'Evaluacion/EvaluacionSelector',
            [
                'evaluacion' => $asignadosPorArea,
                'usuario' => $user,
            ]
        );
    }
    public function form(AssessmentAsignado $assessmentAsignado)
    {
        $assessmentAsignado->load(
            'assessment',
            'seccion.challenge.opciones',
        );

        return Inertia::render(
            'Evaluacion/EvaluacionForm',
            ['assessmentAsignado' => $assessmentAsignado,]
        );
    }

    public function details(Assessment $evaluacion)
    {
        $promedioGlobal = AreaEvaluacion::where('assessment_id', $evaluacion->id)
            ->avg('score');

        $promedioGente = AreaEvaluacion::where('area_id', 1)
            ->where('assessment_id', $evaluacion->id)
            ->avg('score');

        $promedioProcess = AreaEvaluacion::where('area_id', '<>', 1)
            ->where('assessment_id', $evaluacion->id)
            ->avg('score');

        $evaluacion->global = $promedioGlobal;
        $evaluacion->gente = $promedioGente;
        $evaluacion->proceso = $promedioProcess;

        return Inertia::render('Evaluacion/EvaluacionBenchmark', ['evaluacion' => $evaluacion]);
    }

    public function destroy() {}

    public function update() {}

    public function store(Request $request)
    {
        $assessmentAsignadoId = $request->post('challenge1')['assessmentAsignado_id'];
        $assessmentId = $request->post('challenge1')['assessment_id'];

        foreach ($request->all() as $key => $value) {
            $score = match ($value['valor_opcion']) {
                'Nulo' => 5,
                'Basico' => 30,
                'Maduro' => 55,
                'Avanzado' => 90,
                default => 5,
            };

            $data = [
                'assessment_id' => $value['assessment_id'],
                'seccion_id' => $value['seccion_id'],
                'area_id' => $value['area_id'],
                'departamento_id' => $value['departamento_id'],
                'challenge_id' => $value['challenge_id'],
                'opcion_id' => $value['opcion_id'],
                'valor_opcion' => $score,
            ];
            $assessmentRespuestas = Respuesta::create($data);
        }

        if ($assessmentRespuestas) {
            $assessmentAsignado = AssessmentAsignado::find($assessmentAsignadoId);
            $assessmentAsignado->update(['estatus' => 'COMPLETADO']);

            $countIncompleted = AssessmentAsignado::where('assessment_id', $assessmentId)
                ->where('estatus', '=', 'INCOMPLETO')
                ->count();

            // if (1 == 1) { // Aquí podrías mantener tu condición real
            $promedioSeccion = Respuesta::where('assessment_id', $assessmentId)
                ->where('seccion_id', $assessmentAsignado->seccion_id)
                ->get()
                ->groupBy('seccion_id')
                ->map(fn($group) => $group->avg('valor_opcion'));

            foreach ($promedioSeccion as $seccionId => $score) {
                DepartamentoEvaluacion::create([
                    'assessment_id' => $assessmentId,
                    'seccion_id' => $seccionId,
                    'score' => $score,
                ]);
                // }

                // if (1 == 1) { // Aquí podrías mantener tu condición real
                $promedioArea = Respuesta::where('assessment_id', $assessmentId)
                    ->where('area_id', $data['area_id'])
                    ->get()
                    ->groupBy('area_id')
                    ->map(fn($group) => $group->avg('valor_opcion'));

                foreach ($promedioArea as $areaId => $score) {
                    AreaEvaluacion::updateOrCreate(
                        [
                            'assessment_id' => $assessmentId,
                            'area_id' => $areaId,
                        ],
                        [
                            'score' => $score,
                        ]
                    );
                }
                // }
            }
        }

        return response()->json('success', 201);
    }


    function radarChart(Assessment $evaluacion)
    {
        $areaEvaluacion = AreaEvaluacion::with('area', 'assessment')->where('assessment_id', $evaluacion->id)->get();
        return response()->json($areaEvaluacion);
    }
    function barChart(Assessment $evaluacion)
    {
        $departamentoEvaluacion = DepartamentoEvaluacion::with('departamento', 'assessment', 'seccion')->where('assessment_id', $evaluacion->id)->get();
        return response()->json($departamentoEvaluacion);
    }
    function scatterChart(Assessment $evaluacion)
    {
        $areaEvaluacion = AreaEvaluacion::with('area', 'assessment')->where('assessment_id', $evaluacion->id)->get();
        $promedioGente = AreaEvaluacion::where('area_id', 1)
            ->where('assessment_id', $evaluacion->id)
            ->avg('score');

        $promedioProcess = AreaEvaluacion::where('area_id', '<>', 1)
            ->where('assessment_id', $evaluacion->id)
            ->avg('score');

        $result = [
            'promedioGente' => $promedioGente,
            'promedioProcess' => $promedioProcess,
        ];


        return response()->json($result);
    }

    function getUltimaEvaluacion()
    {
        $evaluacion = Assessment::orderBy('id', 'desc')->first();
        return response()->json($evaluacion);
    }
}
