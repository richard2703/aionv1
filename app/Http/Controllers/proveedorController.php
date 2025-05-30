<?php

namespace App\Http\Controllers;

use App\Models\Proveedor;
use Illuminate\Http\Request;
use Inertia\Inertia;
use Illuminate\Support\Facades\Storage;

class proveedorController extends Controller
{
    //
    function index()
    {
        return Inertia::render('Proveedor/ProveedorIndex');
    }

    function create()
    {
        return Inertia::render('Proveedor/ProveedorCreate');
    }

    function edit(Proveedor $proveedor)
    {
        return Inertia::render(
            'Proveedor/ProveedorEdit',
            ['proveedor' => $proveedor]
        );
    }

    function findAll($area_id, Request $request)
    {
        $proceso_id = $request->get('proceso_id');
        $query = Proveedor::with('area', 'proceso')->where('area_id', $area_id);

        if ($proceso_id) {
            $query->where('proceso_id', $proceso_id);
        }

        $proveedores = $query->get();

        // local
        // $proveedores->transform(function ($proveedor) {
        //     $proveedor->video = $proveedor->video ? Storage::disk('public')->url($proveedor->video) : null;
        //     return $proveedor;
        // });

        // server
        $proveedores->transform(function ($proveedor) {
            $video = ("public/storage/$proveedor->video");
            $proveedor->video = $proveedor->video ? asset($video) : null;
            return $proveedor;
        });

        $proveedoresPorProceso = $proveedores->groupBy(function ($proveedor) {
            return optional($proveedor->proceso)->nombre ?? 'Sin proceso';
        });

        return response()->json($proveedoresPorProceso);
    }

    function store(Request $request)
    {
        $data = [
            'area_id' => $request->area_id,
            'proceso_id' => $request->proceso_id,
            'nombre' => $request->nombre,
            'servicio' => $request->servicio,
            'pagina_web' => $request->pagina_web,
            'link_orden' => $request->link_orden,
            'telefono' => $request->telefono,
            'correo' => $request->correo,
            'info' => $request->info,
        ];

        if ($request->hasFile('video')) {
            $video = $request->file('video');
            if ($video->getSize() > 1024 * 1024 * 100) { // 100MB limit
                return response()->json(['error' => 'Video file exceeds the maximum allowed size of 100MB'], 422);
            }
            $path1 = $video->store('proveedores', 'public');
            $data['video'] = $path1;
        }

        $proveedor = new Proveedor();
        $proveedor->fill($data);
        $proveedor->save();
        return response()->json(['success' => true]);
    }

    function update(Request $request, Proveedor $proveedor)
    {
        $proveedor->update($request->only(
            'area_id',
            'proceso_id',
            'nombre',
            'servicio',
            'pagina_web',
            'link_orden',
            'telefono',
            'correo',
            'info',
        ));

        if ($request->hasFile('video')) {

            if ($proveedor->video) {
                Storage::disk('public')->delete($proveedor->video);
            }


            $video = $request->file('video');
            if ($video->getSize() > 1024 * 1024 * 100) { // 100MB limit
                return response()->json(['error' => 'Video file exceeds the maximum allowed size of 100MB'], 422);
            }
            $path1 = $video->store('proveedores', 'public');
            $proveedor->video = $path1;
            $proveedor->save();
        }

        return redirect()->route('proveedores.index');
    }

    function destroy(Proveedor $proveedor)
    {
        $proveedor->delete();
        return response()->json(['success' => true]);
    }
}
