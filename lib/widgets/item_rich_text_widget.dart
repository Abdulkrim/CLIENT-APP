import 'package:flutter/material.dart';
import 'package:merchant_dashboard/theme/theme_data.dart';
import 'package:get/get.dart';

class ItemRichTextWidget extends StatelessWidget {
  final String rText, lText;
  final TextStyle? rTextStyle, lTextStyle;
  final int maxLine;

  const ItemRichTextWidget({
    Key? key,
    required this.rText,
    required this.lText,
    this.rTextStyle,
    this.lTextStyle,
    this.maxLine = 2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      maxLines: maxLine,
      overflow: TextOverflow.ellipsis,
      TextSpan(
        children: [
          TextSpan(
            text: rText,
            style: rTextStyle ?? context.textTheme.titleSmall?.copyWith(color: AppColors.gray),
          ),
          TextSpan(
            text: lText,
            style: lTextStyle ?? context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
