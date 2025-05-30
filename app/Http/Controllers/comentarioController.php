<?php

namespace App\Http\Controllers;

use App\Models\Comentario;
use App\Models\ComentarioMencion;
use Illuminate\Http\Request;
use App\Models\Notificacion;


class comentarioController extends Controller
{
    //
    public function index($reporte_semanal_id)
    {
        $comentarios = Comentario::orderBy('created_at', 'desc')->where('reporte_semanal_id', $reporte_semanal_id)->where('user_id', auth()->user()->id)->get();
        $menciones = ComentarioMencion::with('comentario')->where('user_id', auth()->user()->id)->get();
        return  response()->json([
            'comentarios' => $comentarios,
            'menciones' => $menciones
        ]);
    }

    function edit(Comentario $comentario)
    {
        return response()->json($comentario);
    }

    public function store(Request $request)
    {
        $user = auth()->user();

        // Crear el comentario
        $comentario = Comentario::create([
            'reporte_semanal_id' => $request->reporte_semanal_id,
            'user_id' => $user->id,
            'texto' => $request->texto,
        ]);

        // Guardar las menciones
        if (!empty($request->menciones)) {
            foreach ($request->menciones as $usuarioId) {
                ComentarioMencion::create([
                    'comentario_id' => $comentario->id,
                    'user_id' => $usuarioId,
                ]);

                // Enviar notificaciones

                $notification = [
                    'user_id' => $usuarioId,
                    'titulo' => 'Reporte Semanal',
                    'link' => '/reportes/' . $request->reporte_semanal_id . '/show',
                    'readed' => 0,
                ];
                //tiene que ir con minus
                $notificacion = new notificacionController();
                $notificacion->store($notification);
            }
        }


        $notificaciones = Notificacion::where('user_id', '!=', $user->id)->where('reporte_semanal_id', $request->reporte_semanal_id)->get();
        foreach ($notificaciones as $notificacion) {
            $notificacion->readed = 0;
            $notificacion->save();
        }

        return response()->json(['success' => true]);
    }

    function update(Request $request, Comentario $comentario)
    {
        $comentario->update($request->all());
        return response()->json(['success' => true]);
    }

    function destroy(Comentario $comentario)
    {
        // Delete associated records in comentario_menciones
        ComentarioMencion::where('comentario_id', $comentario->id)->delete();


        $comentario->delete();
        return response()->json(['success' => true]);
    }
}
