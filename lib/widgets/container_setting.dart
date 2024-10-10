import 'package:flutter/material.dart';
import 'package:merchant_dashboard/theme/theme_data.dart';

class ContainerSetting extends StatelessWidget {
  final Widget child;
  final double? maxWidth;
  final double? blur;
  final EdgeInsetsGeometry? padding;

  const ContainerSetting({super.key, required this.child, this.maxWidth, this.blur, this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsetsDirectional.only(start: 10, end: 10, top: 5), // todo: padding and shadows must be more optimize
      child: Container(
        constraints: BoxConstraints(maxWidth: maxWidth ?? 500),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                blurStyle: BlurStyle.normal,
                color: AppColors.black.withOpacity(0.12),
                offset: const Offset(0, 8),
                blurRadius: blur ?? 40,
                spreadRadius: 1)
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: child,
        ),
      ),
    );
  }
}
