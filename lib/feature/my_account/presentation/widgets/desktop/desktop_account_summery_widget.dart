import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/core/constants/defaults.dart';
import 'package:merchant_dashboard/feature/my_account/data/models/entity/account_details.dart';
import 'package:merchant_dashboard/feature/my_account/presentation/blocs/my_account_bloc.dart';
import 'package:merchant_dashboard/feature/my_account/presentation/widgets/desktop/desktop_edit_dialog.dart';
import 'package:merchant_dashboard/generated/assets.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/loading_widget.dart';
import 'package:merchant_dashboard/widgets/rounded_btn.dart';

import '../../../../../theme/theme_data.dart';

class DesktopAccountSummeryWidget extends StatelessWidget {
  final AccountDetails? accountDetails;

  const DesktopAccountSummeryWidget({
    Key? key,
    this.accountDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Account Details',
                style:
                    context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              context.sizedBoxHeightExtraSmall,
              Container(
                constraints: const BoxConstraints(maxWidth: 500),
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: AppColors.lightGray,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: hideForThisV,
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Plan',
                                  textAlign: TextAlign.start,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(color: Colors.grey),
                                ),
                                context.sizedBoxHeightMicro,
                                Text(
                                  'Free Account(30 Days Remaining)',
                                  style: context.textTheme.titleSmall,
                                ),
                              ],
                            ),
                          ),
                          RoundedBtnWidget(
                            onTap: () {},
                            btnIcon: SvgPicture.asset(Assets.iconsUserIcon, color: Colors.white),
                            btnText: "Upgrade Plan",
                            width: 120,
                            height: 35,
                            btnTextStyle: context.textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ),
                    context.sizedBoxHeightExtraSmall,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Business Name',
                          textAlign: TextAlign.start,
                          style:
                              context.textTheme.titleMedium?.copyWith(color: Colors.grey),
                        ),
                        Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Text(
                                accountDetails?.businessName ?? '',
                                style: context.textTheme.titleSmall,
                              ),
                            ),
                            Visibility(
                              visible: hideForThisV,
                              child: TextButton(
                                onPressed: () => Get.dialog(BlocProvider.value(
                                  value: BlocProvider.of<MyAccountBloc>(context),
                                  child: DesktopEditDialog(
                                    dialogTitle: 'Business Name',
                                    selectedFieldKey: Defaults.businessNameKey,
                                    selectedFieldValue: accountDetails?.businessName ?? '',
                                  ),
                                )),
                                child: Text(
                                  'Edit',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(color: context.colorScheme.primaryColor),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    context.sizedBoxHeightExtraSmall,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Business Address',
                          textAlign: TextAlign.start,
                          style:
                              context.textTheme.titleMedium?.copyWith(color: Colors.grey),
                        ),
                        Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Text(
                                accountDetails?.businessAddress ?? '',
                                style: context.textTheme.titleSmall,
                              ),
                            ),
                            Visibility(
                              visible: hideForThisV,
                              child: TextButton(
                                onPressed: () => Get.dialog(BlocProvider.value(
                                  value: BlocProvider.of<MyAccountBloc>(context),
                                  child: DesktopEditDialog(
                                    dialogTitle: 'Business Address',
                                    selectedFieldKey: Defaults.businessAddressKey,
                                    selectedFieldValue: accountDetails?.businessAddress ?? '',
                                  ),
                                )),
                                child: Text(
                                  'Edit',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(color: context.colorScheme.primaryColor),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    context.sizedBoxHeightExtraSmall,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Country',
                          textAlign: TextAlign.start,
                          style:
                              context.textTheme.titleMedium?.copyWith(color: Colors.grey),
                        ),
                        context.sizedBoxHeightMicro,
                        Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Text(
                                accountDetails?.country ?? '',
                                style: context.textTheme.titleSmall,
                              ),
                            ),
                            Visibility(
                              visible: hideForThisV,
                              child: TextButton(
                                onPressed: () => Get.dialog(BlocProvider.value(
                                  value: BlocProvider.of<MyAccountBloc>(context),
                                  child: DesktopEditDialog(
                                    dialogTitle: 'Country',
                                    selectedFieldKey: '',
                                    selectedFieldValue: accountDetails?.country ?? '',
                                  ),
                                )),
                                child: Text(
                                  'Edit',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(color: context.colorScheme.primaryColor),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              context.sizedBoxHeightSmall,
              Text(
                'Profile',
                style:
                    context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              context.sizedBoxHeightExtraSmall,
              Container(
                constraints: const BoxConstraints(maxWidth: 500),
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: AppColors.lightGray,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Contact Name',
                          textAlign: TextAlign.start,
                          style:
                              context.textTheme.titleMedium?.copyWith(color: Colors.grey),
                        ),
                        Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Text(
                                accountDetails?.contactName ?? '',
                                style: context.textTheme.titleSmall,
                              ),
                            ),
                            Visibility(
                              visible: hideForThisV,
                              child: TextButton(
                                onPressed: () => Get.dialog(BlocProvider.value(
                                  value: BlocProvider.of<MyAccountBloc>(context),
                                  child: DesktopEditDialog(
                                    dialogTitle: 'Contact Name',
                                    selectedFieldKey: Defaults.contactNameKey,
                                    selectedFieldValue: accountDetails?.contactName ?? '',
                                  ),
                                )),
                                child: Text(
                                  'Edit',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(color: context.colorScheme.primaryColor),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    context.sizedBoxHeightExtraSmall,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email Address',
                          textAlign: TextAlign.start,
                          style:
                              context.textTheme.titleMedium?.copyWith(color: Colors.grey),
                        ),
                        Text(
                          accountDetails?.emailAddress ?? '',
                          style: context.textTheme.titleSmall,
                        ),
                      ],
                    ),
                    context.sizedBoxHeightExtraSmall,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Phone Number',
                          textAlign: TextAlign.start,
                          style:
                              context.textTheme.titleMedium?.copyWith(color: Colors.grey),
                        ),
                        Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Text(
                                accountDetails?.phoneNumber ?? '',
                                style: context.textTheme.titleSmall,
                              ),
                            ),
                            Visibility(
                              visible: hideForThisV,
                              child: TextButton(
                                onPressed: () => Get.dialog(BlocProvider.value(
                                  value: BlocProvider.of<MyAccountBloc>(context),
                                  child: DesktopEditDialog(
                                    dialogTitle: 'Phone Number',
                                    selectedFieldKey: Defaults.phoneNumberKey,
                                    selectedFieldValue: accountDetails?.phoneNumber ?? '',
                                  ),
                                )),
                                child: Text(
                                  'Edit',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(color: context.colorScheme.primaryColor),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Center(
          child: BlocBuilder<MyAccountBloc, MyAccountState>(
            builder: (context, state) {
              return Visibility(
                  visible: state is UpdateAccountDetailsLoadingState, child: const LoadingWidget());
            },
          ),
        ),
      ],
    );
  }
}
