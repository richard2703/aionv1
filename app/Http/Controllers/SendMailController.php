<?php

namespace App\Http\Controllers;

use App\Mail\MinutaTareaMail;
use App\Mail\NuevaTareaMail;
use App\Mail\RecordatorioTareaMail;
use App\Mail\TestMail;
use App\Models\minutas;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Mail;

class SendMailController extends Controller
{
    //
    public function sendMailWithAttachment(Request $request)
    {
        // Laravel 8
        // $data["email"] = "test@gmail.com";
        // $data["title"] = "Techsolutionstuff";
        // $data["body"] = "This is test mail with attachment";

        // $files = [
        //     public_path('attachments/test_image.jpeg'),
        //     public_path('attachments/test_pdf.pdf'),
        // ];

        // Mail::send('mail.test_mail', $data, function($message)use($data, $files) {
        //     $message->to($data["email"])
        //             ->subject($data["title"]);

        //     foreach ($files as $file){
        //         $message->attach($file);
        //     }
        // });
        $mailData = [
            'title' => 'This is Test Mail',
            // 'files' => [
            //     public_path('attachments/test_image.jpeg'),
            //     public_path('attachments/test_pdf.pdf'),
            // ]
        ];

        Mail::to('software.lider@nutriton.com.mx')->send(new TestMail($mailData));

        return response()->json(['message' => 'Mail sent successfully']);
    }

    public function recordatorioTarea()
    {


        $mailData = User::with(['tarea' => function ($query) {
            $query->where('estatus_id', '<>', '4');
        }])->get();

        foreach ($mailData as $key => $mailValue) {
            // TODO: HACER QUE ESTO SE EJECUTE DE FORMA AUTOMATICA
            if (count($mailValue->tarea) > 0) {

                Mail::to($mailValue->email)->send(new RecordatorioTareaMail($mailValue));
            }
        }
        return response()->json(['message' => 'Mail sent successfully']);
    }

    public function sendTareasByMinuta(minutas $minuta)
    {
        $mailData = $minuta->load('tarea.responsable', 'tarea.estatus', 'asistente.user', 'lider');

        $users = User::with(['tarea' => function ($query) use ($minuta) {
            $query->where('minuta_id', $minuta->id);
        }])->get();

        // Enviar correo a los asistentes
        foreach ($minuta->asistente as $asistente_key => $asistente) {

            Mail::to($asistente->user->email)->send(new MinutaTareaMail($mailData));
        }
        // Enviar correo a los responsables de tareas
        foreach ($users as $user_key => $mailValue) {
            // TODO: HACER QUE ESTO SE EJECUTE DE FORMA AUTOMATICA
            if (count($mailValue->tarea) > 0) {

                Mail::to($mailValue->email)->send(new NuevaTareaMail($mailValue));
            }
        }
        // Enviar correo al lider
        Mail::to($minuta->lider->email)->send(new MinutaTareaMail($mailData));

        return response()->json(['message' => 'Mail sent successfully']);
    }
}
