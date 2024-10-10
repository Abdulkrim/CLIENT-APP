import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchant_dashboard/feature/merchant_info/data/models/entity/merchant_information.dart';
import 'package:merchant_dashboard/feature/merchant_info/presentation/blocs/merchant_info_bloc.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/item_hint_textfield_widget.dart';
import 'package:merchant_dashboard/widgets/loading_widget.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/widgets/rounded_btn.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../widgets/rounded_text_input.dart';

class MobileMerchantInfoBodyWidget extends StatelessWidget {
  final MerchantInformation? merchantInformation;

  MobileMerchantInfoBodyWidget({
    Key? key,
    required this.merchantInformation,
  }) : super(key: key);

  late final TextEditingController _nameController = TextEditingController(text: merchantInformation?.name);
  late final TextEditingController _contactNumController =
      TextEditingController(text: merchantInformation?.firstPhoneNumber);
  late final TextEditingController _facebookController =
      TextEditingController(text: merchantInformation?.facebookLink);
  late final TextEditingController _instagramController =
      TextEditingController(text: merchantInformation?.instagramLink);
  late final TextEditingController _whatsappController =
      TextEditingController(text: merchantInformation?.whatsapp);
  late final TextEditingController _emailController = TextEditingController(text: merchantInformation?.email);
  late final TextEditingController _descriptionController =
      TextEditingController(text: merchantInformation?.branchDescription);
  late final TextEditingController _businessAddressController =
      TextEditingController(text: merchantInformation?.branchAddress);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            context.sizedBoxHeightExtraSmall,
            TextButton(
                onPressed: () async => await launchUrl(
                    Uri.parse('https://${merchantInformation?.domainAddress}'),
                    webOnlyWindowName: '_blank'),
                child: Text('${merchantInformation?.domainAddress} 🔗')),
            context.sizedBoxHeightExtraSmall,
            ItemHintTextFieldWidget(
                textEditingController: _nameController, hintText: S.current.storeInfo, isEnable: false),
            context.sizedBoxHeightExtraSmall,
            ItemHintTextFieldWidget(
                textEditingController: _contactNumController, hintText: S.current.contactNumber),
            context.sizedBoxHeightExtraSmall,
            ItemHintTextFieldWidget(textEditingController: _emailController, hintText: S.current.email),
            context.sizedBoxHeightExtraSmall,
            ItemHintTextFieldWidget(
                textEditingController: _facebookController, hintText: S.current.facebookLink),
            context.sizedBoxHeightExtraSmall,
            ItemHintTextFieldWidget(
                textEditingController: _instagramController, hintText: S.current.instagramLink),
            context.sizedBoxHeightExtraSmall,
            ItemHintTextFieldWidget(textEditingController: _whatsappController, hintText: S.current.whatsapp),
            context.sizedBoxHeightExtraSmall,
            ItemHintTextFieldWidget(
                textEditingController: _descriptionController, hintText: S.current.branchDesc),
            context.sizedBoxHeightExtraSmall,
            RoundedTextInputWidget(
              isRequired: true,
              hintText: S.current.businessAddress,
              textEditController: _businessAddressController,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              minLines: 4,
              maxLines: 4,
            ),
            context.sizedBoxHeightExtraSmall,
            RoundedBtnWidget(
              onTap: () {
                /*  context.read<MerchantInfoBloc>().add(UpdateMerchantInfoEvent(
                    firstPhoneNumber: _contactNumController.text.trim(),
                    email: _emailController.text.trim(),
                    branchAddress: _businessAddressController.text.trim(),
                    branchDescription: _descriptionController.text.trim(),
                    facebook: _facebookController.text.trim(),
                    instagram: _instagramController.text.trim(),
                    twitter: _twe.text.trim())); */
              },
              btnText: S.current.save,
              width: 300,
              height: 40,
              btnTextStyle: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Center(
          child: BlocBuilder<MerchantInfoBloc, MerchantInfoState>(
            builder: (context, state) {
              return Visibility(
                  visible: state is UpdateMerchantInfoState && state.isLoading, child: const LoadingWidget());
            },
          ),
        ),
      ],
    );
  }
}
