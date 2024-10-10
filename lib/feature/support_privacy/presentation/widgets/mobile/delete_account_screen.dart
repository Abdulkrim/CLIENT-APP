import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/routes/app_routes.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/utils/responsive_widgets/responsive_dialog_widget.dart';
import 'package:merchant_dashboard/utils/snack_alert/snack_alert.dart';

import '../../../../../generated/assets.dart';
import '../../../../../widgets/loading_widget.dart';
import '../../../../../widgets/rounded_btn.dart';
import '../../../../../widgets/rounded_text_input.dart';
import '../../blocs/cubit/privacy_cubit.dart';

class DeleteAccountScreen extends StatelessWidget {
  DeleteAccountScreen({super.key});

  final _emailController = TextEditingController();
  final _otpController = TextEditingController();

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return ResponsiveDialogWidget(
        title: S.current.deleteAccount,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Hero(
                tag: 'delete_account',
                child: SvgPicture.asset(
                  Assets.iconsDeleteUser,
                  width: 100,
                ),
              ),
              context.sizedBoxHeightSmall,
              Text(
                S.current.deleteAccountWill,
                style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              context.sizedBoxHeightExtraSmall,
              ListTile(
                visualDensity: const VisualDensity(vertical: -3), //
                leading: const Icon(
                  Icons.circle,
                  color: Colors.black,
                  size: 10,
                ),
                horizontalTitleGap: 0,
                title: Text(
                  S.current.deleteAllPersonalInfo,
                  style: context.textTheme.bodyMedium,
                ),
              ),
              ListTile(
                minVerticalPadding: 0,
                visualDensity: const VisualDensity(vertical: -3), // to compact
                leading: const Icon(
                  Icons.circle,
                  color: Colors.black,
                  size: 10,
                ),
                horizontalTitleGap: 0,
                title: Text(
                  S.current.deleteAllInfo,
                  style: context.textTheme.bodyMedium,
                ),
              ),
              ListTile(
                visualDensity: const VisualDensity(vertical: -3), //
                leading: const Icon(
                  Icons.circle,
                  color: Colors.black,
                  size: 10,
                ),
                horizontalTitleGap: 0,
                title: Text(
                  S.current.deleteAllBranchInfo,
                  style: context.textTheme.bodyMedium,
                ),
              ),
              context.sizedBoxHeightExtraSmall,
              Text(
                S.current.enterEmailToReceiveOtp,
                style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              context.sizedBoxHeightExtraSmall,
              SizedBox(
                height: 600,
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        RoundedTextInputWidget(
                          hintText: S.current.email,
                          textEditController: _emailController,
                        ),
                        context.sizedBoxHeightExtraSmall,
                        BlocConsumer<PrivacyCubit, PrivacyState>(
                          listener: (context, state) {
                            if (state is SendEmailState) {
                              if (state.isSuccess) {
                                _pageController.animateToPage(1,
                                    duration: const Duration(milliseconds: 600), curve: Curves.linear);
                              } else if (state.errorMessage != null) {
                                context.showCustomeAlert(state.errorMessage);
                              }
                            }
                          },
                          builder: (context, state) => state is SendEmailState && state.isLoading
                              ? const LoadingWidget()
                              : RoundedBtnWidget(
                                  onTap: () {
                                    if (_emailController.text.isEmpty || !_emailController.text.isEmail) {
                                      context.showCustomeAlert(S.current.plzEnterValidEmail);
                                      return;
                                    }

                                    context
                                        .read<PrivacyCubit>()
                                        .sendDeletionEmail(_emailController.text.trim());
                                  },
                                  btnText: S.current.sendRequestDeleteAccount,
                                  btnPadding: const EdgeInsets.symmetric(vertical: 10),
                                  btnMargin: const EdgeInsets.symmetric(horizontal: 30),
                                ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        RoundedTextInputWidget(
                          hintText: S.current.otpCode,
                          textEditController: _otpController,
                        ),
                        context.sizedBoxHeightExtraSmall,
                        BlocConsumer<PrivacyCubit, PrivacyState>(
                          listener: (context, state) {
                            if (state is VerifyEmailState) {
                              if (state.isSuccess) {
                                Get.offAllNamed(AppRoutes.loginRoute);
                              } else if (state.errorMessage != null) {
                                context.showCustomeAlert(state.errorMessage);
                              }
                            }
                          },
                          builder: (context, state) => state is VerifyEmailState && state.isLoading
                              ? const LoadingWidget()
                              : RoundedBtnWidget(
                                  onTap: () {
                                    if (_otpController.text.isNotEmpty) {
                                      context
                                          .read<PrivacyCubit>()
                                          .verifyDeletionOtp(_otpController.text.trim());
                                    }
                                  },
                                  btnText: S.current.submitCode,
                                  bgColor: Colors.red,
                                  btnMargin: const EdgeInsets.symmetric(horizontal: 30),
                                  btnPadding: const EdgeInsets.symmetric(vertical: 10),
                                ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              context.sizedBoxHeightDefault,
            ],
          ),
        ));
  }
}
