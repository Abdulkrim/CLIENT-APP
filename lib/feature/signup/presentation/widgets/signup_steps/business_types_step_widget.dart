import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/signup/data/models/entity/business_type.dart';
import 'package:merchant_dashboard/feature/signup/presentation/blocs/sign_up_bloc.dart';
import 'package:merchant_dashboard/theme/theme_data.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/app_ink_well_widget.dart';

import '../../../../../generated/l10n.dart';

class BusinessTypesStepWidget extends StatefulWidget {
  const BusinessTypesStepWidget({super.key});

  @override
  State<BusinessTypesStepWidget> createState() => _BusinessTypesStepWidgetState();
}

class _BusinessTypesStepWidgetState extends State<BusinessTypesStepWidget> {
  BusinessType? _selectedBusinessType;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() => _selectedBusinessType = context
        .read<SignUpBloc>()
        .businessTypes
        .firstWhereOrNull(
            (element) => element.id == context.read<SignUpBloc>().saveSignupStepsParameter.businessTypeId)));
  }

  @override
  Widget build(BuildContext context) {
    final businessTypes = context.select((SignUpBloc bloc) => bloc.businessTypes);

    return Column(
      children: [
        Text(
          S.current.letUsKnowAboutYourBusiness,
          style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontSize: 28),
        ),
        context.sizedBoxHeightMicro,
        Text(
          S.current.businessTypeStepDescription,
          style: context.textTheme.bodyMedium?.copyWith(color: AppColors.gray),
        ),
        context.sizedBoxHeightExtraSmall,
        Expanded(
          child: GridView.builder(
            itemCount: businessTypes.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: context.isPhone ? 3 : 4,
                mainAxisSpacing: 10,
                mainAxisExtent: 130,
                crossAxisSpacing: 10),
            itemBuilder: (context, index) => AppInkWell(
              onTap: () {
                setState(() => _selectedBusinessType = businessTypes[index]);
                context.read<SignUpBloc>().saveSignupStepsParameter.businessTypeId = businessTypes[index].id;
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: AppColors.lightGray,
                    borderRadius: BorderRadius.circular(10),
                    border: _selectedBusinessType?.id == businessTypes[index].id
                        ? Border.all(color: context.colorScheme.primaryColor)
                        : null),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: DecoratedBox(
                        decoration:
                            BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.gray)),
                        child: Padding(
                          padding: const EdgeInsets.all(3),
                          child: Icon(
                            Icons.circle,
                            color: _selectedBusinessType?.id == businessTypes[index].id
                                ? context.colorScheme.primaryColor
                                : Colors.transparent,
                            size: 8,
                          ),
                        ),
                      ),
                    ),
                    Expanded(child: Image.network(businessTypes[index].imageUrl)),
                    Text(businessTypes[index].name,
                        style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
