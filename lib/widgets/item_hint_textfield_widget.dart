import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/theme/theme_data.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/rounded_text_input.dart';

class ItemHintTextFieldWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final String?  descriptionText;
  final TextStyle? hintTextStyle;
  final Widget? suffixIcon;
  final Widget? prefixWidget;
  final bool isRequired;
  final double? width;
  final bool isEnable;
  final bool? isRow;
  final TextInputType keyboardType;
  final BoxConstraints? prefixIconConstraints;
  final Function(String)? onChange;

  const ItemHintTextFieldWidget(
      {Key? key,
        required this.textEditingController,
        required this.hintText,
        this.width,
        this.hintTextStyle,
        this.suffixIcon,
        this.prefixWidget,
        this.descriptionText,
        this.isRow,
        this.onChange,
        this.isEnable = true,
        this.isRequired = false,
        this.keyboardType = TextInputType.text,
        this.prefixIconConstraints})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isRow ?? false,
      replacement: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(hintText,
              style: hintTextStyle ??
                  context.textTheme.titleSmall
                      ?.copyWith(fontWeight: FontWeight.bold,color: AppColors.headerColor)),
          Visibility(
            visible: descriptionText !=null,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
               mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.info_outline,color: AppColors.gray,size: 13,),
                  SizedBox(width: 1,),
                  Expanded(
                    child: Text(descriptionText ?? '',
                        style:
                            context.textTheme.titleSmall
                                ?.copyWith(fontSize: 11 ,color: AppColors.gray)),
                  ),
                ],
              ),
            ),
          ),
          context.sizedBoxHeightMicro,
          RoundedTextInputWidget(
            width: width,
            hintText: hintText,
            suffixIcon: suffixIcon,
            textEditController: textEditingController,
            isEnable: isEnable,
            prefixWidget: prefixWidget,
            isRequired: isRequired,
            keyboardType: keyboardType,
            prefixIconConstraints: prefixIconConstraints,
            onChange: (text) => onChange != null ? onChange!(text) :{},
          ),
        ],
      ),
      child: Row(

        children: [
          Text(hintText,
              style: hintTextStyle ??
                  context.textTheme.titleSmall
                      ?.copyWith(fontWeight: FontWeight.bold)),
          context.sizedBoxWidthMicro,
          RoundedTextInputWidget(
            width: width,
            hintText: hintText,
            suffixIcon: suffixIcon,
            textEditController: textEditingController,
            isEnable: isEnable,
            prefixWidget: prefixWidget,
            isRequired: isRequired,
            keyboardType: keyboardType,
            prefixIconConstraints: prefixIconConstraints,
          ),
        ],
      ),
    );
  }
}
