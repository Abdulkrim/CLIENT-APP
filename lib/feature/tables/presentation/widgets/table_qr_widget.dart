import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/utils/mixins/mixins.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:get/get.dart';

import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../../utils/responsive_widgets/responsive_dialog_widget.dart';
import '../../../../widgets/rounded_btn.dart';

import 'package:merchant_dashboard/utils/extensions/qr_code/io_save_image.dart'
    if (dart.library.html) 'package:merchant_dashboard/utils/extensions/qr_code/web_save_image.dart';

class TableQrWidget extends StatefulWidget {
  const TableQrWidget({super.key, required this.tableLink});

  final String tableLink;

  @override
  State<TableQrWidget> createState() => _TableQrWidgetState();
}

class _TableQrWidgetState extends State<TableQrWidget> with DownloadUtils {
  late QrImage _qrImage;

  late PrettyQrDecoration _decoration;

  @override
  void initState() {
    super.initState();

    _qrImage = QrImage(QrCode.fromData(
      data: widget.tableLink,
      errorCorrectLevel: QrErrorCorrectLevel.H,
    ));

    _decoration = const PrettyQrDecoration(
      shape: PrettyQrSmoothSymbol(
        color: Color(0xFF451D00),
      ),
      image: PrettyQrDecorationImage(
        image: AssetImage(Assets.iconsIcon),
        position: PrettyQrDecorationImagePosition.embedded,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveDialogWidget(
        title: 'Catalogak link',
        width: 400,
        height: 400,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                S.current.downloadOrScanQrCode,
                style: context.textTheme.titleSmall,
              ),
              context.sizedBoxHeightExtraSmall,
              Expanded(
                child: PrettyQrView.data(
                  data: widget.tableLink,
                  decoration: _decoration,
                ),
              ),
              context.sizedBoxHeightExtraSmall,
              RoundedBtnWidget(
                onTap: () async {
                  final link = await _qrImage.exportAsImage(
                    context,
                    decoration: _decoration,
                    size: 512,
                  );

                  await openLink(url: link!);
                },
                btnText: 'Download QR Image',
                btnIcon: SvgPicture.asset(
                  Assets.iconsIcDownload,
                  width: 15,
                ),
                boxBorder: Border.all(color: Colors.black),
                bgColor: Colors.transparent,
                btnTextColor: Colors.black,
                btnPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              )
            ],
          ),
        ));
  }
}
