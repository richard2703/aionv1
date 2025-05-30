<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Inertia\Inertia;

class terminosController extends Controller
{
    //
    public function index()
    {
        return Inertia::render('Terminos/TerminosIndex');
    }
}
