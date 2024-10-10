import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/core/utils/validations/validator.dart';
import 'package:merchant_dashboard/feature/auth/presentation/blocs/login_bloc.dart';
import 'package:merchant_dashboard/generated/assets.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/utils/snack_alert/snack_alert.dart';
import 'package:merchant_dashboard/widgets/app_ink_well_widget.dart';
import 'package:merchant_dashboard/widgets/loading_widget.dart';
import 'package:merchant_dashboard/widgets/rounded_btn.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../../../core/localazation/service/analytics/capture_event.dart';
import '../../../../../core/utils/validations/validation.dart';
import '../../../../../routes/app_routes.dart';
import '../forget_password_screen.dart';

class DesktopLoginFormWidget extends StatefulWidget {
  const DesktopLoginFormWidget({
    super.key,
    required this.onRegisterFormTapped,
  });

  final Function onRegisterFormTapped;

  @override
  State<DesktopLoginFormWidget> createState() => _DesktopLoginFormWidgetState();
}

class _DesktopLoginFormWidgetState extends State<DesktopLoginFormWidget> {
  final TextEditingController _username = TextEditingController();

  final TextEditingController _password = TextEditingController();

  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.current.welcome,
          style: context.textTheme.titleLarge,
        ),
        context.sizedBoxHeightUltraSmall,
        TextFormField(
          maxLength: 255,
          autofillHints: const [AutofillHints.username],
          controller: _username,
          decoration: InputDecoration(
            counterText: "",
            hintText: S.current.userName,
            hintStyle: context.textTheme.labelLarge?.copyWith(color: Colors.grey),
            icon: SvgPicture.asset(Assets.iconsUserIcon),
          ),
        ),
        context.sizedBoxHeightUltraSmall,
        SizedBox(
          height: 100,
          child: TextFormField(
            maxLength: 200,
            controller: _password,
            autofillHints: const [AutofillHints.password],
            obscureText: _obscurePassword,
            validator: Validator.apply(context, [PasswordValidation()]),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              counterText: "",
              hintText: S.current.password,
              hintStyle: context.textTheme.labelLarge?.copyWith(color: Colors.grey),
              icon: SvgPicture.asset(Assets.iconsLock),
              suffixIcon: AppInkWell(
                  onTap: () => setState(() => _obscurePassword = !_obscurePassword),
                  child: Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: SvgPicture.asset(Assets.iconsEye),
                  )),
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Get.dialog(BlocProvider<LoginBloc>.value(
              value: BlocProvider.of<LoginBloc>(context),
              child: ForgetPasswordScreen(
                width: 400,
                height: 500,
              ),
            ));
          },
          child: Text(
            S.current.forgetPass,
            style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.primaryColorDark),
          ),
        ),
        context.sizedBoxHeightSmall,
        BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) async {
            if (state is LoginRequestState) {
              if (state.isSuccess) {
                CaptureAnalyticsEvents.captureEvents(
                    eventName: 'login',
                    parameter: {'username': _username.text, 'password': _password.text},
                    logType: LogType.login);

                Get.offAllNamed(AppRoutes.mainRoute);
              } else if (state.errorMessage != null) {
                context.showCustomeAlert(state.errorMessage, SnackBarType.error);
              }
            }
          },
          builder: (context, state) => state is LoginRequestState && state.isLoading
              ? const LoadingWidget()
              : RoundedBtnWidget(
                  onTap: () {
                    if (_username.text.trim().isNotEmpty && _password.text.trim().isNotEmpty) {
                      context.read<LoginBloc>().add(LoginRequestEvent(_username.text, _password.text));
                    } else {
                      context.showCustomeAlert(S.current.userNameAdPassRequired, SnackBarType.error);
                    }
                  },
                  btnText: S.current.login,
                  width: Get.width * 0.3,
                  height: 45,
                  btnTextStyle: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
        ),
        context.sizedBoxHeightExtraSmall,
        InkWell(
          onTap: () => widget.onRegisterFormTapped(),
          child: RichText(
              text: TextSpan(children: [
            TextSpan(
              text: S.current.dontHaveAccount,
              style: context.textTheme.titleMedium,
            ),
            TextSpan(
              text: S.current.signUpHere,
              style: context.textTheme.titleMedium?.copyWith(
                color: context.colorScheme.primaryColor,
              ),
            ),
          ])),
        ),
      ],
    );
  }
}
