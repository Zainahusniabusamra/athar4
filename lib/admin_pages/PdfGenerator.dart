import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';

class PdfGenerator {
  final int doneDonationsId;
  final String personName;
  final String doneDonationsName;
  final DateTime startDate;
  final DateTime endDate;
  final int targetAmount;
  final Uint8List documentImage;

  PdfGenerator({
    required this.doneDonationsId,
    required this.personName,
    required this.doneDonationsName,
    required this.startDate,
    required this.endDate,
    required this.targetAmount,
    required this.documentImage,
  });

  Future<Uint8List> generatePdf() async {
    final pdf = pw.Document();

    // Add page to PDF
    pdf.addPage(
      pw.Page(
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Header(
              level: 1,
              child: pw.Text('تقرير التبرع', textDirection: pw.TextDirection.rtl),
            ),
            pw.Paragraph(
              text: 'رقم التبرع: $doneDonationsId',
              //textDirection: pw.TextDirection.rtl,
            ),
            pw.Paragraph(
              text: 'اسم التبرع: $doneDonationsName',
              //textDirection: pw.TextDirection.rtl,
            ),
            pw.Paragraph(
              text: 'تاريخ البداية: ${startDate.day}/${startDate.month}/${startDate.year}',
              //textDirection: pw.TextDirection.rtl,
            ),
            pw.Paragraph(
              text: 'تاريخ الانتهاء: ${endDate.day}/${endDate.month}/${endDate.year}',
              //textDirection: pw.TextDirection.rtl,
            ),
            pw.Paragraph(
              text: 'اسم الشخص: $personName',
              //textDirection: pw.TextDirection.rtl,
            ),
            pw.Paragraph(
              text: 'المبلغ المستهدف: $targetAmount',
             // textDirection: pw.TextDirection.rtl,
            ),
            pw.Paragraph(
              text: 'صورة المستند:',
              //textDirection: pw.TextDirection.rtl,
            ),
            pw.Image(
              pw.MemoryImage(documentImage),
              fit: pw.BoxFit.cover,
              width: 200,
              height: 200,
            ),
          ],
        ),
      ),
    );

    // Save the PDF document to Uint8List and return
    return pdf.save();
  }
}
