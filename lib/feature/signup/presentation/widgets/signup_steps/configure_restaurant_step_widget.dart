import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/rounded_btn.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../theme/theme_data.dart';
import '../../blocs/sign_up_bloc.dart';

class ConfigureRestaurantStepWidget extends StatefulWidget {
  const ConfigureRestaurantStepWidget({super.key});

  @override
  State<ConfigureRestaurantStepWidget> createState() => _ConfigureRestaurantStepWidgetState();
}

class _ConfigureRestaurantStepWidgetState extends State<ConfigureRestaurantStepWidget> {
  bool? canTakeOrder;

  bool? hasKitchen;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
          canTakeOrder = context.read<SignUpBloc>().saveSignupStepsParameter.takeOrder;
          hasKitchen = context.read<SignUpBloc>().saveSignupStepsParameter.hasKitchen;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          S.current.configureRestaurant,
          style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontSize: 28),
        ),
        context.sizedBoxHeightMicro,
        Text(
          S.current.configureRestaurantStepDescription,
          style: context.textTheme.bodyMedium?.copyWith(color: AppColors.gray),
        ),
        context.sizedBoxHeightLarge,
        SizedBox(
          width: 500,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(S.current.willWaitersBeTakingOrders,
                  textAlign: TextAlign.center, style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
              context.sizedBoxHeightMicro,
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RoundedBtnWidget(
                    onTap: () {
                      context.read<SignUpBloc>().saveSignupStepsParameter.takeOrder = true;
                      setState(() => canTakeOrder = true);
                    },
                    btnText: S.current.yes,
                    bgColor: (canTakeOrder ?? false) ? Colors.black : Colors.transparent,
                    btnTextColor: (canTakeOrder ?? false) ? Colors.white : Colors.black,
                    width: 75,
                    height: 35,
                    btnTextStyle: context.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold, color: Colors.black),
                    boxBorder: Border.all(color: AppColors.black),
                  ),
                  context.sizedBoxWidthMicro,
                  RoundedBtnWidget(
                    onTap: () {
                      context.read<SignUpBloc>().saveSignupStepsParameter.takeOrder = false;
                      setState(() => canTakeOrder = false);
                    },
                    btnText: S.current.no,
                    width: 75,
                    height: 35,
                    bgColor: !(canTakeOrder ?? true) ? Colors.black : Colors.transparent,
                    btnTextColor: !(canTakeOrder ?? true) ? Colors.white : Colors.black,
                    btnTextStyle: context.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold, color: Colors.black),
                    boxBorder: Border.all(color: AppColors.black),
                  ),
                  context.sizedBoxWidthMicro,
                ],
              ),
              context.sizedBoxHeightSmall,
              Text(S.current.willYouBePlacingScreenInTheKitchen,
                  textAlign: TextAlign.center, style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
              context.sizedBoxHeightMicro,
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RoundedBtnWidget(
                    onTap: () {
                      context.read<SignUpBloc>().saveSignupStepsParameter.hasKitchen = true;
                      setState(() => hasKitchen = true);
                    },
                    btnText: S.current.yes,
                    bgColor: (hasKitchen ?? false) ? Colors.black : Colors.transparent,
                    btnTextColor: (hasKitchen ?? false) ? Colors.white : Colors.black,
                    width: 75,
                    height: 35,
                    btnTextStyle: context.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
                    boxBorder: Border.all(color: AppColors.black),
                  ),
                  context.sizedBoxWidthMicro,
                  RoundedBtnWidget(
                    onTap: () {
                      context.read<SignUpBloc>().saveSignupStepsParameter.hasKitchen = false;
                      setState(() => hasKitchen = false);
                    },
                    btnText: S.current.no,
                    width: 75,
                    height: 35,
                    bgColor: !(hasKitchen ?? true) ? Colors.black : Colors.transparent,
                    btnTextColor: !(hasKitchen ?? true) ? Colors.white : Colors.black,
                    btnTextStyle: context.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold, color: Colors.black),
                    boxBorder: Border.all(color: AppColors.black),
                  ),
                  context.sizedBoxWidthMicro,
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
