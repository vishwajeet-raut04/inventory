import 'dart:io';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';
import 'package:share_plus/share_plus.dart';

import '../models/sale_model.dart';

class PdfService {
  static Future<File> generateFullBillPdf(
    List<SaleModel> sales, {
    String? customerName,
  }) async {
    final pdf = pw.Document();

    double grandTotal = 0;

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // ================= HEADER =================
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'INVENTORY BILL',
                    style: pw.TextStyle(
                      fontSize: 26,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Text(
                    'Date: ${DateTime.now().toString().substring(0, 16)}',
                    style: const pw.TextStyle(fontSize: 10),
                  ),
                ],
              ),

              pw.SizedBox(height: 6),
              pw.Text(
                'Inventory Management System',
                style: pw.TextStyle(
                  fontSize: 12,
                  color: PdfColors.grey700,
                ),
              ),

              if (customerName != null && customerName.isNotEmpty) ...[
                pw.SizedBox(height: 4),
                pw.Text(
                  'Customer: $customerName',
                  style: const pw.TextStyle(fontSize: 12),
                ),
              ],

              pw.SizedBox(height: 16),
              pw.Divider(thickness: 1.5),

              // ================= TABLE HEADER =================
              pw.Container(
                padding: const pw.EdgeInsets.symmetric(
                    vertical: 8, horizontal: 6),
                color: PdfColors.blue50,
                child: pw.Row(
                  children: [
                    _headerCell('Product', flex: 4),
                    _headerCell('Qty', flex: 1, alignRight: true),
                    _headerCell('Price', flex: 2, alignRight: true),
                    _headerCell('Total', flex: 2, alignRight: true),
                  ],
                ),
              ),

              // ================= ITEMS =================
              ...sales.asMap().entries.map((entry) {
                final i = entry.key;
                final s = entry.value;
                grandTotal += s.total;

                return pw.Container(
                  padding: const pw.EdgeInsets.symmetric(
                      vertical: 6, horizontal: 6),
                  color: i.isEven
                      ? PdfColors.white
                      : PdfColors.grey100,
                  child: pw.Row(
                    children: [
                      _cell(s.productName, flex: 4),
                      _cell(s.quantity.toString(),
                          flex: 1, alignRight: true),
                      _cell('₹${s.price.toStringAsFixed(2)}',
                          flex: 2, alignRight: true),
                      _cell('₹${s.total.toStringAsFixed(2)}',
                          flex: 2, alignRight: true),
                    ],
                  ),
                );
              }),

              pw.Divider(thickness: 1),

              // ================= GRAND TOTAL =================
              pw.Align(
                alignment: pw.Alignment.centerRight,
                child: pw.Container(
                  padding: const pw.EdgeInsets.all(12),
                  decoration: pw.BoxDecoration(
                    color: PdfColors.blue100,
                    borderRadius: pw.BorderRadius.circular(6),
                  ),
                  child: pw.Text(
                    'Grand Total: ₹${grandTotal.toStringAsFixed(2)}',
                    style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
              ),

              pw.SizedBox(height: 32),

              // ================= FOOTER =================
              pw.Center(
                child: pw.Text(
                  'Thank you for your business!',
                  style: pw.TextStyle(
                    fontSize: 12,
                    color: PdfColors.grey600,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );

    // SAVE FILE
    final dir = await getApplicationDocumentsDirectory();
    final file = File(
      '${dir.path}/bill_${DateTime.now().millisecondsSinceEpoch}.pdf',
    );
    await file.writeAsBytes(await pdf.save());

    // AUTO OPEN
    await OpenFilex.open(file.path);

    return file;
  }

  static Future<void> sharePdf(File file) async {
    await Share.shareXFiles(
      [XFile(file.path)],
      text: 'Invoice',
    );
  }

  // ================= HELPERS =================
  static pw.Widget _headerCell(String text,
      {int flex = 1, bool alignRight = false}) {
    return pw.Expanded(
      flex: flex,
      child: pw.Text(
        text,
        textAlign:
            alignRight ? pw.TextAlign.right : pw.TextAlign.left,
        style: pw.TextStyle(
          fontWeight: pw.FontWeight.bold,
          fontSize: 11,
        ),
      ),
    );
  }

  static pw.Widget _cell(String text,
      {int flex = 1, bool alignRight = false}) {
    return pw.Expanded(
      flex: flex,
      child: pw.Text(
        text,
        textAlign:
            alignRight ? pw.TextAlign.right : pw.TextAlign.left,
        style: const pw.TextStyle(fontSize: 11),
      ),
    );
  }
}
