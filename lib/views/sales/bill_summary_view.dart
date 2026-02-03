import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/sales_controller.dart';
import '../../services/pdf_service.dart';

class BillSummaryView extends StatelessWidget {
  BillSummaryView({super.key});

  final SalesController controller =
      Get.find<SalesController>();

  File? generatedFile; // PDF reference

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bill Summary'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // -------- GENERATE BILL --------
            ElevatedButton.icon(
              icon: const Icon(Icons.picture_as_pdf),
              label: const Text('Generate Bill PDF'),
              onPressed: () async {
                if (controller.sales.isEmpty) {
                  Get.snackbar(
                    'Error',
                    'No sales available',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                  return;
                }

                generatedFile =
                    await PdfService.generateFullBillPdf(
                  controller.sales,
                );

                Get.snackbar(
                  'Success',
                  'Bill generated successfully',
                  snackPosition: SnackPosition.BOTTOM,
                );
              },
            ),

            const SizedBox(height: 20),

            // -------- SHARE BILL --------
            ElevatedButton.icon(
              icon: const Icon(Icons.share),
              label: const Text('Share Bill'),
              onPressed: () async {
                if (generatedFile == null) {
                  Get.snackbar(
                    'Error',
                    'Please generate bill first',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                  return;
                }

                await PdfService.sharePdf(generatedFile!);
              },
            ),
          ],
        ),
      ),
    );
  }
}
