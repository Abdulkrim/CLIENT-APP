import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/auth/presentation/blocs/login_bloc.dart';
import 'package:merchant_dashboard/generated/assets.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/loading_widget.dart';
import 'package:merchant_dashboard/widgets/rounded_btn.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../../../core/localazation/service/analytics/capture_event.dart';
import '../../../../../core/utils/validations/validation.dart';
import '../../../../../core/utils/validations/validator.dart';

import '../../../../../utils/snack_alert/snack_alert.dart';
import '../register_congrats_dialog.dart';

class DesktopRegisterFormWidget extends StatefulWidget {
  const DesktopRegisterFormWidget({super.key, required this.onLoginFormTapped});

  final Function onLoginFormTapped;

  @override
  State<DesktopRegisterFormWidget> createState() => _DesktopRegisterFormWidgetState();
}

class _DesktopRegisterFormWidgetState extends State<DesktopRegisterFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _userPhone = TextEditingController();
  final TextEditingController _userEmail = TextEditingController();

  final _pageViewController = PageController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              S.current.signUp,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
          context.sizedBoxHeightExtraSmall,
          SizedBox(
            height: 250,
            child: PageView(
              controller: _pageViewController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                        controller: _userPhone,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        maxLength: 12,
                        decoration: InputDecoration(
                          counterText: "",
                          hintText: '971501231234',
                          hintStyle: context.textTheme.labelLarge?.copyWith(color: Colors.grey),
                          icon: SvgPicture.asset(Assets.iconsPhone),
                          prefixIcon: const Text("+"),
                          prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 10),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        validator: Validator.apply(context, [PhoneNumberValidation()])),
                    context.sizedBoxHeightSmall,
                    BlocConsumer<LoginBloc, LoginState>(
                      listener: (context, state) async {
                        if (state is RegisterMobileState && state.isSuccess) {
                          _pageViewController.animateToPage(1, duration: const Duration(milliseconds: 300), curve: Curves.linear);
                        } else if (state is RegisterMobileState && state.errorMessage != null) {
                          context.showCustomeAlert(state.errorMessage, SnackBarType.error);
                        }
                      },
                      builder: (context, state) => state is RegisterMobileState && state.isLoading
                          ? const LoadingWidget()
                          : RoundedBtnWidget(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<LoginBloc>().add(RegisterMobileRequestEvent(phone: '+${_userPhone.text.trim()}'));
                                }
                              },
                              btnText: S.current.next,
                              width: Get.width * 0.3,
                              height: 45,
                              btnTextStyle: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                            ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _userEmail,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      maxLength: 255,
                      decoration: InputDecoration(
                        counterText: "",
                        hintText: S.current.emailAddress,
                        hintStyle: context.textTheme.labelLarge?.copyWith(color: Colors.grey),
                        icon: SvgPicture.asset(Assets.iconsEmail),
                      ),
                      validator: Validator.apply(context, [EmailValidation()]),
                    ),
                    context.sizedBoxHeightSmall,
                    BlocConsumer<LoginBloc, LoginState>(
                      listener: (context, state) async {
                        if (state is RegisterEmailState && state.isSuccess) {
                          CaptureAnalyticsEvents.captureEvents(
                            eventName: 'SignUp',
                            logType: LogType.signup,
                            parameter: {'email': _userEmail.text, 'phone': _userPhone.text, 'isSuccess': 'true'},
                          );

                          Get.dialog(RegisterCongratsWidget(
                            onTap: () {
                              Get.back();
                              widget.onLoginFormTapped();
                            },
                          ));
                        } else if (state is RegisterEmailState && state.errorMessage != null) {
                          context.showCustomeAlert(state.errorMessage, SnackBarType.error);
                        }
                      },
                      builder: (context, state) => state is RegisterEmailState && state.isLoading
                          ? const LoadingWidget()
                          : RoundedBtnWidget(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<LoginBloc>().add(RegisterEmailRequestEvent(email: _userEmail.text.trim()));
                                }
                              },
                              btnText: S.current.signUp,
                              width: Get.width * 0.3,
                              height: 45,
                              btnTextStyle: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                            ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          context.sizedBoxHeightMicro,
          InkWell(
            onTap: () => widget.onLoginFormTapped(),
            child: RichText(
                text: TextSpan(children: [
              TextSpan(
                text: S.current.alreadyExisting,
                style: context.textTheme.titleMedium,
              ),
              TextSpan(
                text: S.current.login,
                style: context.textTheme.titleMedium?.copyWith(
                  color: context.colorScheme.primaryColor,
                ),
              ),
            ])),
          ),
        ],
      ),
    );
  }
}
