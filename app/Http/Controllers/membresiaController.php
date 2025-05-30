<?php

namespace App\Http\Controllers;

use App\Models\Membresia;
use Illuminate\Http\Request;

class membresiaController extends Controller
{
    //
    function findAll()
    {
        return response()->json(Membresia::all());
    }
}
