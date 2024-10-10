import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/region/presentation/widgets/country_flag_dropdown_widget.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../injection.dart';
import '../../../../../theme/theme_data.dart';
import '../../../../../widgets/rounded_text_input.dart';
import '../../../../main_screen/presentation/blocs/main_screen_bloc.dart';
import '../../blocs/sign_up_bloc.dart';

class PhoneNumberStepWidget extends StatefulWidget {
  const PhoneNumberStepWidget({super.key});

  @override
  State<PhoneNumberStepWidget> createState() => _PhoneNumberStepWidgetState();
}

class _PhoneNumberStepWidgetState extends State<PhoneNumberStepWidget> {
  late final _textController = TextEditingController(
      text: context.read<SignUpBloc>().saveSignupStepsParameter.whatsappNumber != null
          ? context.read<SignUpBloc>().saveSignupStepsParameter.whatsappNumber!
          : getIt<MainScreenBloc>().loggedInMerchantInfo?.withoutPrefixPhoneNumber);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) => context.read<SignUpBloc>().saveSignupStepsParameter.whatsappNumber = _textController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          S.current.getOrderWhatsappNumber,
          style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontSize: 28),
        ),
        context.sizedBoxHeightMicro,
        Text(
          S.current.whatsappNumberStepDescription,
          style: context.textTheme.bodyMedium?.copyWith(color: AppColors.gray),
        ),
        context.sizedBoxHeightSmall,
        SizedBox(
          width: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(S.current.whatsappNumber, style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
              context.sizedBoxHeightMicro,
              Row(
                children: [
                  Expanded(
                      child: CountryFlagDropdownWidget(
                    preCountrySelected: context.read<SignUpBloc>().saveSignupStepsParameter.countryId,
                  )),
                  context.sizedBoxWidthExtraSmall,
                  Expanded(
                    flex: 3,
                    child: RoundedTextInputWidget(
                      hintText: '050 123 4567',
                      keyboardType: TextInputType.number,
                      maxLength: 12,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      textEditController: _textController,
                      prefixWidget: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('   +'),
                        ],
                      ),
                      isRequired: true,
                      onChange: (text) => context.read<SignUpBloc>().saveSignupStepsParameter.whatsappNumber = text,
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
