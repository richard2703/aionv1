<?php

namespace App\Http\Controllers;

use App\Models\Notificacion;
use Illuminate\Http\Request;

class notificacionController extends Controller
{
    public function store($notification)
    {
        return Notificacion::create($notification);
    }

    public function getByUser(Request $request)
    {
        $user_id = $request->user()->id;

        return Notificacion::where('user_id', $user_id)->get();
    }

    public function markAsRead(Request $request)
    {
        $user_id = $request->user()->id;

        return Notificacion::where('user_id', $user_id)->update(['readed' => 1]);
    }

    public function deleteReaded(Request $request)
    {
        $user_id = $request->user()->id;

        return Notificacion::where('user_id', $user_id)->where('readed', '=', 1)->delete();
    }
}
