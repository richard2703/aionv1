<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Inertia\Inertia;
use Illuminate\Support\Facades\Gate;
use Spatie\Permission\Models\permission;
use Spatie\Permission\Models\Role;
use hasrole;

class AdminController extends Controller
{

    public function index()
    {
        abort_if(Gate::denies('test'), '403');
        dd("paso");
        return Inertia::render('Admin/AdminIndex');
    }
}
