<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class PdfController extends Controller
{
    public function getPdf($filename)
    {
        $path = "pdfs/$filename";

        if (!Storage::disk('public')->exists($path)) {
            abort(404, 'PDF no encontrado');
        }

        return response()->file(storage_path("app/public/" . $path));
    }
}
