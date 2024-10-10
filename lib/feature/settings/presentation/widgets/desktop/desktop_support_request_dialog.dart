import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/generated/assets.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/theme/theme_data.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/rounded_btn.dart';
import 'package:merchant_dashboard/widgets/rounded_dropdown_list.dart';
import 'package:merchant_dashboard/widgets/rounded_text_input.dart';

import 'contact_us_info_widget.dart';

class DesktopSupportRequestDialog extends StatelessWidget {
  DesktopSupportRequestDialog({Key? key}) : super(key: key);

  final double _dialogWidth = Get.width * .8;
  final double _dialogHeight = 700;

  final serviceTypesList = [
    'I need full support to setup pos app',
    'I need more information',
  ];

  final timesList = [
    S.current.morning,
    S.current.afterNoon,
    S.current.evening,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: _dialogWidth,
          height: _dialogHeight,
          decoration: BoxDecoration(
            color: AppColors.lightPrimaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: _dialogWidth / 2,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x0f000000),
                          offset: Offset(2, 0),
                          blurRadius: 10,
                          spreadRadius: 0,
                        ),
                      ],
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: S.current.serviceWith,
                            style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: ":)",
                            style: context.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold, color: context.colorScheme.primaryColor)),
                      ])),
                      context.sizedBoxHeightSmall,
                      Text(
                        S.current.theRightFit,
                        style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      context.sizedBoxHeightMicro,
                      Text(S.current.helpPOS,
                        style: context.textTheme.bodySmall,
                      ),
                      context.sizedBoxHeightExtraSmall,
                      Row(
                        children: [
                          SvgPicture.asset(
                            Assets.iconsIcTick,
                            width: 15,
                          ),
                          context.sizedBoxWidthMicro,
                          Text(
                            S.current.speakToRealPerson,
                            style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      context.sizedBoxHeightExtraSmall,
                      Row(
                        children: [
                          SvgPicture.asset(
                            Assets.iconsIcTick,
                            width: 15,
                          ),
                          context.sizedBoxWidthMicro,
                          Text(
                            S.current.getHelpFast,
                            style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      context.sizedBoxHeightExtraSmall,
                      Row(
                        children: [
                          SvgPicture.asset(
                            Assets.iconsIcTick,
                            width: 15,
                          ),
                          context.sizedBoxWidthMicro,
                          Text(S.current.expertsTrust,
                            style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      context.sizedBoxHeightSmall,
                      const ContactUsInfoWidget(),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: _dialogWidth / 2.5,
                  margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 32),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  decoration: const BoxDecoration(
                      color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            onPressed: () {},
                            icon: SvgPicture.asset(
                              Assets.iconsCancelIcon,
                              width: 20,
                            ),
                          )),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: S.current.haveUsContact,
                            style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: S.current.you,
                            style: context.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: context.colorScheme.primaryColor,
                                fontStyle: FontStyle.italic)),
                      ])),
                      context.sizedBoxHeightExtraSmall,
                      RoundedTextInputWidget(
                        hintText: '${S.current.contactName}*',
                        showFloatLabel: true,
                        textEditController: TextEditingController(),
                      ),
                      context.sizedBoxHeightExtraSmall,
                      RoundedTextInputWidget(
                        hintText: '${S.current.phoneNumber}*',
                        showFloatLabel: true,
                        textEditController: TextEditingController(),
                      ),
                      context.sizedBoxHeightExtraSmall,
                      RoundedDropDownList(
                          margin: EdgeInsets.zero,
                          selectedValue: serviceTypesList.first,
                          isExpanded: true,
                          hintText: '${S.current.support}*',
                          onChange: (p0) {},
                          items: serviceTypesList
                              .map((e) => DropdownMenuItem<String>(
                                  value: e,
                                  child: Text(
                                    e,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.copyWith(color: AppColors.black),
                                  )))
                              .toList()),
                      context.sizedBoxHeightExtraSmall,
                      RoundedDropDownList(
                          margin: EdgeInsets.zero,
                          selectedValue: timesList.first,
                          isExpanded: true,
                          hintText: '${S.current.timePreference}*',
                          onChange: (p0) {},
                          items: timesList
                              .map((e) => DropdownMenuItem<String>(
                                  value: e,
                                  child: Text(
                                    e,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.copyWith(color: AppColors.black),
                                  )))
                              .toList()),
                      context.sizedBoxHeightExtraSmall,
                      RoundedTextInputWidget(
                        showFloatLabel: true,
                        hintText: '${S.current.message}*',
                        maxLines: 7,
                        minLines: 7,
                        keyboardType: TextInputType.multiline,
                        textEditController: TextEditingController(),
                      ),
                      context.sizedBoxHeightSmall,
                      RoundedBtnWidget(
                        onTap: () {},
                        btnText: S.current.submit,
                        btnPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        btnMargin: const EdgeInsets.symmetric(horizontal: 40),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
