<?php

namespace App\Http\Controllers;

use App\Actions\Fortify\CreateNewUser;
use App\Actions\Fortify\UpdateUserPassword;
use App\Models\Area;
use App\Models\Departamento;
use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Inertia\Inertia;
use Spatie\Permission\Models\Role;


class userController extends Controller
{
    //

    public function index()
    {
        return Inertia::render('Usuario/UsuarioIndex', [
            'usuarios' => User::with('area', 'departamento')->get(),
        ]);
    }

    function byArea($area_id)
    {
        return response()->json(['usuarios' => User::where('area_id', $area_id)->get()]);
    }

    function all()
    {
        $usuarios = User::orderBy('name', 'asc')->get();
        return response()->json($usuarios);
    }
    function findAll(Request $request)
    {
        $query = User::query();
        $pageSize = $request->get('rows', 10);
        $page = $request->get('page', 1);
        $filter = $request->get('filter', '');
        $sortField = $request->get('sortField', 'id');
        $sortOrder = $request->get('sortOrder', 'asc');

        if ($filter) {
            $query->where(function ($q) use ($filter) {
                $q->where('users.id', 'like', '%' . $filter . '%')
                    ->orWhere('users.name', 'like', '%' . $filter . '%')
                    ->orWhere('users.email', 'like', '%' . $filter . '%')
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

        if (in_array($sortField, ['id', 'name', 'email', 'area.nombre', 'departamento.nombre'])) {
            if (strpos($sortField, 'area.') === 0) {
                $query->join('areas', 'users.area_id', '=', 'areas.id')
                    ->select('users.*', 'areas.nombre as area_nombre') // Select distinct columns
                    ->orderBy('areas.' . substr($sortField, 5), $sortOrder);
            } else if (strpos($sortField, 'departamento.') === 0) {
                $query->join('departamentos', 'users.departamento_id', '=', 'departamentos.id')
                    ->select('users.*', 'departamentos.nombre as departamento_nombre') // Select distinct columns
                    ->orderBy('departamentos.' . substr($sortField, 12), $sortOrder);
            } else {
                $query->orderBy($sortField, $sortOrder);
            }
        }

        $users = $query->with('area', 'departamento')->paginate($pageSize, ['*'], 'page', $page);

        return response()->json($users);
    }


    function create()
    {
        // return Inertia::render('Usuario/UsuarioCreate');
        $roles = Role::all();
        return Inertia::render('Usuario/UsuarioCreate', [
            'roles' => $roles,
        ]);
    }

    function store(Request $request)
    {

        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => Hash::make($request->password),
            'area_id' => $request->area_id,
            'departamento_id' => $request->departamento_id,
        ]);

        // Asigna los roles al usuario
        $user->syncRoles($request->roles);


        return redirect()->route('user.index');
    }

    function edit(User $user)
    {
        // dd($user);
        // return Inertia::render('Usuario/UsuarioEdit', [
        //     'usuario' => $user,
        // ]);

        $areas = Area::all(); // Suponiendo que tienes un modelo Area
        $departamentos = Departamento::where('area_id', $user->area_id)->get(); // Suponiendo que tienes un modelo Departamento
        // $roles = Role::all();

        // $user = $user->role->pluck('id')->toArray();


        return Inertia::render('Usuario/UsuarioEdit', [
            'usuario' => $user,
            'areas' => $areas,
            'roles' => Role::all(), // Obtener todos los roles disponibles
            'roles_usuario' => $user->roles()->pluck('id'), // Obtener los nombres de los roles asignados al usuario
            'departamentos' => $departamentos,
        ]);
    }

    function update(Request $request, $id)
    {
        // dd($request);
        $user = User::find($id);
        $user->update($request->only('name', 'email', 'area_id', 'departamento_id'));
        $roles = Role::whereIn('id', $request->input('selectedRoles', []))->get();
        $user->syncRoles($roles);

        return redirect()->route('user.index');
    }
    function updatePassword(Request $request, $id)
    {
        if ($request->password === $request->password_confirmation) {
            $user = User::find($id);
            $user->password = Hash::make($request->password);
            $user->save();
            return redirect()->route('user.index');
        }
    }

    function destroy($id)
    {
        $user = User::find($id);
        $user->delete();
        return response()->json(['usuarios' => User::with('area', 'departamento')->get(),]);
    }
}
