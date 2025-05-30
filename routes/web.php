<?php

use Illuminate\Foundation\Application;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;

// Route::get('/', function () {
//     return Inertia::render('Welcome', [
//         'canLogin' => Route::has('login'),
//         'canRegister' => Route::has('register'),
//         'laravelVersion' => Application::VERSION,
//         'phpVersion' => PHP_VERSION,
//     ]);
// });

Route::middleware(['auth:sanctum', config('jetstream.auth_session'), 'verified',])->group(function () {
    Route::get('/', function () {
        return Inertia::render('Dashboard');
    })->name('dashboard');

    Route::get('/test', [App\Http\Controllers\testController::class, 'primero'])->name('test.primero');
    Route::get('/test/form', [App\Http\Controllers\testController::class, 'form'])->name('test.form');

    Route::get('/cambiar-mensaje', [App\Http\Controllers\testController::class, 'cambiarMensaje'])->name('test.cambiarMensaje');
    Route::post('/cambiar-mensaje', [App\Http\Controllers\testController::class, 'registro'])->name('test.registro');

    // Area
    Route::get('/areas', [App\Http\Controllers\areaController::class, 'index'])->name('area.index');
    Route::get('/area/create', [App\Http\Controllers\areaController::class, 'create'])->name('area.create');
    Route::post('/area/store', [App\Http\Controllers\areaController::class, 'store'])->name('area.store');
    // Route::get('/area/{id}', [App\Http\Controllers\areaController::class, 'show'])->name('area.show');
    Route::get('/area/{id}/edit', [App\Http\Controllers\areaController::class, 'edit'])->name('area.edit');
    Route::patch('/area/{id}/update', [App\Http\Controllers\areaController::class, 'update'])->name('area.update');
    Route::delete('/area/{id}/destroy', [App\Http\Controllers\areaController::class, 'destroy'])->name('area.destroy');

    // Departamento
    Route::get('/departamentos', [App\Http\Controllers\departamentoController::class, 'index'])->name('departamento.index');
    Route::get('/departamento/create', [App\Http\Controllers\departamentoController::class, 'create'])->name('departamento.create');
    Route::post('/departamento/store', [App\Http\Controllers\departamentoController::class, 'store'])->name('departamento.store');
    // Route::get('/departamento/{id}', [App\Http\Controllers\departamentoController::class, 'show'])->name('departamento.show');
    Route::get('/departamento/{id}/edit', [App\Http\Controllers\departamentoController::class, 'edit'])->name('departamento.edit');
    Route::patch('/departamento/{id}/update', [App\Http\Controllers\departamentoController::class, 'update'])->name('departamento.update');
    Route::delete('/departamento/{id}/destroy', [App\Http\Controllers\departamentoController::class, 'destroy'])->name('departamento.destroy');

    // User
    Route::get('/users', [App\Http\Controllers\userController::class, 'index'])->name('user.index');
    Route::get('/user/create', [App\Http\Controllers\userController::class, 'create'])->name('user.create');
    Route::post('/user/store', [App\Http\Controllers\userController::class, 'store'])->name('user.store');
    // Route::get('/user/{id}', [App\Http\Controllers\userController::class, 'show'])->name('user.show');
    Route::get('/user/{user}/edit', [App\Http\Controllers\userController::class, 'edit'])->name('user.edit');
    Route::patch('/user/{id}/update', [App\Http\Controllers\userController::class, 'update'])->name('user.update');
    Route::patch('/user/{id}/updatePassword', [App\Http\Controllers\userController::class, 'updatePassword'])->name('user.updatePassword');
    Route::delete('/user/{id}/destroy', [App\Http\Controllers\userController::class, 'destroy'])->name('user.destroy');

    //Chanllenges
    Route::get('/challenges', [App\Http\Controllers\challengesController::class, 'index'])->name('challenge.index');
    Route::get('/challenge/create', [App\Http\Controllers\challengesController::class, 'create'])->name('challenge.create');
    Route::post('/challenge/store', [App\Http\Controllers\challengesController::class, 'store'])->name('challenge.store');
    Route::get('/challenge/{id}/edit', [App\Http\Controllers\challengesController::class, 'edit'])->name('challenge.edit');
    Route::patch('/challenge/{id}/update', [App\Http\Controllers\challengesController::class, 'update'])->name('challenge.update');
    Route::delete('/challenge/{id}/destroy', [App\Http\Controllers\challengesController::class, 'destroy'])->name('challenge.destroy');

    //Opciones
    Route::get('/opciones', [App\Http\Controllers\opcionController::class, 'index'])->name('opcion.index');
    Route::get('/opcion/create', [App\Http\Controllers\opcionController::class, 'create'])->name('opcion.create');
    Route::post('/opcion/store', [App\Http\Controllers\opcionController::class, 'store'])->name('opcion.store');
    Route::get('/opcion/{id}/edit', [App\Http\Controllers\opcionController::class, 'edit'])->name('opcion.edit');
    Route::patch('/opcion/{id}/update', [App\Http\Controllers\opcionController::class, 'update'])->name('opcion.update');
    Route::delete('/opcion/{id}/destroy', [App\Http\Controllers\opcionController::class, 'destroy'])->name('opcion.destroy');

    Route::get('/config', [App\Http\Controllers\configController::class, 'index'])->name('config.index');

    // Dashboard
    Route::post('/dashboard/store', [App\Http\Controllers\dashboardController::class, 'store'])->name('dashboard.store');
    Route::post('/dashboard/{id}/update', [App\Http\Controllers\dashboardController::class, 'update'])->name('dashboard.update');
    Route::post('/dashboard/{id}/portada', [App\Http\Controllers\dashboardController::class, 'portada'])->name('dashboard.portada');

    //Objetivo
    Route::get('/objetivos', [App\Http\Controllers\objetivosController::class, 'index'])->name('objetivo.index');
    Route::get('/objetivo/create', [App\Http\Controllers\objetivosController::class, 'create'])->name('objetivo.create');
    Route::post('/objetivo/store', [App\Http\Controllers\objetivosController::class, 'store'])->name('objetivo.store');
    Route::get('/objetivo/{objetivo}/edit', [App\Http\Controllers\objetivosController::class, 'edit'])->name('objetivo.edit');
    Route::patch('/objetivo/{objetivo}/update', [App\Http\Controllers\objetivosController::class, 'update'])->name('objetivo.update');
    Route::delete('/objetivo/{objetivo}/destroy', [App\Http\Controllers\objetivosController::class, 'destroy'])->name('objetivo.destroy');

    //minutero
    Route::get('/minutas', [App\Http\Controllers\minutasController::class, 'index'])->name('minutas.index');
    Route::get('/minutas/create', [App\Http\Controllers\minutasController::class, 'create'])->name('minutas.create');
    Route::post('/minutas/store', [App\Http\Controllers\minutasController::class, 'store'])->name('minutas.store');
    Route::get('/minutas/misminutas', [App\Http\Controllers\minutasController::class, 'misMinutas'])->name('minutas.misminutas');
    Route::get('/minutas/{minuta}', [App\Http\Controllers\minutasController::class, 'show'])->name('minutas.show');
    Route::get('/minutas/{minuta}/edit', [App\Http\Controllers\minutasController::class, 'edit'])->name('minutas.edit');
    Route::get('/minutas/{minuta}/id', [App\Http\Controllers\minutasController::class, 'byId'])->name('minutas.byId');
    Route::patch('/minutas/{minuta}/update', [App\Http\Controllers\minutasController::class, 'update'])->name('minutas.update');
    Route::delete('/minutas/{minuta}/destroy', [App\Http\Controllers\minutasController::class, 'destroy'])->name('minutas.destroy');
    Route::get('/minutas/{minuta}/pdf', [App\Http\Controllers\minutasController::class, 'pdf'])->name('minutas.pdf');

    // Proceso
    Route::get('/procesos', [App\Http\Controllers\procesoController::class, 'index'])->name('proceso.index');
    Route::get('/proceso/create', [App\Http\Controllers\procesoController::class, 'create'])->name('proceso.create');
    Route::post('/proceso/store', [App\Http\Controllers\procesoController::class, 'store'])->name('proceso.store');
    Route::get('/proceso/{proceso}/edit', [App\Http\Controllers\procesoController::class, 'edit'])->name('proceso.edit');
    Route::patch('/proceso/{proceso}/update', [App\Http\Controllers\procesoController::class, 'update'])->name('proceso.update');
    Route::delete('/proceso/{proceso}/destroy', [App\Http\Controllers\procesoController::class, 'destroy'])->name('proceso.destroy');

    // Procedimiento
    Route::get('/procedimientos', [App\Http\Controllers\procedimientoController::class, 'index'])->name('procedimiento.index');
    Route::get('/procedimiento/create', [App\Http\Controllers\procedimientoController::class, 'create'])->name('procedimiento.create');
    Route::post('/procedimiento/store', [App\Http\Controllers\procedimientoController::class, 'store'])->name('procedimiento.store');
    Route::get('/procedimiento/{procedimiento}/edit', [App\Http\Controllers\procedimientoController::class, 'edit'])->name('procedimiento.edit');
    Route::patch('/procedimiento/{procedimiento}/update', [App\Http\Controllers\procedimientoController::class, 'update'])->name('procedimiento.update');
    Route::delete('/procedimiento/{procedimiento}/destroy', [App\Http\Controllers\procedimientoController::class, 'destroy'])->name('procedimiento.destroy');

    // Estandar
    Route::get('/estandares', [App\Http\Controllers\EstandarController::class, 'index'])->name('estandar.index');
    Route::get('/estandar/create', [App\Http\Controllers\EstandarController::class, 'create'])->name('estandar.create');
    Route::post('/estandar/store', [App\Http\Controllers\EstandarController::class, 'store'])->name('estandar.store');
    Route::get('/estandar/{estandar}/edit', [App\Http\Controllers\EstandarController::class, 'edit'])->name('estandar.edit');
    Route::patch('/estandar/{estandar}/update', [App\Http\Controllers\EstandarController::class, 'update'])->name('estandar.update');
    Route::delete('/estandar/{estandar}/destroy', [App\Http\Controllers\EstandarController::class, 'destroy'])->name('estandar.destroy');

    // KPI
    Route::get('/kpis', [App\Http\Controllers\kpiController::class, 'index'])->name('kpi.index');
    Route::get('/kpi/create', [App\Http\Controllers\kpiController::class, 'create'])->name('kpi.create');
    Route::post('/kpi/store', [App\Http\Controllers\kpiController::class, 'store'])->name('kpi.store');
    Route::get('/kpi/{kpi}/edit', [App\Http\Controllers\kpiController::class, 'edit'])->name('kpi.edit');
    Route::post('/kpi/{kpi}/update', [App\Http\Controllers\kpiController::class, 'update'])->name('kpi.update');
    Route::delete('/kpi/{kpi}/destroy', [App\Http\Controllers\kpiController::class, 'destroy'])->name('kpi.destroy');

    // registros_kpis
    Route::post('/registros_kpi/store', [App\Http\Controllers\registros_kpisController::class, 'store'])->name('registros_kpi.store');
    Route::patch('/registros_kpi/{registros_kpi}/update', [App\Http\Controllers\registros_kpisController::class, 'update'])->name('registros_kpi.update');
    Route::get('/registros_kpi/{kpi}/promedio', [App\Http\Controllers\registros_kpisController::class, 'promedio'])->name('registros_kpi.promedio');


    Route::get('admin', [App\Http\Controllers\AdminController::class, 'index'])->name('admin.index');

    Route::get('roles', [App\Http\Controllers\rolesController::class, 'index'])->name('roles.index');
    Route::get('roles/create', [App\Http\Controllers\rolesController::class, 'create'])->name('roles.create');
    Route::post('roles/store', [App\Http\Controllers\rolesController::class, 'store'])->name('roles.store');
    Route::get('roles/{rol}/edit', [App\Http\Controllers\rolesController::class, 'edit'])->name('roles.edit');
    Route::patch('roles/{role}/update', [App\Http\Controllers\rolesController::class, 'update'])->name('roles.update');

    Route::get('permisos', [App\Http\Controllers\permisosController::class, 'index'])->name('permisos.index');
    Route::get('permisos/create', [App\Http\Controllers\permisosController::class, 'create'])->name('permisos.create');
    Route::get('permisos/{permiso}/edit', [App\Http\Controllers\permisosController::class, 'edit'])->name('permisos.edit');
    Route::post('permisos/store', [App\Http\Controllers\permisosController::class, 'store'])->name('permisos.store');
    Route::patch('permisos/{permiso}/update', [App\Http\Controllers\permisosController::class, 'update'])->name('permisos.update');
    Route::delete('permisos/{permiso}/destroy', [App\Http\Controllers\permisosController::class, 'destroy'])->name('permisos.destroy');

    //Tareas
    Route::get('tareas', [App\Http\Controllers\tareasController::class, 'index'])->name('tareas.index');
    // Route::get('tareas/create', [App\Http\Controllers\tareasController::class, 'create'])->name('tareas.create');
    Route::post('tareas/store', [App\Http\Controllers\tareasController::class, 'store'])->name('tareas.store');
    Route::get('tareas/{tarea}/show', [App\Http\Controllers\tareasController::class, 'show'])->name('tareas.show');
    Route::get('tareas/{tarea}/editar', [App\Http\Controllers\tareasController::class, 'edit'])->name('tareas.edit');
    Route::get('tareas/{tarea}/detalle', [App\Http\Controllers\tareasController::class, 'detail'])->name('tareas.detail');
    Route::get('tareas/mis-tareas', [App\Http\Controllers\tareasController::class, 'misTareas'])->name('tareas.misTareas');
    Route::patch('tareas/{tarea}/update', [App\Http\Controllers\tareasController::class, 'update'])->name('tareas.update');
    Route::delete('tarea/{tarea}/destroy', [App\Http\Controllers\tareasController::class, 'destroy'])->name('tarea.destroy');

    //SysGestion
    Route::get('sysgestion', [App\Http\Controllers\sysGestionController::class, 'index'])->name('sysgestion.index');
    Route::get('sysgestion/dashboard', [App\Http\Controllers\sysGestionController::class, 'dashboard'])->name('sysgestion.dashboard');

    //EncargadosReportes
    Route::get('Encargados', [App\Http\Controllers\encargado_flujoController::class, 'index'])->name('encargadoFlujo.index');
    Route::get('Encargados/create', [App\Http\Controllers\encargado_flujoController::class, 'create'])->name('encargadoFlujo.create');
    Route::post('Encargados/store', [App\Http\Controllers\encargado_flujoController::class, 'store'])->name('encargadoFlujo.store');
    Route::delete('Encargados/{encargado_flujo}/destroy', [App\Http\Controllers\encargado_flujoController::class, 'destroy'])->name('encargadoFlujo.destroy');

    //Reportes
    Route::get('reportes', [App\Http\Controllers\reportesController::class, 'index'])->name('reporte.index');
    Route::get('reportes/nuevo', [App\Http\Controllers\reportesController::class, 'create'])->name('reporte.create');
    Route::post('reportes/store', [App\Http\Controllers\reportesController::class, 'store'])->name('reporte.store');
    Route::get('reportes/{reporte}/show', [App\Http\Controllers\reportesController::class, 'show'])->name('reporte.show');
    Route::get('MisReportes', [App\Http\Controllers\reportesController::class, 'misReportes'])->name('misreporte.index');
    Route::get('MisReportes/{reporte}/edit', [App\Http\Controllers\reportesController::class, 'edit'])->name('misreporte.edit');
    Route::patch('MisReportes/{reporte}/update', [App\Http\Controllers\reportesController::class, 'update'])->name('misreporte.update');
    Route::get('reportes/{reporte}/pdf', [App\Http\Controllers\reportesController::class, 'pdf'])->name('reporte.pdf');
    Route::get('api/getFlujo', [App\Http\Controllers\reportesController::class, 'findAll'])->name('getFlujo.findAll');


    //EncargadosReportes
    Route::get('tipoDesperdicio', [App\Http\Controllers\tiposDesperdiciosController::class, 'index'])->name('tiposDesperdicios.index');
    Route::get('tipoDesperdicio/create', [App\Http\Controllers\tiposDesperdiciosController::class, 'create'])->name('tiposDesperdicios.create');
    Route::post('tipoDesperdicio/store', [App\Http\Controllers\tiposDesperdiciosController::class, 'store'])->name('tiposDesperdicios.store');
    Route::get('tipoDesperdicio/{tipoDesperdicio}/edit', [App\Http\Controllers\tiposDesperdiciosController::class, 'edit'])->name('tiposDesperdicios.edit');
    Route::patch('tipoDesperdicio/{tipoDesperdicio}/update', [App\Http\Controllers\tiposDesperdiciosController::class, 'update'])->name('tiposDesperdicios.update');
    Route::delete('tipoDesperdicio/{tipoDesperdicio}/destroy', [App\Http\Controllers\tiposDesperdiciosController::class, 'destroy'])->name('tiposDesperdicios.destroy');
    //Desperdicio
    Route::get('Desperdicio', [App\Http\Controllers\desperdiciosController::class, 'index'])->name('desperdicio.index');
    Route::get('Desperdicio/nuevo', [App\Http\Controllers\desperdiciosController::class, 'create'])->name('desperdicio.create');
    Route::post('Desperdicio/store', [App\Http\Controllers\desperdiciosController::class, 'store'])->name('desperdicio.store');
    Route::get('Desperdicio/{desperdicio}/edit', [App\Http\Controllers\desperdiciosController::class, 'edit'])->name('desperdicio.edit');
    Route::patch('Desperdicio/{desperdicio}/update', [App\Http\Controllers\desperdiciosController::class, 'update'])->name('desperdicio.update');
    Route::delete('Desperdicio/{desperdicio}/destroy', [App\Http\Controllers\desperdiciosController::class, 'destroy'])->name('desperdicio.destroy');

    //test de mail
    Route::get('send/mail', [App\Http\Controllers\SendMailController::class, 'sendMailWithAttachment'])->name('mailer.sendMailWithAttachment');

    //Seccion
    Route::get('secciones', [App\Http\Controllers\seccionController::class, 'index'])->name('seccion.index');
    Route::get('seccion/create', [App\Http\Controllers\seccionController::class, 'create'])->name('seccion.create');
    Route::get('seccion/{seccion}/show', [App\Http\Controllers\seccionController::class, 'show'])->name('seccion.show');
    Route::get('seccion/{seccion}/edit', [App\Http\Controllers\seccionController::class, 'edit'])->name('seccion.edit');
    Route::post('seccion/store', [App\Http\Controllers\seccionController::class, 'store'])->name('seccion.store');
    Route::patch('seccion/{seccion}/update', [App\Http\Controllers\seccionController::class, 'update'])->name('seccion.update');
    Route::delete('seccion/{seccion}/destroy', [App\Http\Controllers\seccionController::class, 'destroy'])->name('seccion.destroy');

    //Assessment
    Route::get('assessment', [App\Http\Controllers\evaluacionController::class, 'index'])->name('evaluacion.index');
    Route::get('assessment/create', [App\Http\Controllers\evaluacionController::class, 'create'])->name('evaluacion.create');
    Route::get('assessment/{evaluacion}/select', [App\Http\Controllers\evaluacionController::class, 'select'])->name('evaluacion.select');
    Route::get('assessment/{assessmentAsignado}/form', [App\Http\Controllers\evaluacionController::class, 'form'])->name('evaluacion.form');
    Route::get('assessment/{evaluacion}/show', [App\Http\Controllers\evaluacionController::class, 'show'])->name('evaluacion.show');
    Route::get('assessment/{evaluacion}/edit', [App\Http\Controllers\evaluacionController::class, 'edit'])->name('evaluacion.edit');
    Route::get('assessment/{evaluacion}/details', [App\Http\Controllers\evaluacionController::class, 'details'])->name('evaluacion.details');
    Route::post('assessment/store', [App\Http\Controllers\evaluacionController::class, 'store'])->name('evaluacion.store');
    Route::patch('assessment/{evaluacion}/update', [App\Http\Controllers\evaluacionController::class, 'update'])->name('evaluacion.update');
    Route::delete('assessment/{evaluacion}/destroy', [App\Http\Controllers\evaluacionController::class, 'destroy'])->name('evaluacion.destroy');

    //Metas (30 60 90)
    Route::get('metas', [App\Http\Controllers\metasController::class, 'index'])->name('metas.index');
    Route::get('metas/nuevo', [App\Http\Controllers\metasController::class, 'create'])->name('metas.create');
    Route::post('metas/store', [App\Http\Controllers\metasController::class, 'store'])->name('metas.store');
    // Route::get('metas/{reporte}/show', [App\Http\Controllers\reportesController::class, 'show'])->name('metas.show');
    Route::get('metas/{metaTrimestre}/trimestre', [App\Http\Controllers\metasController::class, 'metas'])->name('metas.trimestre');
    Route::get('metas/{metaFlujo}/edit', [App\Http\Controllers\metasController::class, 'edit'])->name('metas.edit');
    Route::patch('metas/{metaFlujo}/update', [App\Http\Controllers\metasController::class, 'update'])->name('metas.update');
    Route::get('Mismetas', [App\Http\Controllers\metasController::class, 'misMetas'])->name('Mismetas.index');
    // Route::get('reportes/{reporte}/pdf', [App\Http\Controllers\reportesController::class, 'pdf'])->name('reporte.pdf');


    //ScoreCard
    Route::get('scoreCard', [App\Http\Controllers\scoreCardController::class, 'index'])->name('scoreCard.index');

    // Excel
    Route::get('export/desperdicio', [App\Http\Controllers\ExcelExportController::class, 'exportDesperdicios'])->name('excel.desperdicios');

    //eventos
    Route::get('eventos', [App\Http\Controllers\eventoController::class, 'index'])->name('eventos.index');
    Route::get('eventos/get', [App\Http\Controllers\eventoController::class, 'findAll'])->name('eventos.findAll');
    Route::get('evento/create', [App\Http\Controllers\eventoController::class, 'create'])->name('eventos.create');
    Route::get('evento/{date}/date', [App\Http\Controllers\eventoController::class, 'byDate'])->name('eventos.byDate');
    Route::get('evento/{evento}/show', [App\Http\Controllers\eventoController::class, 'show'])->name('eventos.show');
    Route::get('evento/{evento}/edit', [App\Http\Controllers\eventoController::class, 'edit'])->name('eventos.edit');
    Route::post('evento/store', [App\Http\Controllers\eventoController::class, 'store'])->name('eventos.store');
    Route::patch('evento/{evento}/update', [App\Http\Controllers\eventoController::class, 'update'])->name('eventos.update');
    Route::delete('evento/{evento}/destroy', [App\Http\Controllers\eventoController::class, 'destroy'])->name('eventos.destroy');

    // Proveedores
    Route::get('proveedores', [App\Http\Controllers\proveedorController::class, 'index'])->name('proveedores.index');
    Route::get('proveedores/nuevo', [App\Http\Controllers\proveedorController::class, 'create'])->name('proveedores.create');
    Route::post('proveedores/store', [App\Http\Controllers\proveedorController::class, 'store'])->name('proveedores.store');
    Route::get('proveedores/{proveedor}/edit', [App\Http\Controllers\proveedorController::class, 'edit'])->name('proveedores.edit');
    Route::post('proveedor/{proveedor}/update', [App\Http\Controllers\proveedorController::class, 'update'])->name('proveedor.update');
    Route::delete('proveedores/{proveedor}/destroy', [App\Http\Controllers\proveedorController::class, 'destroy'])->name('proveedores.destroy');

    //Helpers
    Route::get('helper/tareasVencidas', [App\Http\Controllers\helper::class, 'tareasVencidas'])->name('helper.tareasVencidas');

    //Notebook
    Route::get('notebook', [App\Http\Controllers\notebookController::class, 'index'])->name('notebook.index');

    //Tutorial
    Route::get('tutorial', [App\Http\Controllers\tutorialController::class, 'index'])->name('tutorial.index');

    // PDF
    Route::get('/pdfs/{filename}', [App\Http\Controllers\PdfController::class, 'getPdf']);

    // Terminos y condiciones
    Route::get('terminos', [App\Http\Controllers\terminosController::class, 'index'])->name('terminos.index');

    // Empresa
    Route::get('empresas', [App\Http\Controllers\empresaController::class, 'index'])->name('empresas.index');
    Route::get('empresas/create', [App\Http\Controllers\empresaController::class, 'create'])->name('empresas.create');
    Route::post('empresas/store', [App\Http\Controllers\empresaController::class, 'store'])->name('empresas.store');
    Route::get('empresas/{empresa}/edit', [App\Http\Controllers\empresaController::class, 'edit'])->name('empresas.edit');
    Route::post('empresas/{empresa}/update', [App\Http\Controllers\empresaController::class, 'update'])->name('empresas.update');
    Route::delete('empresas/{empresa}/destroy', [App\Http\Controllers\empresaController::class, 'destroy'])->name('empresas.destroy');
});
