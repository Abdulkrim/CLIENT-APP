import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:merchant_dashboard/core/utils/validations/validation.dart';
import 'package:merchant_dashboard/core/utils/validations/validator.dart';
import 'package:merchant_dashboard/feature/main_screen/presentation/blocs/main_screen_bloc.dart';
import 'package:merchant_dashboard/injection.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/rounded_text_input.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../theme/theme_data.dart';
import '../../blocs/sign_up_bloc.dart';

class BusinessNameStepWidget extends StatefulWidget {
  const BusinessNameStepWidget({super.key});

  @override
  State<BusinessNameStepWidget> createState() => _BusinessNameStepWidgetState();
}

class _BusinessNameStepWidgetState extends State<BusinessNameStepWidget> {
  final _debounce = Debouncer(delay: const Duration(milliseconds: 600));

  final _formKey = GlobalKey<FormState>();

  late final _textController = TextEditingController(
      text: context.read<SignUpBloc>().saveSignupStepsParameter.businessName ??
          getIt<MainScreenBloc>().loggedInMerchantInfo?.merchantName ??
          '');

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<SignUpBloc>().saveSignupStepsParameter.businessName = _textController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          S.current.whatsYourBusinessName,
          style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontSize: 28),
        ),
        context.sizedBoxHeightMicro,
        Text(
          S.current.businessNameStepDescription,
          style: context.textTheme.bodyMedium?.copyWith(color: AppColors.gray),
        ),
        context.sizedBoxHeightSmall,
        SizedBox(
          width: 350,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(S.current.yourBusinessName, style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
                context.sizedBoxHeightMicro,
                RoundedTextInputWidget(
                  hintText: S.current.enterYourBusinessName,
                  height: 90,
                  textEditController: _textController,
                  validator: Validator.apply(context, [BusinessNameValidation()]),
                  onChange: (text) {
                    if (_formKey.currentState!.validate()) {
                      _debounce.call(() => context.read<SignUpBloc>().add(ValidateBusinessName(text)));
                    } else {
                      context.read<SignUpBloc>().add(const ValidateBusinessName.reset());

                      context.read<SignUpBloc>().saveSignupStepsParameter.businessName = null;
                    }
                  },
                  suffixIcon: SizedBox(
                    height: 30,
                    child: BlocConsumer<SignUpBloc, SignUpState>(
                      listener: (context, state) {
                        if (state is ValidateBusinessNameState) {
                          context.read<SignUpBloc>().saveSignupStepsParameter.businessName =
                              state.isSuccess ? _textController.text : null;
                        }
                      },
                      buildWhen: (previous, current) => current is ValidateBusinessNameState,
                      builder: (context, state) => switch (state) {
                        (ValidateBusinessNameState st) when st.isLoading => const CupertinoActivityIndicator(),
                        (ValidateBusinessNameState st) when st.isSuccess => const Icon(
                            CupertinoIcons.check_mark_circled,
                            color: Colors.green,
                          ),
                        (ValidateBusinessNameState st) when st.error != null => Tooltip(
                            message: st.error,
                            child: const Icon(
                              Icons.cancel_outlined,
                              color: Colors.red,
                            ),
                          ),
                        _ => const SizedBox(),
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
