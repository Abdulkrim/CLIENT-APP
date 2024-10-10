import 'package:flutter/material.dart';
import 'package:merchant_dashboard/core/constants/defaults.dart';
import 'package:merchant_dashboard/widgets/app_ink_well_widget.dart';
import 'package:get/get.dart';

class RoundedBtnWidget extends StatelessWidget {
  final void Function() onTap;
  final Widget? btnIcon;
  final Widget? leadingIcon;
  final String btnText;
  final double? width;
  final double? height;
  final TextStyle? btnTextStyle;
  final BoxBorder? boxBorder;
  final Color bgColor;
  final Color btnTextColor;
  final EdgeInsetsGeometry btnMargin;
  final Duration? animDuration;
  final EdgeInsetsGeometry btnPadding;
  final double borderRadios;
  final Color? hoverColor;
  final bool hasShadow;
  final TextAlign? textAlign;

  /// If True, width of the button will be adjusted according to button's children width.
  /// If False, width of the button will be [width] or as large as possible
  final bool wrapWidth;

  const RoundedBtnWidget({
    Key? key,
    required this.onTap,
    this.btnIcon,
    this.leadingIcon,
    required this.btnText,
    this.width,
    this.borderRadios = 8.0,
    this.height,
    this.wrapWidth = false,
    this.hoverColor,
    this.textAlign,
    this.btnTextStyle,
    this.btnTextColor = Colors.white,
    this.boxBorder,
    this.bgColor = const Color(0xFFF07F25),
    this.hasShadow = true,
    this.btnMargin = const EdgeInsets.symmetric(vertical: 4.0, horizontal: 5.0),
    this.animDuration,
    this.btnPadding = const EdgeInsets.symmetric(horizontal: 5.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppInkWell(
      borderRadius: BorderRadius.circular(borderRadios),
      onTap: () => onTap(),
      hoverColor: hoverColor,
      child: AnimatedContainer(
        duration: animDuration ?? Defaults.defaultAnimDuration,
        height: height,
        width: (wrapWidth) ? null : width,
        constraints: BoxConstraints(
          minWidth: 20,
          maxWidth: width ?? 700,
        ),
        padding: btnPadding,
        margin: btnMargin,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(borderRadios),
          border: boxBorder,
          boxShadow: (bgColor == Colors.transparent ? false : hasShadow)
              ? const [
                  BoxShadow(
                    color: Color(0x0f000000),
                    offset: Offset(0, 4),
                    blurRadius: 10,
                    spreadRadius: 0,
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            btnIcon ?? Container(),
            Visibility(
              visible: (btnIcon != null && btnText.isNotEmpty),
              child: const SizedBox(
                width: 5.0,
              ),
            ),
            Text(
              btnText,
              textAlign: textAlign,
              style: (btnTextStyle ?? context.textTheme.labelLarge)?.copyWith(color: btnTextColor),
            ),
            Visibility(
              visible: (leadingIcon != null && btnText.isNotEmpty),
              child: const SizedBox(
                width: 5.0,
              ),
            ),
            leadingIcon ?? Container(),
          ],
        ),
      ),
    );
  }
}
