import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../theme/theme_data.dart';
import '../../../../../widgets/rounded_btn.dart';
import '../../blocs/sign_up_bloc.dart';

class ConfigureDemoDataStepWidget extends StatefulWidget {
  const ConfigureDemoDataStepWidget({super.key});

  @override
  State<ConfigureDemoDataStepWidget> createState() => _ConfigureDemoDataStepWidgetState();
}

class _ConfigureDemoDataStepWidgetState extends State<ConfigureDemoDataStepWidget> {
  bool? needDemo;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
        (_) => setState(() => needDemo = context.read<SignUpBloc>().saveSignupStepsParameter.needDemo));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          S.current.includeDemoData,
          style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontSize: 28),
        ),
        context.sizedBoxHeightMicro,
        Text(
          S.current.includeDemoDataStepDescription,
          style: context.textTheme.bodyMedium?.copyWith(color: AppColors.gray),
        ),
        context.sizedBoxHeightLarge,
        RoundedBtnWidget(
          onTap: () {
            context.read<SignUpBloc>().saveSignupStepsParameter.needDemo = true;
            setState(() => needDemo = true);
          },
          btnText: S.current.doYouNeedDemoData,
          height: 80,
          width: 450,
          bgColor: (needDemo ?? false) ? Colors.black : Colors.transparent,
          btnTextColor: (needDemo ?? false) ? Colors.white : Colors.black,
          btnTextStyle: (context.isPhone ? context.textTheme.bodySmall : context.textTheme.bodyMedium)
              ?.copyWith(fontWeight: FontWeight.bold, color: Colors.black),
          boxBorder: Border.all(color: AppColors.black),
        ),
        context.sizedBoxHeightSmall,
        RoundedBtnWidget(
          onTap: () {
            context.read<SignUpBloc>().saveSignupStepsParameter.needDemo = false;

            setState(() => needDemo = false);
          },
          btnText: S.current.noICanHandleIt,
          height: 80,
          width: 450,
          bgColor: !(needDemo ?? true) ? Colors.black : Colors.transparent,
          btnTextColor: !(needDemo ?? true) ? Colors.white : Colors.black,
          textAlign: TextAlign.center,
          btnTextStyle:
              context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: Colors.black),
          boxBorder: Border.all(color: AppColors.black),
        ),
      ],
    );
  }
}
