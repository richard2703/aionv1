<!DOCTYPE html>
<html>

<body>

    <h1>Recordatorio</h1>
    <hr>
    <br>
    <p>

        Recuerda que tienes estas tareas, en la que se te ha etiquetado.
        @foreach ($mailData['tarea'] as $tarea)
            <br>
            Titulo: <a href="http://localhost:8000/tareas/{{ $tarea['id'] }}/detalle"> {{ $tarea['tarea'] }}</a>
            <br>
            Fecha de entrega: {{ $tarea['fecha'] }}
            <br>
        @endforeach




    </p>
    <br>
    <p>verificar detalles en <a href="http://localhost:8000"> AION</a></p>
</body>

</html>
