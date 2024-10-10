import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/stock/data/models/entity/stocks.dart';
import 'package:merchant_dashboard/generated/assets.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import '../../../../utils/responsive_widgets/responsive_dialog_widget.dart';
import '../../../../widgets/network_image_rounded_widget.dart';

class StockDetailsDialog extends StatelessWidget {
  final StockInfo stock;

  const StockDetailsDialog({
    Key? key,
    required this.stock
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveDialogWidget(
      title: S.current.stockDetails,
      width: 650,
      height: 320,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            NetworkImageRounded(
              url: stock.image,
              height: double.infinity,
              width: 200,
            ),
            context.sizedBoxWidthExtraSmall,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  RichText(
                      text: TextSpan(children: [
                        TextSpan(text: '${S.current.productEngName} :\n', style: context.textTheme.bodyMedium),
                        TextSpan(
                            text: stock.itemNameEN,
                            style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
                      ])),
                  RichText(
                      text: TextSpan(children: [
                        TextSpan(text: '${S.current.measureUnit} :\n', style: context.textTheme.bodyMedium),
                        TextSpan(
                            text: '${stock.itemStock?.measureUnit?.name} - ${stock.itemStock?.measureUnit?.symbol}',
                            style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
                      ])),
                  RichText(
                      text: TextSpan(children: [
                        TextSpan(text: '${S.current.barcodeNumber} :\n', style: context.textTheme.bodyMedium),
                        WidgetSpan(
                            child: Row(
                              children: [
                                Text(stock.barCode, style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
                                IconButton(
                                    onPressed: () {
                                      Clipboard.setData(ClipboardData(text: stock.barCode));
                                    },
                                    icon: SvgPicture.asset(Assets.iconsCopyIcon, width: 20, color: Colors.black)),
                              ],
                            ))
                      ])),
                  RichText(
                      text: TextSpan(children: [
                        TextSpan(text: '${S.current.currentQuantity} :\n', style: context.textTheme.bodyMedium),
                        TextSpan(
                            text: stock.quantity.toString(),
                            style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: Colors.green)),
                      ])),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
 