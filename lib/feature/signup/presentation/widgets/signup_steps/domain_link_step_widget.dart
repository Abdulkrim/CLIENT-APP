import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:merchant_dashboard/core/utils/validations/validation.dart';
import 'package:merchant_dashboard/core/utils/validations/validator.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../../core/utils/configuration.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../injection.dart';
import '../../../../../theme/theme_data.dart';
import '../../../../../widgets/rounded_text_input.dart';
import '../../blocs/sign_up_bloc.dart';

class DomainLinkStepWidget extends StatefulWidget {
  const DomainLinkStepWidget({super.key});

  @override
  State<DomainLinkStepWidget> createState() => _DomainLinkStepWidgetState();
}

class _DomainLinkStepWidgetState extends State<DomainLinkStepWidget> {
  final _debounce = Debouncer(delay: const Duration(milliseconds: 600));

  final _formKey = GlobalKey<FormState>();

  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _textController.text = context.read<SignUpBloc>().saveSignupStepsParameter.domainName ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          S.current.enterYourStoreLink,
          style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontSize: 28),
        ),
        context.sizedBoxHeightMicro,
        Text(
          S.current.domainLinkStepDescription,
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
                Text(S.current.storeLink,
                    style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
                context.sizedBoxHeightMicro,
                RoundedTextInputWidget(
                  maxLength: 63,
                  textEditController: _textController,
                  height: 200,
                  validator: Validator.apply(context, [DomainValidation()]),
                  hintText: S.current.enterYouStoreUrl,
                  onChange: (text) {
                    if (_formKey.currentState!.validate()) {
                      _debounce.call(() => context
                          .read<SignUpBloc>()
                          .add(ValidateBusinessDomain('$text.${getIt<Configuration>().branchUrl}')));
                    } else {
                      context.read<SignUpBloc>().add(const ValidateBusinessDomain.reset());

                      context.read<SignUpBloc>().saveSignupStepsParameter.domainName = null;
                    }
                  },
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('.${getIt<Configuration>().branchUrl} '),
                      SizedBox(
                        height: 30,
                        child: BlocConsumer<SignUpBloc, SignUpState>(
                          listener: (context, state) {
                            if (state is ValidateBusinessDomainState) {
                              context.read<SignUpBloc>().saveSignupStepsParameter.domainName =
                                  state.isSuccess ? _textController.text : null;
                            }
                          },
                          buildWhen: (previous, current) => current is ValidateBusinessDomainState,
                          builder: (context, state) => switch (state) {
                            (ValidateBusinessDomainState st) when st.isLoading =>
                              const CupertinoActivityIndicator(),
                            (ValidateBusinessDomainState st) when st.isSuccess => const Icon(
                                CupertinoIcons.check_mark_circled,
                                color: Colors.green,
                              ),
                            (ValidateBusinessDomainState st) when st.error != null => Tooltip(
                                message: st.error,
                                child: const Icon(
                                  Icons.cancel_outlined,
                                  color: Colors.red,
                                ),
                              ),
                            _ => const SizedBox(
                                width: 20,
                              ),
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
