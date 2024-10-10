import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:merchant_dashboard/feature/merchant_info/data/models/entity/merchant_information.dart';
import 'package:merchant_dashboard/feature/merchant_info/presentation/blocs/merchant_info_bloc.dart';
import 'package:merchant_dashboard/generated/assets.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/theme/theme_data.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/utils/translation/languages/tr.dart';
import 'package:merchant_dashboard/widgets/container_setting.dart';
import 'package:merchant_dashboard/widgets/item_hint_textfield_widget.dart';
import 'package:merchant_dashboard/widgets/loading_widget.dart';
import 'package:merchant_dashboard/widgets/rounded_btn.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../widgets/rounded_text_input.dart';

class DesktopMerchantInfoBodyWidget extends StatelessWidget {
  final MerchantInformation? merchantInformation;

  DesktopMerchantInfoBodyWidget({
    Key? key,
    required this.merchantInformation,
  }) : super(key: key);

  late final TextEditingController _nameController =
      TextEditingController(text: merchantInformation?.name);
  late final TextEditingController _contactNumController =
      TextEditingController(text: merchantInformation?.firstPhoneNumber);

  late final TextEditingController _facebookController =
      TextEditingController(text: merchantInformation?.facebookLink);
  late final TextEditingController _instagramController =
      TextEditingController(text: merchantInformation?.instagramLink);
  late final TextEditingController _emailController =
      TextEditingController(text: merchantInformation?.email);
  late final TextEditingController _twitterController =
      TextEditingController(text: merchantInformation?.twitter);
  late final TextEditingController _businessAddressController =
      TextEditingController(text: merchantInformation?.branchAddress);

  @override
  Widget build(BuildContext context) {
    // todo: fix this in the mobile mode
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        ContainerSetting(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  S.current.storeDetails,
                  style: context.textTheme.titleSmall
                      ?.copyWith(fontWeight: FontWeight.bold,color: AppColors.headerColor),
                ),
                context.sizedBoxHeightExtraSmall,
                Divider(),
                context.sizedBoxHeightExtraSmall,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ItemHintTextFieldWidget(
                        width: 70,
                          textEditingController: _nameController,
                          hintText: S.current.branchName,
                          isEnable: false),
                    ),


                    Expanded(
                      child: ItemHintTextFieldWidget(
                        width: 70,
                        hintText: S.current.contactNumber,
                        keyboardType: TextInputType.number,
                        prefixWidget: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Text('  +')],
                        ),
                        textEditingController: _contactNumController,
                        isRequired: true,
                      ),
                    ),
                    context.sizedBoxHeightExtraSmall,
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ItemHintTextFieldWidget(
                        width: 70,
                          textEditingController: _emailController,
                          hintText: S.current.email),
                    ),

                    Expanded(
                      child: ItemHintTextFieldWidget(
                        width: 70,
                        isRequired: true,
                        hintText: S.current.businessAddress,
                        textEditingController: _businessAddressController,

                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        context.sizedBoxWidthMicro,
        ContainerSetting(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.current.socialMediaLink,
                  style: context.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                context.sizedBoxHeightExtraSmall,
                Divider(),
                context.sizedBoxHeightExtraSmall,

                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                  ItemHintTextFieldWidget(
                      prefixWidget: const Icon(Icons.facebook,color: Colors.blue,),
                      width: 300,
                      textEditingController: _facebookController,
                      hintText: S.current.facebookLink),
                  context.sizedBoxHeightExtraSmall,
                  ItemHintTextFieldWidget(
                    prefixIconConstraints: const BoxConstraints(maxWidth: 25,maxHeight: 25),
                      width: 300,
                    prefixWidget: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: SvgPicture.asset(
                          Assets.iconsInstagram),
                    ),
                      textEditingController: _instagramController,
                      hintText: S.current.instagramLink),
                ],),
                context.sizedBoxHeightExtraSmall,
                ItemHintTextFieldWidget(
                    prefixIconConstraints: const BoxConstraints(maxWidth: 25,maxHeight: 25),
                    prefixWidget: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: SvgPicture.asset(Assets.iconsTwiter),
                    ),
                    textEditingController: _twitterController,
                    hintText: S.current.twitter)

              ],
            ),
          ),
        ),
        Center(
          child: BlocBuilder<MerchantInfoBloc, MerchantInfoState>(
            builder: (context, state) {
              return Visibility(
                visible: (state is UpdateMerchantInfoState ||
                    state is DeleteMerchantLogoState) &&
                    state.isLoading,
                replacement:  RoundedBtnWidget(
                  onTap: () {
                    context.read<MerchantInfoBloc>().add(UpdateMerchantInfoEvent(
                        firstPhoneNumber: '+${_contactNumController.text.trim()}',
                        branchAddress: _businessAddressController.text.trim(),
                        email: _emailController.text.trim(),
                        facebook: _facebookController.text.trim(),
                        instagram: _instagramController.text.trim(),
                        twitter: _twitterController.text.trim()));
                  },
                  btnText: S.current.save,
                  width: 300,
                  height: 40,
                  btnTextStyle: context.textTheme.titleSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                child: const LoadingWidget(),);
            },
          ),
        ),
      ],
    );
  }
}
