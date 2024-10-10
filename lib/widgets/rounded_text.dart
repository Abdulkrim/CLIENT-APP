import 'package:flutter/material.dart';

class RoundedTextWidget extends StatelessWidget {
  const RoundedTextWidget({
    Key? key,
    required this.text,
    this.textStyle = const TextStyle(fontSize: 12, color: Colors.black),
    this.textPadding = const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
    this.borderRadius = const BorderRadius.all(Radius.circular(10)),
    this.borderColor = const Color(0xffeeeeee),
    this.icon,
    this.onIconTapped,
  }) : super(key: key);

  final String text;
  final TextStyle textStyle;
  final EdgeInsetsGeometry textPadding;
  final BorderRadiusGeometry borderRadius;
  final Color borderColor;
  final Widget? icon;
  final Function? onIconTapped;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: textPadding,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        border: Border.all(
          color: borderColor,
        ),
        color: Colors.white,
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              text,
              style: textStyle,
            ),
          ),
          Visibility(
            visible: icon != null,
            child: Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: icon ?? const SizedBox.shrink(),
                onPressed: () {
                  if(onIconTapped != null) onIconTapped!();
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
