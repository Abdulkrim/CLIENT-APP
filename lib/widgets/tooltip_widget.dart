import 'package:flutter/material.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

class TooltipWidget extends StatelessWidget {
  const TooltipWidget({super.key, required this.text});

  final String text;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Tooltip(
        richMessage: WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: Container(
              padding: const EdgeInsets.all(10),
              constraints: const BoxConstraints(maxWidth: 300),
              child: Text(text),
            )),
        verticalOffset: 10,
        triggerMode: TooltipTriggerMode.tap,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        preferBelow: false,
        decoration: const ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(9))),
          shadows: [
            BoxShadow(
              color: Color(0x0f000000),
              offset: Offset(0, 4),
              blurRadius: 5,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Icon(
          Icons.info_outline_rounded,
          color: context.colorScheme.primaryColor,
          size: 17,
        ),
      ),
    );
  }
}
