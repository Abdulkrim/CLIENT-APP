import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/utils/responsive_widgets/responsive_dialog_widget.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../generated/l10n.dart';

class BarcodeScannerDialog extends StatelessWidget {
  const BarcodeScannerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveDialogWidget(
      title: S.current.scanBarcode,
      child: MobileScanner(

        controller: MobileScannerController(
          detectionSpeed: DetectionSpeed.normal,
          facing: CameraFacing.back,
          torchEnabled: false,
        ),
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;

          Get.back(result: barcodes.first.rawValue.toString());

        },
      ),
    );
  }
}
