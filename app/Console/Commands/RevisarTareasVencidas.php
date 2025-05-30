<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\tareas;
use Carbon\Carbon;

class RevisarTareasVencidas extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'app:revisar-tareas-vencidas';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Revisa las tareas diariamente y actualiza el estatus si han vencido';

    /**
     * Execute the console command.
     */
    public function handle()
    {
        $hoy = Carbon::today(); // Obtiene la fecha actual sin hora

        // Buscar tareas cuya fecha ha vencido y el estatus no es 4
        $tareasActualizadas = tareas::where('fecha', '<', $hoy)
            ->where('estatus_id', '!=', 4)
            ->update(['estatus_id' => 1]);

        $this->info("Se actualizaron $tareasActualizadas tareas vencidas.");
    }
}
