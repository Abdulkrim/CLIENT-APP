import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/auth/presentation/blocs/login_bloc.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/routes/app_routes.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/utils/responsive_widgets/responsive_dialog_widget.dart';
import 'package:merchant_dashboard/utils/snack_alert/snack_alert.dart';

import '../../../../../generated/assets.dart';
import '../../../../../widgets/loading_widget.dart';
import '../../../../../widgets/rounded_btn.dart';
import '../../../../../widgets/rounded_text_input.dart';
import '../../../../core/utils/validations/validation.dart';
import '../../../../core/utils/validations/validator.dart';
import '../../../../widgets/app_ink_well_widget.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key, this.width, this.height});

  final double? width, height;

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _emailController = TextEditingController();

  final _otpController = TextEditingController();

  final _newPasswordController = TextEditingController();

  final _pageController = PageController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return ResponsiveDialogWidget(
        title: S.current.forgetPass,
        width: widget.width,
        height: widget.height,
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
              Text(S.current.enterEmailToSendOtp,
                style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              context.sizedBoxHeightExtraSmall,
              SizedBox(
                height: 300,
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
                        BlocConsumer<LoginBloc, LoginState>(
                          listener: (context, state) {
                            if (state is ForgetPasswordState) {
                              if (state.isSuccess) {
                                _pageController.animateToPage(1,
                                    duration: const Duration(milliseconds: 600), curve: Curves.linear);
                              } else if (state.errorMessage != null) {
                                context.showCustomeAlert(state.errorMessage);
                              }
                            }
                          },
                          builder: (context, state) => state is ForgetPasswordState && state.isLoading
                              ? const LoadingWidget()
                              : RoundedBtnWidget(
                                  onTap: () {
                                    if (_emailController.text.isEmpty || !_emailController.text.isEmail) {
                                      context.showCustomeAlert(S.current.plzEnterValidEmail);
                                      return;
                                    }

                                    context
                                        .read<LoginBloc>()
                                        .add(ForgetPasswordEvent(email: _emailController.text.trim()));
                                  },
                                  btnText: S.current.sendChangePassRequest,
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

                        TextFormField(
                          maxLength: 200,
                          controller: _newPasswordController,
                          autofillHints: const [AutofillHints.password],
                          obscureText: _obscurePassword,
                          validator: Validator.apply(context, [PasswordValidation()]),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            counterText: "",
                            hintText: S.current.newPass,
                            hintStyle: context.textTheme.labelLarge?.copyWith(color: Colors.grey),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: const BorderSide(
                                color: Color(0xffeeeeee),
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: const BorderSide(
                                color: Color(0xffeeeeee),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: BorderSide(
                                color: context.colorScheme.primaryColor,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: const BorderSide(
                                color: Color(0xffeeeeee),
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: const BorderSide(
                                color: Colors.redAccent,
                              ),
                            ),
                            suffixIcon: AppInkWell(
                                onTap: () => setState(() => _obscurePassword = !_obscurePassword),
                                child: Padding(
                                  padding: const EdgeInsets.all(13.0),
                                  child: SvgPicture.asset(Assets.iconsEye),
                                )),
                          ),
                        ),
                        context.sizedBoxHeightExtraSmall,
                        BlocConsumer<LoginBloc, LoginState>(
                          listener: (context, state) {
                            if (state is ResetPasswordState) {
                              if (state.isSuccess) {
                                Get.offAllNamed(AppRoutes.loginRoute);
                                context.showCustomeAlert('Password has changed successfully!', SnackBarType.success);
                              } else if (state.errorMessage != null) {
                                context.showCustomeAlert(state.errorMessage, SnackBarType.error);
                              }
                            }
                          },
                          builder: (context, state) => state is ResetPasswordState && state.isLoading
                              ? const LoadingWidget()
                              : RoundedBtnWidget(
                                  onTap: () {
                                    if (_otpController.text.isNotEmpty &&
                                        _newPasswordController.text.isNotEmpty) {
                                      context.read<LoginBloc>().add(ResetPasswordEvent(
                                          code: _otpController.text.trim(),
                                          email: _emailController.text.trim(),
                                          newPassword: _newPasswordController.text.trim()));
                                    }
                                  },
                                  btnText: S.current.changePass,
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
