<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Minuta</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            font-size: 12px;
        }

        .container {
            width: 100%;
            margin: 0 auto;
            padding: 10px;
            border: 1px solid #ddd;
        }

        .section {
            margin-bottom: 20px;
            padding: 25px;
            /* border: 1px solid #ccc; */
            border-radius: 5px;
            width: auto;
        }

        .title {
            font-size: 16px;
            font-weight: bold;
            margin-bottom: 10px;
            display: inline;
        }


        .row {
            width: 50%;
        }

        .col {
            width: 48%;
            margin-bottom: 10px;
        }

        .label {
            font-weight: bold;
        }

        .table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        .table,
        .table th,
        .table td {
            border: 1px solid black;
        }

        .table th,
        .table td {
            padding: 5px;
            text-align: left;
        }

        .text-center {
            text-align: center;
        }

        .text-red {
            color: red;
        }

        .grid-container {
            display: grid;
            grid-template-columns: auto auto;
        }

        .content {
            width: 50%;
            padding: 10px vertical-align: top;
            text-align: left;
        }
    </style>
</head>

<body>

    <div class="container">
        <div class="section">
            <table>
                <tr>
                    <td class="content">
                        <!-- Información General -->
                        <div class="title">Información General</div>
                        <div class="col"><span class="label">Título:</span> {{ $minuta->alias }}</div>
                        <div class="col"><span class="label">Pilar:</span> {{ $minuta->area->nombre }}</div>
                        <div class="col"><span class="label">Flujo de Valor:</span>
                            {{ $minuta->departamento->nombre ?? 'Todos los flujos' }}</div>
                        <div class="col"><span class="label">Tipo:</span> {{ $minuta->tipoMinuta->titulo }}
                        </div>
                        <div class="col"><span class="label">Fecha:</span>
                            {{ date('d-m-Y', strtotime($minuta->created_at)) }}</div>
                        <div class="col"><span class="label">Notas:</span> {{ $minuta->notas }}</div>

                    </td>
                    <td class="content">
                        <!-- Participantes -->
                        <div class="title">Participantes</div>
                        <div class="col"><span class="label">Líder:</span> {{ $minuta->lider->name }}</div>
                        <div class="col">
                            <span class="label">Participantes:</span>
                            <ul>
                                @foreach ($asistentes as $asistente)
                                    <li>{{ $asistente->user->name }}</li>
                                @endforeach
                            </ul>
                        </div>
                    </td>
                </tr>
            </table>
        </div>

        <!-- Tareas -->
        <div class="section">
            <div class="title">Tareas</div>
            <table class="table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Título</th>
                        <th>Estatus</th>
                        <th>Flujo de Valor</th>
                        <th>Responsable</th>
                        <th>Fecha de Entrega</th>
                        <th>Cliente</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach ($tareas as $tarea)
                        <tr>
                            <td class="text-center">{{ $tarea->id }}</td>
                            <td>{{ $tarea->tarea }}</td>
                            <td class="text-center">{{ $tarea->estatus->titulo }}</td>
                            <td class="text-center">{{ $tarea->departamento->nombre }}</td>
                            <td class="text-center">
                                {{ $tarea->responsable->name ?? 'Sin responsable' }}
                            </td>
                            <td class="text-center">{{ date('d-m-Y', strtotime($tarea->fecha)) }}</td>
                            <td class="text-center">
                                {{ $tarea->revisor->name ?? 'Sin cliente' }}
                            </td>
                        </tr>
                    @endforeach
                </tbody>
            </table>
        </div>
    </div>

</body>

</html>
