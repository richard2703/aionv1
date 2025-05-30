<!DOCTYPE html>
<html>

<head>
    <title>Nueva Tarea</title>
</head>

<body>

    <h1>Se ha creado una nueva</h1>
    <hr>
    <br>
    <p>
        Se han creado nuevas tareas, en la que se te ha etiquetado.
        @foreach ($mailData['tarea'] as $tarea)
            <br>
            <br>
            Titulo: <a href="http://localhost:8000/tareas/{{ $tarea['id'] }}/detalle"> {{ $tarea['tarea'] }}</a>
            <br>
            Responsable: {{ $tarea['responsable']->name }}
            <br>
            Estatus: {{ $tarea['estatus']->titulo }}
            <br>
            Fecha de entrega: {{ $tarea['fecha'] }}
            <br>
        @endforeach


    </p>
    <br>
    <p>verificar detalles en <a href="http://localhost:8000">AION</a></p>
</body>

</html>
