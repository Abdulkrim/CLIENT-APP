import 'package:flutter/material.dart';

import 'package:get/get.dart';
class RoundedCheckBoxWidget extends StatefulWidget {
  const RoundedCheckBoxWidget({
    super.key,
    this.height = 20,
    this.width = 20,
    this.initalCheck = false,
    this.text = '',
    required this.onChnageCheck,
    this.textStyle,
  });

  final String text;
  final double width;
  final double height;
  final bool initalCheck;
  final TextStyle? textStyle;
  final Function(bool check) onChnageCheck;

  @override
  State<RoundedCheckBoxWidget> createState() => _RoundedCheckBoxWidgetState();
}

class _RoundedCheckBoxWidgetState extends State<RoundedCheckBoxWidget> {
  late bool check = widget.initalCheck;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: widget.height,
          width: widget.width,
          child: Checkbox(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
            value: check,
            onChanged: (bool? value) {
              setState(() {
                check = value ?? false;
              });

              widget.onChnageCheck(check);
            },
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Flexible(
          child: Text(
            widget.text,
            style: widget.textStyle ?? context.textTheme.titleMedium,
          ),
        ),
      ],
    );
  }
}
