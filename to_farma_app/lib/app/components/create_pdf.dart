import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/pdf.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:to_farma_app/core/models/models.dart';
import 'package:to_farma_app/core/providers/providers.dart';
import 'package:to_farma_app/core/utlis/assets.dart';
import 'package:share/share.dart';

enum PDFAction { SEND, SAVE, SHARE }

class PdfGenerator {
  ///generar el pdf para bebidas
  static Future<FutureResponse> generatePDFBebidas(
      {required String filename,
      required BuildContext context,
      required PDFAction action,
      required PharmacovigilanceProvider formulario,
      required User user}) async {
    FutureResponse response = FutureResponse(respuesta: false, mensaje: null);
    try {
      ///generamos un documento pdf
      final pdf = pw.Document();
      final logoData = await rootBundle.load(Assets.imageFarmacovigilancia);
      final logoImage = pw.MemoryImage(logoData.buffer.asUint8List());

      // Agregar la tabla al PDF
      pdf.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Column(
                  children: [
                    pw.Text("Paciente: ${user.name}"),
                    pw.Text("E-mail: ${user.email}"),
                    pw.Text("Teléfono: ${user.phone}"),
                  ],
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                ),
                pw.SizedBox(
                  height: 150,
                  width: 150,
                  child: pw.Image(logoImage),
                )
              ],
            ),
            pw.SizedBox(width: 15, height: 5),
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Text('Sección 1', style: const pw.TextStyle(fontSize: 16)),
              ],
            ),
            pw.SizedBox(height: 10),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Text(formulario.seccion1Titulo,
                    style: const pw.TextStyle(fontSize: 24)),
              ],
            ),
            pw.SizedBox(height: 15),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(formulario.seccion1Descripcion,
                    maxLines: 100, style: const pw.TextStyle(fontSize: 14)),
              ],
            ),
            pw.SizedBox(height: 10),
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Text('Sección 2', style: const pw.TextStyle(fontSize: 16)),
              ],
            ),
            pw.SizedBox(height: 10),
            pw.Container(
                width: 900,
                padding: const pw.EdgeInsets.only(
                    top: 10, bottom: 10, left: 10, right: 10),
                decoration: pw.BoxDecoration(
                    borderRadius: const pw.BorderRadius.only(
                        topLeft: pw.Radius.circular(15),
                        topRight: pw.Radius.circular(15),
                        bottomLeft: pw.Radius.circular(0),
                        bottomRight: pw.Radius.circular(0)),
                    border: pw.Border.all(
                        color: PdfColors.grey, style: pw.BorderStyle.solid)),
                child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('¿Cuál es el motivo de consulta?',
                          style: pw.TextStyle(
                              fontSize: 14, fontWeight: pw.FontWeight.bold)),
                      pw.SizedBox(width: 15, height: 5),
                      pw.Text(formulario.seccion2Motivo ?? '',
                          style: pw.TextStyle(
                              fontSize: 12, fontWeight: pw.FontWeight.bold)),
                    ])),
            pw.Container(
                width: 900,
                padding: const pw.EdgeInsets.only(
                    top: 10, bottom: 10, left: 10, right: 10),
                decoration: pw.BoxDecoration(
                    borderRadius: const pw.BorderRadius.only(
                        topLeft: pw.Radius.circular(0),
                        topRight: pw.Radius.circular(0),
                        bottomLeft: pw.Radius.circular(0),
                        bottomRight: pw.Radius.circular(0)),
                    border: pw.Border.all(
                        color: PdfColors.grey, style: pw.BorderStyle.solid)),
                child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('¿Qué enfermedades padece?',
                          style: pw.TextStyle(
                              fontSize: 14, fontWeight: pw.FontWeight.bold)),
                      pw.SizedBox(width: 15, height: 5),
                      pw.Text(formulario.seccion2Enfermedades,
                          style: pw.TextStyle(
                              fontSize: 12, fontWeight: pw.FontWeight.bold)),
                    ])),
            pw.Container(
                width: 900,
                padding: const pw.EdgeInsets.only(
                    top: 10, bottom: 10, left: 10, right: 10),
                decoration: pw.BoxDecoration(
                    borderRadius: const pw.BorderRadius.only(
                        topLeft: pw.Radius.circular(0),
                        topRight: pw.Radius.circular(0),
                        bottomLeft: pw.Radius.circular(0),
                        bottomRight: pw.Radius.circular(0)),
                    border: pw.Border.all(
                        color: PdfColors.grey, style: pw.BorderStyle.solid)),
                child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('¿Cuáles medicamentos toma?',
                          style: pw.TextStyle(
                              fontSize: 14, fontWeight: pw.FontWeight.bold)),
                      pw.SizedBox(width: 15, height: 5),
                      pw.Text(formulario.seccion2Medicamentos,
                          style: pw.TextStyle(
                              fontSize: 12, fontWeight: pw.FontWeight.bold)),
                    ])),
            pw.Container(
                width: 900,
                padding: const pw.EdgeInsets.only(
                    top: 10, bottom: 10, left: 10, right: 10),
                decoration: pw.BoxDecoration(
                    borderRadius: const pw.BorderRadius.only(
                        topLeft: pw.Radius.circular(0),
                        topRight: pw.Radius.circular(0),
                        bottomLeft: pw.Radius.circular(15),
                        bottomRight: pw.Radius.circular(15)),
                    border: pw.Border.all(
                        color: PdfColors.grey, style: pw.BorderStyle.solid)),
                child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                          '¿Ha presentado antes algún efecto secundario a otro medicamento?',
                          style: pw.TextStyle(
                              fontSize: 14, fontWeight: pw.FontWeight.bold)),
                      pw.SizedBox(width: 15, height: 5),
                      pw.Text(
                          formulario.seccion2EfectoSecundario ==
                                  EfectoSecundario.si
                              ? 'SI'
                              : 'NO',
                          style: pw.TextStyle(
                              fontSize: 12, fontWeight: pw.FontWeight.bold)),
                    ])),
            pw.SizedBox(height: 10),
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Text('Sección 3', style: const pw.TextStyle(fontSize: 16)),
              ],
            ),
            pw.SizedBox(height: 10),
            pw.Container(
                width: 900,
                padding: const pw.EdgeInsets.only(
                    top: 10, bottom: 10, left: 10, right: 10),
                decoration: pw.BoxDecoration(
                    borderRadius: const pw.BorderRadius.only(
                        topLeft: pw.Radius.circular(15),
                        topRight: pw.Radius.circular(15),
                        bottomLeft: pw.Radius.circular(0),
                        bottomRight: pw.Radius.circular(0)),
                    border: pw.Border.all(
                        color: PdfColors.grey, style: pw.BorderStyle.solid)),
                child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('Producto',
                          style: pw.TextStyle(
                              fontSize: 14, fontWeight: pw.FontWeight.bold)),
                      pw.SizedBox(width: 15, height: 5),
                      pw.Text(formulario.seccion3Producto ?? '',
                          style: pw.TextStyle(
                              fontSize: 12, fontWeight: pw.FontWeight.bold)),
                    ])),
            pw.Container(
                width: 900,
                padding: const pw.EdgeInsets.only(
                    top: 10, bottom: 10, left: 10, right: 10),
                decoration: pw.BoxDecoration(
                    borderRadius: const pw.BorderRadius.only(
                        topLeft: pw.Radius.circular(0),
                        topRight: pw.Radius.circular(0),
                        bottomLeft: pw.Radius.circular(0),
                        bottomRight: pw.Radius.circular(0)),
                    border: pw.Border.all(
                        color: PdfColors.grey, style: pw.BorderStyle.solid)),
                child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('Producto a reportar',
                          style: pw.TextStyle(
                              fontSize: 14, fontWeight: pw.FontWeight.bold)),
                      pw.SizedBox(width: 15, height: 5),
                      pw.Text(formulario.seccion3ProductoReportar,
                          style: pw.TextStyle(
                              fontSize: 12, fontWeight: pw.FontWeight.bold)),
                    ])),
            pw.Container(
                width: 900,
                padding: const pw.EdgeInsets.only(
                    top: 10, bottom: 10, left: 10, right: 10),
                decoration: pw.BoxDecoration(
                    borderRadius: const pw.BorderRadius.only(
                        topLeft: pw.Radius.circular(0),
                        topRight: pw.Radius.circular(0),
                        bottomLeft: pw.Radius.circular(0),
                        bottomRight: pw.Radius.circular(0)),
                    border: pw.Border.all(
                        color: PdfColors.grey, style: pw.BorderStyle.solid)),
                child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('Lote',
                          style: pw.TextStyle(
                              fontSize: 14, fontWeight: pw.FontWeight.bold)),
                      pw.SizedBox(width: 15, height: 5),
                      pw.Text(formulario.seccion3Lote,
                          style: pw.TextStyle(
                              fontSize: 12, fontWeight: pw.FontWeight.bold)),
                    ])),
            pw.Container(
                width: 900,
                padding: const pw.EdgeInsets.only(
                    top: 10, bottom: 10, left: 10, right: 10),
                decoration: pw.BoxDecoration(
                    borderRadius: const pw.BorderRadius.only(
                        topLeft: pw.Radius.circular(0),
                        topRight: pw.Radius.circular(0),
                        bottomLeft: pw.Radius.circular(0),
                        bottomRight: pw.Radius.circular(0)),
                    border: pw.Border.all(
                        color: PdfColors.grey, style: pw.BorderStyle.solid)),
                child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('Indicación',
                          style: pw.TextStyle(
                              fontSize: 14, fontWeight: pw.FontWeight.bold)),
                      pw.SizedBox(width: 15, height: 5),
                      pw.Text(formulario.seccion3Indicacion,
                          style: pw.TextStyle(
                              fontSize: 12, fontWeight: pw.FontWeight.bold)),
                    ])),
            pw.Container(
                padding: const pw.EdgeInsets.only(
                    top: 10, bottom: 10, left: 10, right: 10),
                decoration: pw.BoxDecoration(
                    borderRadius: const pw.BorderRadius.only(
                        topLeft: pw.Radius.circular(0),
                        topRight: pw.Radius.circular(0),
                        bottomLeft: pw.Radius.circular(0),
                        bottomRight: pw.Radius.circular(0)),
                    border: pw.Border.all(
                        color: PdfColors.grey, style: pw.BorderStyle.solid)),
                child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('Vía de administración',
                          style: pw.TextStyle(
                              fontSize: 14, fontWeight: pw.FontWeight.bold)),
                      pw.SizedBox(width: 15, height: 5),
                      pw.Text(formulario.seccion3ViaAdministracion,
                          style: pw.TextStyle(
                              fontSize: 12, fontWeight: pw.FontWeight.bold)),
                    ])),
            pw.Container(
                padding: const pw.EdgeInsets.only(
                    top: 10, bottom: 10, left: 10, right: 10),
                decoration: pw.BoxDecoration(
                    borderRadius: const pw.BorderRadius.only(
                        topLeft: pw.Radius.circular(0),
                        topRight: pw.Radius.circular(0),
                        bottomLeft: pw.Radius.circular(0),
                        bottomRight: pw.Radius.circular(0)),
                    border: pw.Border.all(
                        color: PdfColors.grey, style: pw.BorderStyle.solid)),
                child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('Dosis (cantidad y cuántas veces al día)',
                          style: pw.TextStyle(
                              fontSize: 14, fontWeight: pw.FontWeight.bold)),
                      pw.SizedBox(width: 15, height: 5),
                      pw.Text(formulario.seccion3Dosis,
                          style: pw.TextStyle(
                              fontSize: 12, fontWeight: pw.FontWeight.bold)),
                    ])),
            pw.Container(
                padding: const pw.EdgeInsets.only(
                    top: 10, bottom: 10, left: 10, right: 10),
                decoration: pw.BoxDecoration(
                    borderRadius: const pw.BorderRadius.only(
                        topLeft: pw.Radius.circular(0),
                        topRight: pw.Radius.circular(0),
                        bottomLeft: pw.Radius.circular(0),
                        bottomRight: pw.Radius.circular(0)),
                    border: pw.Border.all(
                        color: PdfColors.grey, style: pw.BorderStyle.solid)),
                child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('Inicio del tratamiento',
                          style: pw.TextStyle(
                              fontSize: 14, fontWeight: pw.FontWeight.bold)),
                      pw.SizedBox(width: 15, height: 5),
                      pw.Text(formulario.seccion3InicioTratamiento,
                          style: pw.TextStyle(
                              fontSize: 12, fontWeight: pw.FontWeight.bold)),
                    ])),
            pw.Container(
                padding: const pw.EdgeInsets.only(
                    top: 10, bottom: 10, left: 10, right: 10),
                decoration: pw.BoxDecoration(
                    borderRadius: const pw.BorderRadius.only(
                        topLeft: pw.Radius.circular(0),
                        topRight: pw.Radius.circular(0),
                        bottomLeft: pw.Radius.circular(15),
                        bottomRight: pw.Radius.circular(15)),
                    border: pw.Border.all(
                        color: PdfColors.grey, style: pw.BorderStyle.solid)),
                child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('Conclusión del tratamiento',
                          style: pw.TextStyle(
                              fontSize: 14, fontWeight: pw.FontWeight.bold)),
                      pw.SizedBox(width: 15, height: 5),
                      pw.Text(formulario.seccion3ConclusionTratamiento,
                          style: pw.TextStyle(
                              fontSize: 12, fontWeight: pw.FontWeight.bold)),
                    ])),
          ];
        },
      ));

      //pdf creado
      // Guardar el PDF en el almacenamiento del dispositivo
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/$filename');
      final bytes = await pdf.save();
      await file.writeAsBytes(bytes);

      switch (action) {
        case PDFAction.SEND:
          response.mensaje = 'PDF creado! ${file.path}.';
          break;
        case PDFAction.SAVE:
          response.mensaje = 'PDF creado y enviado! ${file.path}.';
          break;
        case PDFAction.SHARE:
          await _sharePdf(file);
          break;
        default:
      }

      response.model = file.path;
      response.respuesta = true;
    } catch (e) {
      response.mensaje = 'Ha ocurrido un error, intente de nuevo.';
    }

    return response;
  }

  static Future<void> _sharePdf(File file) async {
    await Share.shareFiles(
      [file.path],
      mimeTypes: ['application/pdf'], // Cambiar a la MIME correspondiente
      subject: 'Archivo compartido', // Opcional
    );
  }
}
