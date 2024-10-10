import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AppSwitchToggle extends StatelessWidget {
  const AppSwitchToggle({
    super.key,
    required this.currentStatus,
    required this.onStatusChanged,
    this.label = '',
    this.scale = 0.8,
    this.disableThumbColor = const Color(0xFFFFFFFF),
    this.disableTrackColor = const Color(0xACCACACA),
    this.enableThumbColor = const Color(0xFFF07F25),
    this.enableTrackColor = const Color(0xFFFFF0E3),
    this.labelStyle,
  });

  final bool currentStatus;
  final Function(bool status) onStatusChanged;
  final double scale;
  final String label;
  final Color enableThumbColor;
  final Color disableThumbColor;
  final Color disableTrackColor;
  final Color enableTrackColor;
  final TextStyle? labelStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Transform.scale(
          scale: scale,
          child: CupertinoSwitch(
            value: currentStatus,
            onChanged: (value) => onStatusChanged(value),
            thumbColor: (currentStatus) ? enableThumbColor : disableThumbColor,
            trackColor: (currentStatus) ? enableTrackColor : disableTrackColor,
            activeColor: enableTrackColor,
          ),
        ),
        Text(
          label,
          style:labelStyle ?? context.textTheme.bodySmall,
        ),
      ],
    );
  }
}
