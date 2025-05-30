<?php

namespace App\Http\Controllers;

use App\Models\desperdicios;
use Illuminate\Http\Request;
use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Writer\Xlsx;

class ExcelExportController extends Controller
{
    public function exportDesperdicios(Request $request)
    {
        $query = desperdicios::with('area', 'tipo', 'usuario');

        if ($request->from) {
            $query->where('created_at', '>=', $request->from);
        }

        if ($request->to) {
            $query->where('created_at', '<=', $request->to);
        }

        $desperdicios = $query->get();

        $spreadsheet = new Spreadsheet();
        $sheet = $spreadsheet->getActiveSheet();

        $sheet->setTitle('Desperdicios');
        $sheet->mergeCells('A1:I1');
        $sheet->setCellValue('A1', 'Desperdicios | AION Business | ' . date('d/m/Y', strtotime($request->from)) . ' - ' . date('d/m/Y', strtotime($request->to)));

        $sheet->setCellValue('A2', 'No');
        $sheet->setCellValue('B2', 'Pilar');
        $sheet->setCellValue('C2', 'Tipo');
        $sheet->setCellValue('D2', 'Descripción');
        $sheet->setCellValue('E2', 'Monto');
        $sheet->setCellValue('F2', 'Rango');
        $sheet->setCellValue('G2', 'Recurrencia');
        $sheet->setCellValue('H2', 'Detectabilidad');
        $sheet->setCellValue('I2', 'Registrado por');

        $sheet->getStyle('A1:I1')->getAlignment()->setHorizontal(\PhpOffice\PhpSpreadsheet\Style\Alignment::HORIZONTAL_CENTER);
        $sheet->getStyle('A1:I1')->getFont()->setBold(true);
        $sheet->getStyle('A2:I2')->getFont()->setBold(true);

        $sheet->getColumnDimension('A')->setAutoSize(true);
        $sheet->getColumnDimension('B')->setAutoSize(true);
        $sheet->getColumnDimension('C')->setAutoSize(true);
        $sheet->getColumnDimension('D')->setAutoSize(true);
        $sheet->getColumnDimension('E')->setAutoSize(true);
        $sheet->getColumnDimension('F')->setAutoSize(true);
        $sheet->getColumnDimension('G')->setAutoSize(true);
        $sheet->getColumnDimension('H')->setAutoSize(true);
        $sheet->getColumnDimension('I')->setAutoSize(true);

        $row = 3;
        if ($desperdicios->isEmpty()) {
            $sheet->setCellValue('A' . $row, 'No data available for the selected period');
        } else {
            foreach ($desperdicios as $desperdicio) {
                $sheet->setCellValue('A' . $row, $row - 1);
                $sheet->setCellValue('B' . $row, $desperdicio->area ? $desperdicio->area->name : 'N/A');
                $sheet->setCellValue('C' . $row, $desperdicio->tipo ? $desperdicio->tipo->nombre : 'N/A');
                $sheet->setCellValue('D' . $row, $desperdicio->descripcion);
                $sheet->setCellValue('E' . $row, $desperdicio->monto);
                $sheet->setCellValue('F' . $row, $desperdicio->rango);
                $sheet->setCellValue('G' . $row, $desperdicio->recurrencia);
                $sheet->setCellValue('H' . $row, $desperdicio->detectabilidad);
                $sheet->setCellValue('I' . $row, $desperdicio->usuario ? $desperdicio->usuario->name : 'N/A');
                $row++;
            }
        }

        $writer = new Xlsx($spreadsheet);
        $fileName = "Desperdicios AION Business " . date('d/m/Y', strtotime($request->from)) . " - " . date('d/m/Y', strtotime($request->to)) . ".xlsx";
        header("Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        header("Content-Disposition: attachment;filename=\"$fileName\"");
        header("Cache-Control: max-age=0");

        ob_end_clean();
        $writer->save('php://output');
        exit();
    }
}
