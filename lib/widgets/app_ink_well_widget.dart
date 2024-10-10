import 'package:flutter/material.dart';

class AppInkWell extends StatelessWidget {
  final Widget child;
  final Function? onTap;
  final Function(TapUpDetails details)? onTapUp;
  final Function(bool details)? onHover;
  final Color? hoverColor;
  final BorderRadius? borderRadius;

  const AppInkWell({
    Key? key,
    required this.child,
    this.onTap,
    this.onTapUp,
    this.onHover,
    this.hoverColor,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: borderRadius ?? BorderRadius.circular(8),
      focusColor: hoverColor ?? Colors.transparent,
      splashColor: hoverColor ?? Colors.transparent,
      hoverColor: hoverColor ?? Colors.transparent,
      highlightColor: hoverColor ?? Colors.transparent,
      overlayColor: const WidgetStatePropertyAll<Color>(Colors.transparent),
      onTap: () {
        if (onTap != null) onTap!();
      },
      onTapUp: (details) {
        if (onTapUp != null) onTapUp!(details);
      },
      onHover: (value) {
        if (onHover != null) onHover!(value);
      },
      child: child,
    );
  }
}
