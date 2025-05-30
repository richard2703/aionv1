<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Inertia\Inertia;

class notebookController extends Controller
{
    //
    function index()
    {
        return Inertia::render('Notebook/NotebookIndex');
    }
}
