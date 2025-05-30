<?php

namespace App\Http\Controllers;

// use App\Models\roles;
use Illuminate\Http\Request;
use Spatie\Permission\Models\Permission;
use Spatie\Permission\Models\Role;
use Inertia\Inertia;

class rolesController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return Inertia::render('roles/RolesIndex');
    }

    function findAll(Request $request)
    {
        $query = Role::query(); // Replace 'Model' with the actual model name
        $pageSize = $request->get('rows', 10);
        $page = $request->get('page', 1);
        $filter = $request->get('filter', '');
        $sortField = $request->get('sortField', 'id');
        $sortOrder = $request->get('sortOrder', 'asc');

        if ($filter) {
            $query->where(function ($q) use ($filter) {
                $q->where('id', 'like', '%' . $filter . '%')
                    ->orWhere('name', 'like', '%' . $filter . '%');
                // ->orWhere('tareas', 'like', '%' . $filter . '%');
                // ->orWhereHas('area', function ($q) use ($filter) {
                //     $q->where('areas.nombre', 'like', '%' . $filter . '%')
                //         ->orWhere('areas.descripcion', 'like', '%' . $filter . '%');
                // })
                // ->orWhereHas('departamento', function ($q) use ($filter) {
                //     $q->where('departamentos.nombre', 'like', '%' . $filter . '%')
                //         ->orWhere('departamentos.descripcion', 'like', '%' . $filter . '%');
                // })
                // ->orWhereHas('usuario', function ($q) use ($filter) {
                //     $q->where('Users.name', 'like', '%' . $filter . '%');
                // });
            });
        }

        // if (in_array($sortField, ['id', 'tareas', 'departamento.nombre', 'departamento.nombre', 'usuario.name',])) {
        //     if (strpos($sortField, 'area.') === 0) {
        //         $query->join('areas', 'challenges.area_id', '=', 'areas.id')
        //             ->orderBy('areas.' . substr($sortField, 5), $sortOrder);
        //     } else if (strpos($sortField, 'departamento.') === 0) {
        //         $query->join('departamentos', 'challenges.departamento_id', '=', 'departamentos.id')
        //             ->orderBy('departamentos.' . substr($sortField, 12), $sortOrder);
        //     } else if (strpos($sortField, 'usuario.') === 0) {
        //         $query->join('usuarios', 'minutas.responsable_id', '=', 'responsable_id.id')
        //             ->orderBy('Users.' . substr($sortField, 5), $sortOrder);
        //     } else {
        //         $query->orderBy($sortField, $sortOrder);
        //     }
        // }
        // if (in_array($sortField, ['id', 'titulo', 'objetivo'])) {
        //     $query->orderBy($sortField, $sortOrder);
        // }

        // $result = $query->with('challenge')->paginate($pageSize, ['*'], 'page', $page);
        // $result = $query->with('area', 'departamento', 'usuario')->paginate($pageSize, ['*'], 'page', $page);
        $result = $query->paginate($pageSize, ['*'], 'page', $page);

        return response()->json($result);
    }

    public function create()
    {
        return Inertia::render('roles/RolCreate');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        // $role = Role::create($request->only('name'));
        $role = Role::create(['name' => $request->name, 'guard_name' => 'web']);

        // Obtén los permisos seleccionados
        $permissions = Permission::whereIn('id', $request->input('selectedPermisos', []))->get();

        // Sincroniza los permisos con el rol
        $role->syncPermissions($permissions);

        return redirect()->route('roles.index');
    }

    /**
     * Display the specified resource.
     */
    public function show(roles $roles)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Role $rol)
    {
        $role = $rol;
        $permissions = Permission::all();
        $rolePermissions = $role->permissions->pluck('id')->toArray();

        return Inertia::render('roles/RolEdit', [
            'role' => $role,
            'permissions' => $permissions,
            'rolePermissions' => $rolePermissions,
        ]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, role $role)
    {
        $role->update($request->only('name', 'descripcion'));

        // Obtén los permisos seleccionados
        $permissions = Permission::whereIn('id', $request->input('selectedPermisos', []))->get();

        // Sincroniza los permisos con el rol
        $role->syncPermissions($permissions);
        return redirect()->route('roles.index');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(roles $roles)
    {
        //
    }
}
