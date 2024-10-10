import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

class RoundedTextInputWidget extends StatelessWidget {
  final String hintText;
  final TextEditingController? textEditController;
  final bool? obscureText;
  final Widget? suffixIcon;
  final Widget? prefixWidget;

  /// Set this feature to the const TextInputType.numberWithOptions(decimal: true, signed: true)
  /// If you want to allow user to enter decimal numbers
  final TextInputType? keyboardType;
  final int minLines, maxLines;
  final TextStyle textStyle;
  final bool isEnable;
  final bool showFloatLabel;
  final EdgeInsetsGeometry contentPadding;
  final Function(String text)? onChange;
  final bool isRequired;
  final bool autofocus;
  final Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final double? width;
  final EdgeInsetsGeometry? margin;
  final int maxLength;
  final double? height;
  final BoxConstraints? prefixIconConstraints;

  const RoundedTextInputWidget(
      {Key? key,
      required this.hintText,
      this.textEditController,
      this.focusNode,
      this.maxLength = 200,
      this.width,
      this.onFieldSubmitted,
      this.obscureText,
      this.isEnable = true,
      this.minLines = 1,
      this.maxLines = 1,
      this.keyboardType = TextInputType.text,
      this.textStyle = const TextStyle(fontSize: 12, color: Colors.black),
      this.suffixIcon,
      this.prefixWidget,
      this.onChange,
      this.showFloatLabel = false,
      this.contentPadding = const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      this.isRequired = false,
      this.autofocus = false,
      this.height = 60,
      this.validator,
      this.margin,
      this.prefixIconConstraints})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: height,
      width: width,
      child: TextFormField(
        focusNode: focusNode,
        enabled: isEnable,
        onFieldSubmitted: onFieldSubmitted,
        controller: textEditController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator:
            validator ?? (value) => (isRequired && value != null && value.trim().isEmpty) ? S.current.thisFieldRequired : null,
        style: textStyle,
        onChanged: (value) {
          if (onChange != null) onChange!(value);
        },
        autofocus: autofocus,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                color: context.colorScheme.primaryColor,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(
                color: Color(0xffeeeeee),
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(
                color: Color(0xffeeeeee),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(
                color: Color(0xffeeeeee),
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(
                color: Colors.redAccent,
              ),
            ),
            hintStyle: const TextStyle(color: Colors.grey),
            filled: false,
            labelText: showFloatLabel ? hintText : null,
            hintText: hintText,
            counterText: "",
            fillColor: Colors.white70,
            suffixIcon: suffixIcon,
            prefixIcon: prefixWidget,
            prefixIconConstraints: prefixIconConstraints,
            contentPadding: contentPadding),
        minLines: minLines,
        maxLines: maxLines,
        maxLength: maxLength == -1 ? null : maxLength,
        keyboardType: keyboardType,
        inputFormatters: (keyboardType == const TextInputType.numberWithOptions(decimal: true, signed: true))
            ? [
                FilteringTextInputFormatter.allow(RegExp(r'^[-]?\d*\.?\d*')),
              ]
            : keyboardType == TextInputType.number
                ? [FilteringTextInputFormatter.digitsOnly]
                : null,
        obscureText: obscureText ?? false,
      ),
    );
  }
}
