<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Inertia\Inertia;

class tutorialController extends Controller
{
    //
    function index()
    {

        return Inertia::render('Tutorial/TutorialIndex');
    }
}
