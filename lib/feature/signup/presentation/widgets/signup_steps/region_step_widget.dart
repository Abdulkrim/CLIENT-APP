import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/region/presentation/widgets/regions_dropdowns_widget.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../theme/theme_data.dart';
import '../../blocs/sign_up_bloc.dart';

class RegionStepWidget extends StatelessWidget {
  const RegionStepWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          S.current.selectCountryAndCity,
          style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontSize: 28),
        ),
        context.sizedBoxHeightMicro,
        Text(
          S.current.countryAndCityStepDescription,
          style: context.textTheme.bodyMedium?.copyWith(color: AppColors.gray),
        ),
        context.sizedBoxHeightSmall,
        RegionsDropDownWidget(
          isVertically: context.isPhone,
          preCountrySelected: context.read<SignUpBloc>().saveSignupStepsParameter.countryId,
          preSelectedCity: context.read<SignUpBloc>().saveSignupStepsParameter.cityId,
          onCityChanged: (selectedItem) {
            context.read<SignUpBloc>().saveSignupStepsParameter.countryId = selectedItem.countryId;
            context.read<SignUpBloc>().saveSignupStepsParameter.cityId = selectedItem.cityId;
          },
        )
      ],
    );
  }
}
