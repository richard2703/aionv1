<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Inertia\Inertia;

class scoreCardController extends Controller
{
    //
    function index()
    {
        return Inertia::render('ScoreCard/ScoreCardIndex');
    }
}
