import 'package:flutter/material.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../../core/constants/defaults.dart';
import '../../../../../widgets/app_ink_well_widget.dart';

class TwoOptionsSectionWidget extends StatefulWidget {
  const TwoOptionsSectionWidget({super.key, required this.title,required this.flagValue, required this.onFlagChange});

  final String title;
  final bool flagValue;
  final Function(bool flag) onFlagChange;

  @override
  State<TwoOptionsSectionWidget> createState() => _TwoOptionsSectionWidgetState();
}

class _TwoOptionsSectionWidgetState extends State<TwoOptionsSectionWidget> {
  late bool flag = widget.flagValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 170,
          child: Text(
            widget.title,
          ),
        ),
           Text(
          S.current.yes,
          style: const TextStyle(
            color: Color(0xff404040),
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        context.sizedBoxWidthMicro,
        AppInkWell(
          onTap: () {
            setState(()=> flag = true);
            widget.onFlagChange(true);
          },
          child: AnimatedContainer(
            duration: Defaults.defaultAnimDuration,
            height: 20,
            width: 20,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: flag ? context.colorScheme.primaryColor : null,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: flag ? context.colorScheme.primaryColor : Colors.grey[300]!,
                width: 1,
              ),
            ),
          ),
        ),
        context.sizedBoxWidthExtraSmall,
          Text(
          S.current.no,
          style: const TextStyle(
            color: Color(0xff404040),
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        context.sizedBoxWidthMicro,
        AppInkWell(
          onTap: () {
            setState(()=> flag = false);
            widget.onFlagChange(false);
          },
          child: AnimatedContainer(
            duration: Defaults.defaultAnimDuration,
            height: 20,
            width: 20,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: !flag ? context.colorScheme.primaryColor : null,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: !flag ? context.colorScheme.primaryColor : Colors.grey[300]!,
                width: 1,
              ),
            ),
          ),
        ),

      ],
    );
  }
}
