<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\User;

class testController extends Controller
{
    // public function primero()
    // {
    //     // return response()->json(['message' => 'Hello World'], 200);
    //     return Inertia::render('test/HelloWorld', [
    //         'message' => 'Hello World'
    //     ]);
    // }

    public function primero()
    {
        // return response()->json(['message' => 'Hello World'], 200);
        return Inertia::render('test/base', [
            'message' => 'Hello World'
        ]);
    }
    public function cambiarMensaje()
    {
        return response()->json(['message' => 'Hola Mundo']);
    }
    public function registro(Request $request)
    {
        dd($request);
        $usuario = User::create($request->only('nombre', 'email', 'password'));

        return Inertia::render('test/HelloWorld', [
            'usuario' => $usuario,
        ]);
    }

    function form()
    {
        return Inertia::render('test/testForm');
    }
}
