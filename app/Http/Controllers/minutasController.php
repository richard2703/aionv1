<?php

namespace App\Http\Controllers;

use App\Models\minutas;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\User;
use Carbon\Carbon;
use App\Http\Controllers\helper;
use App\Models\Asistente;
use App\Models\tareas;
use Barryvdh\DomPDF\Facade\Pdf;
use Illuminate\Support\Facades\DB;


class minutasController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $helper = new helper(); // Instancia del controlador
        $tareasVencidas = $helper->tareasVencidas(); // Llamar a la función

        return Inertia::render('Minutas/MinutasIndex', [
            'area_id' => $request->get('area_id'),
            'departamento_id' => $request->get('departamento_id'),
        ]);
    }

    function findAll(Request $request)
    {
        $query = minutas::query(); // Replace 'Model' with the actual model name
        $pageSize = $request->get('rows', 10);
        $page = $request->get('page', 1);
        $filters = $request->get('filter', '');
        $sortField = $request->get('sortField', 'id');
        $sortOrder = $request->get('sortOrder', 'desc');
        $bookmark = $request->get('bookmark', false);

        // Apply global filter if it exists
        if (isset($filters['global']['value']) && !empty($filters['global']['value'])) {
            $globalFilter = $filters['global']['value'];
            $query->where(function ($q) use ($globalFilter) {
                $q->where('id', 'like', '%' . $globalFilter . '%')
                    ->orWhere('alias', 'like', '%' . $globalFilter . '%')
                    ->orWhere('created_at', 'like', '%' . $globalFilter . '%')
                    ->orWhereHas('area', function ($q) use ($globalFilter) {
                        $q->where('areas.nombre', 'like', '%' . $globalFilter . '%')
                            ->orWhere('areas.descripcion', 'like', '%' . $globalFilter . '%');
                    })
                    ->orWhereHas('departamento', function ($q) use ($globalFilter) {
                        $q->where('departamentos.nombre', 'like', '%' . $globalFilter . '%')
                            ->orWhere('departamentos.descripcion', 'like', '%' . $globalFilter . '%');
                    })
                    ->orWhereHas('lider', function ($q) use ($globalFilter) {
                        $q->where('Users.name', 'like', '%' . $globalFilter . '%');
                    })
                    ->orWhereHas('proceso', function ($q) use ($globalFilter) {
                        $q->where('procesos.nombre', 'like', '%' . $globalFilter . '%');
                    })
                    ->orWhereHas('tipoMinuta', function ($q) use ($globalFilter) {
                        $q->where('tipos_minuta.titulo', 'like', '%' . $globalFilter . '%');
                    });
            });
        }

        // Apply specific filters
        $filterableFields = ['area_id', 'departamento_id', 'lider_id', 'tipo', 'proceso_id'];
        foreach ($filterableFields as $field) {

            if (isset($filters[$field]['value']) && !empty($filters[$field]['value'])) {
                $query->Where($field, '=', $filters[$field]['value']);
            }
        }
        // dd($query->toSql());

        // Apply date range filters
        if (isset($filters['desde']['value']) && !empty($filters['desde']['value'])) {
            $query->where('created_at', '>=', $filters['desde']['value']);
        }
        if (isset($filters['hasta']['value']) && !empty($filters['hasta']['value'])) {
            $query->where('created_at', '<=', $filters['hasta']['value']);
        }

        if (isset($filters['hasta']['value']) && !empty($filters['hasta']['value'])) {
            $query->where('created_at', '<=', $filters['hasta']['value']);
        }

        //


        // Sorting logic
        if (in_array($sortField, ['id', 'alias', 'created_at', 'tipo', 'area.nombre', 'departamento.nombre', 'lider.name', 'proceso.nombre', 'tipo_minuta'])) {
            if (strpos($sortField, 'area.') === 0) {
                $query->join('areas', 'minutas.area_id', '=', 'areas.id')
                    ->select('minutas.*', 'areas.nombre as area_nombre') // Select distinct columns
                    ->orderBy('areas.nombre', $sortOrder);
            } else if (strpos($sortField, 'departamento.') === 0) {
                $query->join('departamentos', 'minutas.departamento_id', '=', 'departamentos.id')
                    ->select('minutas.*', 'departamentos.nombre as departamento_nombre') // Select distinct columns
                    ->orderBy('departamentos.nombre', $sortOrder);
            } else if (strpos($sortField, 'lider.') === 0) {
                $query->join('users', 'minutas.lider_id', '=', 'users.id')
                    ->select('minutas.*', 'users.name as lider_name') // Select distinct columns
                    ->orderBy('users.name', $sortOrder);
            } else if (strpos($sortField, 'proceso.') === 0) {
                $query->join('procesos', 'minutas.proceso_id', '=', 'procesos.id')
                    ->select('minutas.*', 'procesos.nombre as procesos_nombre') // Select distinct columns
                    ->orderBy('procesos.nombre', $sortOrder);
            } else if (strpos($sortField, 'tipo_minuta.') === 0) {
                $query->join('tipos_minuta', 'minutas.tipo', '=', 'tipos_minuta.id')
                    ->select('minutas.*', 'tipos_minuta.titulo as tipos_minuta_titulo') // Select distinct columns
                    ->orderBy('tipos_minuta.titulo', $sortOrder);
            } else {
                $query->orderBy('minutas.' . $sortField, $sortOrder);
            }
        } else {
            // Default sorting if the provided sortField is not allowed
            $query->orderBy('id', $sortOrder);
        }

        if ($bookmark) {
            $query->where('bookmark', 1);
        }
        // $result = $query->with('challenge')->paginate($pageSize, ['*'], 'page', $page);
        $result = $query->with('area', 'departamento', 'lider', 'proceso', 'tipoMinuta')->paginate($pageSize, ['*'], 'page', $page);
        return response()->json($result);
    }

    public function create()
    {
        return Inertia::render('Minutas/MinutasCreate');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $minuta = new minutas();
        $minuta->area_id = $request->area_id;
        $minuta->departamento_id = $request->departamento_id;
        if (isset($request->proceso_id["id"])) {
            # code...
            $minuta->proceso_id = $request->proceso_id["id"];
        }
        $minuta->lider_id = $request->lider_id["id"];
        $minuta->alias = $request->alias;
        $minuta->tipo = $request->tipo;
        $minuta->notas = $request->notas;
        $minuta->estatus = $request->estatus;
        $minuta->privada = $request->privada;
        $minuta->save();

        return redirect()->route('minutas.show', $minuta->id);
    }

    /**
     * Display the specified resource.
     */
    public function show(minutas $minuta)
    {
        // Carga las relaciones necesarias
        $minuta->load('lider', 'area', 'departamento', 'proceso', 'tipoMinuta');

        // Format the date
        $dateFromDatabase = $minuta->created_at;
        $formattedDate = Carbon::parse($dateFromDatabase)->format('Y-m-d');

        $minuta->fecha = $formattedDate; // add the formatted date to the object

        return Inertia::render('Minutas/MinutasShow', ['minuta' => $minuta]);
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(minutas $minuta)
    {
        $minuta->load('lider', 'area', 'departamento', 'proceso');
        $user = User::find($minuta->responsable_id);
        return Inertia::render('Minutas/MinutasEdit', ['minuta' => $minuta, 'user' => $user]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, minutas $minuta)
    {
        if (is_array($request->lider_id)) {
            $minuta->lider_id = $request->lider_id["id"];
        }
        if (is_array($request->proceso_id)) {
            $minuta->proceso_id = $request->proceso_id["id"];
        }
        $minuta->area_id = $request->area_id;
        $minuta->departamento_id = $request->departamento_id;
        $minuta->alias = $request->alias;
        $minuta->tipo = $request->tipo;
        $minuta->notas = $request->notas;
        $minuta->estatus = $request->estatus;
        $minuta->privada = $request->privada;
        $minuta->oculto = $request->oculto;


        // Guardar los cambios en la base de datos
        $minuta->save();

        // Redireccionar a la ruta deseada después de la actualización
        return redirect()->route('minutas.index');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(minutas $minuta)
    {
        //
        $minuta->delete();
        return response()->json(['success' => true]);
    }

    // function byArea(Request $request, $area_id)
    // {
    //     $query = minutas::query(); // Replace 'Model' with the actual model name
    //     $pageSize = $request->get('rows', 10);
    //     $page = $request->get('page', 1);
    //     $filters = $request->get('filter', '');
    //     $sortField = $request->get('sortField', 'id');
    //     $sortOrder = $request->get('sortOrder', 'desc');

    //     // Apply global filter if it exists
    //     if (isset($filters['global']['value']) && !empty($filters['global']['value'])) {
    //         $globalFilter = $filters['global']['value'];
    //         $query->where(function ($q) use ($globalFilter) {
    //             $q->where('id', 'like', '%' . $globalFilter . '%')
    //                 ->orWhere('alias', 'like', '%' . $globalFilter . '%')
    //                 ->orWhere('created_at', 'like', '%' . $globalFilter . '%')
    //                 ->orWhereHas('area', function ($q) use ($globalFilter) {
    //                     $q->where('areas.nombre', 'like', '%' . $globalFilter . '%')
    //                         ->orWhere('areas.descripcion', 'like', '%' . $globalFilter . '%');
    //                 })
    //                 ->orWhereHas('departamento', function ($q) use ($globalFilter) {
    //                     $q->where('departamentos.nombre', 'like', '%' . $globalFilter . '%')
    //                         ->orWhere('departamentos.descripcion', 'like', '%' . $globalFilter . '%');
    //                 })
    //                 ->orWhereHas('lider', function ($q) use ($globalFilter) {
    //                     $q->where('Users.name', 'like', '%' . $globalFilter . '%');
    //                 })
    //                 ->orWhereHas('proceso', function ($q) use ($globalFilter) {
    //                     $q->where('procesos.nombre', 'like', '%' . $globalFilter . '%');
    //                 })
    //                 ->orWhereHas('tipoMinuta', function ($q) use ($globalFilter) {
    //                     $q->where('tipos_minuta.titulo', 'like', '%' . $globalFilter . '%');
    //                 });
    //         });
    //     }

    //     // Apply specific filters
    //     $filterableFields = ['area_id', 'departamento_id', 'lider_id', 'tipo', 'proceso_id'];
    //     foreach ($filterableFields as $field) {

    //         if (isset($filters[$field]['value']) && !empty($filters[$field]['value'])) {
    //             $query->Where($field, '=', $filters[$field]['value']);
    //         }
    //     }

    //     // Apply date range filters
    //     if (isset($filters['desde']['value']) && !empty($filters['desde']['value'])) {
    //         $query->where('created_at', '>=', $filters['desde']['value']);
    //     }
    //     if (isset($filters['hasta']['value']) && !empty($filters['hasta']['value'])) {
    //         $query->where('created_at', '<=', $filters['hasta']['value']);
    //     }

    //     //

    //     // dd($query->toSql());

    //     // Sorting logic
    //     if (in_array($sortField, ['id', 'alias', 'created_at', 'tipo', 'area.nombre', 'departamento.nombre', 'lider.name', 'proceso.nombre', 'tipo_minuta'])) {
    //         if (strpos($sortField, 'area.') === 0) {
    //             $query->join('areas', 'minutas.area_id', '=', 'areas.id')
    //                 ->select('minutas.*', 'areas.nombre as area_nombre') // Select distinct columns
    //                 ->orderBy('areas.nombre', $sortOrder);
    //         } else if (strpos($sortField, 'departamento.') === 0) {
    //             $query->join('departamentos', 'minutas.departamento_id', '=', 'departamentos.id')
    //                 ->select('minutas.*', 'departamentos.nombre as departamento_nombre') // Select distinct columns
    //                 ->orderBy('departamentos.nombre', $sortOrder);
    //         } else if (strpos($sortField, 'lider.') === 0) {
    //             $query->join('users', 'minutas.lider_id', '=', 'users.id')
    //                 ->select('minutas.*', 'users.name as lider_name') // Select distinct columns
    //                 ->orderBy('users.name', $sortOrder);
    //         } else if (strpos($sortField, 'proceso.') === 0) {
    //             $query->join('procesos', 'minutas.proceso_id', '=', 'procesos.id')
    //                 ->select('minutas.*', 'procesos.nombre as procesos_nombre') // Select distinct columns
    //                 ->orderBy('procesos.nombre', $sortOrder);
    //         } else if (strpos($sortField, 'tipo_minuta.') === 0) {
    //             $query->join('tipos_minuta', 'minutas.tipo', '=', 'tipos_minuta.id')
    //                 ->select('minutas.*', 'tipos_minuta.titulo as tipos_minuta_titulo') // Select distinct columns
    //                 ->orderBy('tipos_minuta.titulo', $sortOrder);
    //         } else {
    //             $query->orderBy('minutas.' . $sortField, $sortOrder);
    //         }
    //     } else {
    //         // Default sorting if the provided sortField is not allowed
    //         $query->orderBy('id', $sortOrder);
    //     }

    //     // $user = auth()->user();
    //     // if ($user->hasRole('lider_pilar')) {

    //     // } else {
    //     //     $query->where('privada', 0);
    //     // }

    //     $user = auth()->user();

    //     if ($user->hasRole(['superadmin', 'cc'])) {
    //         // Superadmin ve todo (niveles 0 al 3)
    //         $query->whereBetween('privada', [0, 3]);
    //     } elseif ($user->hasRole('lider_pilar')) {
    //         // Líder de pilar ve niveles 1 al 3
    //         $query->whereBetween('privada', [1, 3]);
    //     } elseif ($user->hasRole('admin')) {
    //         // Admin ve niveles 2 al 3 (puedes ajustar esto según lo que necesites)
    //         $query->whereBetween('privada', [2, 3]);
    //     } elseif ($user->hasRole('user')) {
    //         // User solo ve nivel 3
    //         $query->where('privada', 3);
    //     } else {
    //         // Si no tiene roles o no se define, puedes decidir qué mostrar (por ejemplo, ningún nivel)
    //         $query->where('privada', -1); // Opcional, ajusta según tu lógica
    //     }

    //     // if (isset($filters['tier']['value'])) {
    //     //     if ($filters['tier']['value'] == 0 && $filters['tier']['value'] != null) {
    //     //         $query->where('privada', 0);
    //     //     } elseif (isset($filters['tier']['value']) && !empty($filters['tier']['value'])) {
    //     //         $query->where('privada', $filters['tier']['value']);
    //     //     }
    //     // }

    //     if (isset($filters['tier']['value'])) {
    //         $query->where('privada', $filters['tier']['value']);
    //     }

    //     // Filtrar las minutas ocultas
    //     if (!$user->hasRole('admin') && !$user->hasRole('lider_pilar')) {
    //         $query->where('oculto', 0);
    //     }

    //     $query->withCount(['tarea as tareas_total' => function ($query) {
    //         $query->where('validacion', null);
    //     }]);

    //     $query->withCount(['tarea as tareas_completadas' => function ($query) {
    //         $query->whereHas('estatus', function ($query) {
    //             $query->where('titulo', 'Terminado')->where('validacion', null);
    //         });
    //     }]);

    //     $result = $query->where('minutas.area_id', $area_id)->with('area', 'departamento', 'lider', 'proceso', 'tipoMinuta')->paginate($pageSize, ['*'], 'page', $page);
    //     return response()->json($result);
    // }

    function byArea(Request $request, $area_id)
    {
        $query = minutas::query(); // Replace 'Model' with the actual model name
        $pageSize = $request->get('rows', 10);
        $page = $request->get('page', 1);
        $filters = $request->get('filter', '');
        $sortField = $request->get('sortField', 'id');
        $sortOrder = $request->get('sortOrder', 'desc');
        $userId = $request->get('user_id');

        // Apply global filter if it exists
        if (isset($filters['global']['value']) && !empty($filters['global']['value'])) {
            $globalFilter = $filters['global']['value'];
            $query->where(function ($q) use ($globalFilter) {
                $q->where('id', 'like', '%' . $globalFilter . '%')
                    ->orWhere('alias', 'like', '%' . $globalFilter . '%')
                    ->orWhere('created_at', 'like', '%' . $globalFilter . '%')
                    ->orWhereHas('area', function ($q) use ($globalFilter) {
                        $q->where('areas.nombre', 'like', '%' . $globalFilter . '%')
                            ->orWhere('areas.descripcion', 'like', '%' . $globalFilter . '%');
                    })
                    ->orWhereHas('departamento', function ($q) use ($globalFilter) {
                        $q->where('departamentos.nombre', 'like', '%' . $globalFilter . '%')
                            ->orWhere('departamentos.descripcion', 'like', '%' . $globalFilter . '%');
                    })
                    ->orWhereHas('lider', function ($q) use ($globalFilter) {
                        $q->where('Users.name', 'like', '%' . $globalFilter . '%');
                    })
                    ->orWhereHas('proceso', function ($q) use ($globalFilter) {
                        $q->where('procesos.nombre', 'like', '%' . $globalFilter . '%');
                    })
                    ->orWhereHas('tipoMinuta', function ($q) use ($globalFilter) {
                        $q->where('tipos_minuta.titulo', 'like', '%' . $globalFilter . '%');
                    });
            });
        }

        // Apply specific filters
        $filterableFields = ['area_id', 'departamento_id', 'lider_id', 'tipo', 'proceso_id'];
        foreach ($filterableFields as $field) {

            if (isset($filters[$field]['value']) && !empty($filters[$field]['value'])) {
                $query->Where($field, '=', $filters[$field]['value']);
            }
        }

        // Apply date range filters
        if (isset($filters['desde']['value']) && !empty($filters['desde']['value'])) {
            $query->where('created_at', '>=', $filters['desde']['value']);
        }
        if (isset($filters['hasta']['value']) && !empty($filters['hasta']['value'])) {
            $query->where('created_at', '<=', $filters['hasta']['value']);
        }

        //

        // dd($query->toSql());

        // Sorting logic
        if (in_array($sortField, ['id', 'alias', 'created_at', 'tipo', 'area.nombre', 'departamento.nombre', 'lider.name', 'proceso.nombre', 'tipo_minuta'])) {
            if (strpos($sortField, 'area.') === 0) {
                $query->join('areas', 'minutas.area_id', '=', 'areas.id')
                    ->select('minutas.*', 'areas.nombre as area_nombre') // Select distinct columns
                    ->orderBy('areas.nombre', $sortOrder);
            } else if (strpos($sortField, 'departamento.') === 0) {
                $query->join('departamentos', 'minutas.departamento_id', '=', 'departamentos.id')
                    ->select('minutas.*', 'departamentos.nombre as departamento_nombre') // Select distinct columns
                    ->orderBy('departamentos.nombre', $sortOrder);
            } else if (strpos($sortField, 'lider.') === 0) {
                $query->join('users', 'minutas.lider_id', '=', 'users.id')
                    ->select('minutas.*', 'users.name as lider_name') // Select distinct columns
                    ->orderBy('users.name', $sortOrder);
            } else if (strpos($sortField, 'proceso.') === 0) {
                $query->join('procesos', 'minutas.proceso_id', '=', 'procesos.id')
                    ->select('minutas.*', 'procesos.nombre as procesos_nombre') // Select distinct columns
                    ->orderBy('procesos.nombre', $sortOrder);
            } else if (strpos($sortField, 'tipo_minuta.') === 0) {
                $query->join('tipos_minuta', 'minutas.tipo', '=', 'tipos_minuta.id')
                    ->select('minutas.*', 'tipos_minuta.titulo as tipos_minuta_titulo') // Select distinct columns
                    ->orderBy('tipos_minuta.titulo', $sortOrder);
            } else {
                $query->orderBy('minutas.' . $sortField, $sortOrder);
            }
        } else {
            // Default sorting if the provided sortField is not allowed
            $query->orderBy('id', $sortOrder);
        }

        $roles = DB::table('model_has_roles')
            ->join('roles', 'roles.id', '=', 'model_has_roles.role_id')
            ->where('model_has_roles.model_id', $userId)
            ->pluck('roles.name')
            ->toArray();

        // Aplicar lógica según los roles
        if (in_array('superadmin', $roles) || in_array('cc', $roles)) {
            $query->whereBetween('privada', [0, 3]);
        } elseif (in_array('lider_pilar', $roles)) {
            $query->whereBetween('privada', [1, 3]);
        } elseif (in_array('admin', $roles)) {
            $query->whereBetween('privada', [2, 3]);
        } elseif (in_array('user', $roles)) {
            $query->where('privada', 3);
        } else {
            $query->where('privada', -1); // O cualquier otra lógica
        }


        // if (isset($filters['tier']['value'])) {
        //     if ($filters['tier']['value'] == 0 && $filters['tier']['value'] != null) {
        //         $query->where('privada', 0);
        //     } elseif (isset($filters['tier']['value']) && !empty($filters['tier']['value'])) {
        //         $query->where('privada', $filters['tier']['value']);
        //     }
        // }

        if (isset($filters['tier']['value'])) {
            $query->where('privada', $filters['tier']['value']);
        }

        // Filtrar las minutas ocultas
        if (!in_array('admin', $roles) && !in_array('lider_pilar', $roles)) {
            $query->where('oculto', 0);
        }

        $query->withCount(['tarea as tareas_total' => function ($query) {
            $query->where('validacion', null);
        }]);

        $query->withCount(['tarea as tareas_completadas' => function ($query) {
            $query->whereHas('estatus', function ($query) {
                $query->where('titulo', 'Terminado')->where('validacion', null);
            });
        }]);

        $result = $query->where('minutas.area_id', $area_id)->with('area', 'departamento', 'lider', 'proceso', 'tipoMinuta')->paginate($pageSize, ['*'], 'page', $page);
        return response()->json($result);
    }

    function byId(minutas $minuta)
    {
        return response()->json($minuta);
    }

    function pdf(minutas $minuta)
    {
        $minuta->load('lider', 'area', 'departamento', 'proceso', 'tipoMinuta');
        $asistentes = Asistente::with('user')->where('minuta_id', $minuta->id)->get();
        $tareas = tareas::with('area', 'departamento', 'estatus', 'minuta', 'responsable', 'revisor', 'evidencia')->where('minuta_id', $minuta->id)->get();

        // return view('MinutaPDF', ['minuta' => $minuta, 'asistentes' => $asistentes, 'tareas' => $tareas]);

        $pdf = Pdf::loadView('MinutaPDF', ['minuta' => $minuta, 'asistentes' => $asistentes, 'tareas' => $tareas]);

        return $pdf->download('minuta.pdf');
    }

    function bookmark(minutas $minuta, Request $request)
    {
        $minuta->update($request->only('bookmark'));

        return response()->json(['success' => true]);
    }

    function misMinutas()
    {
        return Inertia::render('Minutas/MinutasBookmark');
    }
}
