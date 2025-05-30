<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\tareas;
use Carbon\Carbon;

class helper extends Controller
{

    public function tareasVencidas()
    {
        $hoy = Carbon::today(); // Obtiene la fecha actual sin hora

        // Buscar tareas cuya fecha ha vencido y el estatus no es 4
        $tareasActualizadas = tareas::where('fecha', '<', $hoy)
            ->where('estatus_id', '!=', 4)
            ->update(['estatus_id' => 1]);
    }
}
