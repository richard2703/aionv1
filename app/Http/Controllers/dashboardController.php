<?php

namespace App\Http\Controllers;

use App\Models\objetivos;
use App\Models\Personalizar;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class dashboardController extends Controller
{
    //
    public function getConfig()
    {
        $personalizar = Personalizar::first();
        $objetivos = objetivos::all();

        $personalizar->logo_path = Storage::disk('public')->url($personalizar->logo);
        $personalizar->banner_path = Storage::disk('public')->url($personalizar->banner);
        $personalizar->portada_path = Storage::disk('public')->url($personalizar->portada);

        // $logo = ("public/storage/$personalizar->logo");
        // $banner = ("public/storage/$personalizar->banner");
        // $portada = ("public/storage/$personalizar->portada");

        // $personalizar->logo_path = asset($logo);
        // $personalizar->banner_path = asset($banner);
        // $personalizar->portada_path = asset($portada);

        // dd($logo);
        // return response()->json($personalizar);
        return response()->json([$personalizar, $objetivos]);
    }


    public function store(Request $request)
    {
        $data = [
            'proposito' => $request->proposito,
            'slogan' => $request->slogan,
            'actuacion' => $request->actuacion,
            'nombre_negocio' => $request->nombre_negocio,

        ];

        // Handle file uploads
        if ($request->hasFile('logo')) {
            $logo = $request->file('logo');
            $path1 = $logo->store('logos', 'public');
            $data['logo'] = $path1;
        }

        if ($request->hasFile('banner')) {
            $banner = $request->file('banner');
            $path2 = $banner->store('banners', 'public');
            $data['banner'] = $path2;
        }

        // Save data to database
        $personalizar = new Personalizar();
        $personalizar->fill($data);
        $personalizar->save();

        // Return response
        return response()->json(['message' => 'Updated successfully', 'personalizar' => $personalizar->fresh()]);
    }


    public function update(Request $request, $id)
    {
        $personalizar = Personalizar::findOrFail($id);

        // $personalizar->proposito = $request->proposito;
        // $personalizar->slogan = $request->slogan;
        // $personalizar->actuacion = $request->actuacion;
        // $personalizar->titulo_evento = $request->evento;
        $personalizar->update($request->only('proposito', 'slogan', 'actuacion', 'titulo_evento', 'nombre_negocio'));


        // Manejar la carga del logo
        if ($request->hasFile('logo')) {
            // Eliminar el archivo anterior si existe
            if ($personalizar->logo) {
                Storage::disk('public')->delete($personalizar->logo);
            }

            // Guardar el nuevo archivo
            $logo = $request->file('logo');
            $path1 = $logo->store('logos', 'public');
            $personalizar->logo = $path1;
        }

        // Manejar la carga del banner
        if ($request->hasFile('banner')) {
            // Eliminar el archivo anterior si existe
            if ($personalizar->banner) {
                Storage::disk('public')->delete($personalizar->banner);
            }

            // Guardar el nuevo archivo
            $banner = $request->file('banner');
            $path2 = $banner->store('banners', 'public');
            $personalizar->banner = $path2;
        }

        $personalizar->save();

        return response()->json(['message' => 'Updated successfully', 'personalizar' => $personalizar->fresh()]);
    }

    public function portada(Request $request, $id)
    {
        // dd('portada');
        $personalizar = Personalizar::findOrFail($id);

        // Manejar la carga del logo
        if ($request->hasFile('portada')) {
            // Eliminar el archivo anterior si existe
            if ($personalizar->portada) {
                Storage::disk('public')->delete($personalizar->portada);
            }

            // Guardar el nuevo archivo
            $portada = $request->file('portada');
            $path1 = $portada->store('portada', 'public');
            $personalizar->portada = $path1;
        }
        $personalizar->save();

        // Return response
        return response()->json(['message' => 'Updated successfully', 'personalizar' => $personalizar->fresh()]);
    }
}
