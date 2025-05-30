<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Inertia\Inertia;

class configController extends Controller
{
    //

    public function index()
    {
        return Inertia::render('Config/ConfigIndex');
    }
}
