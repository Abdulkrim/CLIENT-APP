import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
// import 'package:merchant_dashboard/feature/device/presentation/blocs/device_cubit.dart';

import 'package:merchant_dashboard/feature/main_screen/presentation/blocs/menu_drawer/menu_drawer_cubit.dart';
import 'package:merchant_dashboard/feature/settings/presentation/widgets/branch_parameters_options.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/container_setting.dart';
import 'package:merchant_dashboard/widgets/loading_widget.dart';
import 'package:merchant_dashboard/widgets/rounded_btn.dart';
import 'package:merchant_dashboard/widgets/rounded_text_input.dart';

import '../../../../theme/theme_data.dart';
import '../../../../utils/snack_alert/snack_alert.dart';
import '../../../../widgets/app_status_toggle_widget.dart';
import '../../../../widgets/scrollable_widget.dart';

import '../blocs/settings_bloc.dart';
import 'discount_settings_widget.dart';

class ParameterSettingsScreen extends StatefulWidget {
  const ParameterSettingsScreen({Key? key}) : super(key: key);

  @override
  State<ParameterSettingsScreen> createState() => _ParameterSettingsScreenState();
}

class _ParameterSettingsScreenState extends State<ParameterSettingsScreen> {
  final _param1Contorller = TextEditingController();
  final _param3Contorller = TextEditingController();
  final _param2Contorller = TextEditingController();
  bool _isParam1Enabled = false;
  bool _isParam2Enabled = false;
  bool _isParam3Enabled = false;

  @override
  void initState() {
    super.initState();

    context.read<SettingsBloc>().add(GetOptionalParameters());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingsBloc, SettingsState>(
      listener: (context, state) {
        switch (state) {
          case SaveParametersStates() when state.error != null:
            context.showCustomeAlert(state.error!, SnackBarType.error);
          case SaveParametersStates() when state.isSuccess:
            context.showCustomeAlert('Your changes updated successfully!', SnackBarType.success);
        }
      },
      child: ScrollableWidget(
        scrollViewPadding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.watch<MenuDrawerCubit>().selectedPageContent.text,
              style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            Wrap(
              runSpacing: 10,
              spacing: 10,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 500),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 12,
                      ),

                      ///customer Address
                      BlocBuilder<SettingsBloc, SettingsState>(
                        buildWhen: (previous, current) => current is GetParamsStates,
                        builder: (context, state) {
                          return (state is GetParamsStates && state.isSuccess)
                              ? ContainerSetting(
                                  child: ParameterToggleOptionWidget(
                                    flag: context.select((SettingsBloc bloc) => bloc.isAddressRequired.value),
                                    title: S.current.customerAddressRequirement,
                                    subTitle: S.current.toggleCustomerAddress,
                                    onToggleChanged: (flag) {
                                      context.read<SettingsBloc>().add(UpdateOptionalParameters.onToggleChange(
                                          [(id: context.read<SettingsBloc>().isAddressRequired.id, value: flag.toString())]));
                                    },

                                  ),
                                )
                              : const SizedBox();
                        },
                      ),

                      SizedBox(
                        height: 12,
                      ),

                      const DiscountSettingsWidget(),

                      SizedBox(
                        height: 12,
                      ),
                      const BranchParametersOptions(),

                      // Divider(
                      //   color: AppColors.transparentGrayColor,
                      //   thickness: .5,
                      // ),
                      // context.sizedBoxHeightSmall,
                      // const NotificationsListWidget()
                    ],
                  ),
                ),

                ///params
                Column(
                  children: [
                    const SizedBox(height: 12),
                    BlocConsumer<SettingsBloc, SettingsState>(
                      listener: (context, state) {
                        if (state is GetParamsStates && state.isSuccess) {
                          _isParam1Enabled = context.read<SettingsBloc>().isParam1Enabled.value;
                          _isParam2Enabled = context.read<SettingsBloc>().isParam2Enabled.value;
                          _isParam3Enabled = context.read<SettingsBloc>().isParam3Enabled.value;

                          _param1Contorller.text = context.read<SettingsBloc>().param1Value.value;
                          _param2Contorller.text = context.read<SettingsBloc>().param2Value.value;
                          _param3Contorller.text = context.read<SettingsBloc>().param3Value.value;
                        }
                        if (state is UpdateOptionalParamsState) {
                          if (state.error != null) {
                            context.showCustomeAlert(state.error, SnackBarType.error);
                          } else if (state.isSuccess) {
                            context.showCustomeAlert(S.current.updateOptionalParamsSuccessfully, SnackBarType.error);
                          }
                        }
                      },
                      buildWhen: (previous, current) => current is GetParamsStates || current is UpdateOptionalParamsState,
                      builder: (context, state) {
                        return ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 450),
                          child: ContainerSetting(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Optional Parameters',
                                style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              context.sizedBoxHeightMicro,
                              Text(
                                S.current.optionalMsg,
                                style: context.textTheme.titleSmall?.copyWith(color: AppColors.gray),
                              ),
                              context.sizedBoxHeightMicro,

                              ///param1
                              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(S.current.param1,
                                        style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                                    AppSwitchToggle(
                                      scale: 0.7,
                                      currentStatus: _isParam1Enabled,
                                      label: '',
                                      onStatusChanged: (bool status) => setState(() => _isParam1Enabled = status),
                                    ),
                                  ],
                                ),
                                RoundedTextInputWidget(
                                  width: 300,
                                  textEditController: _param1Contorller,
                                  hintText: S.current.param1,
                                ),
                              ]),
                              context.sizedBoxHeightMicro,

                              ///param2
                              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(S.current.param2,
                                        style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                                    AppSwitchToggle(
                                      scale: 0.7,
                                      currentStatus: _isParam2Enabled,
                                      label: '',
                                      onStatusChanged: (bool status) => setState(() => _isParam2Enabled = status),
                                    ),
                                  ],
                                ),
                                RoundedTextInputWidget(
                                  width: 300,
                                  textEditController: _param2Contorller,
                                  hintText: S.current.param2,
                                ),
                              ]),
                              context.sizedBoxHeightMicro,

                              ///param3
                              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(S.current.param3,
                                        style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                                    AppSwitchToggle(
                                      scale: 0.7,
                                      currentStatus: _isParam3Enabled,
                                      label: '',
                                      onStatusChanged: (bool status) => setState(() => _isParam3Enabled = status),
                                    ),
                                  ],
                                ),
                                RoundedTextInputWidget(
                                  width: 300,
                                  textEditController: _param3Contorller,
                                  hintText: S.current.param3,
                                ),
                              ]),
                              context.sizedBoxHeightSmall,
                              Center(
                                child: (state is UpdateOptionalParamsState && state.isLoading)
                                    ? const LoadingWidget()
                                    : RoundedBtnWidget(
                                        onTap: () {
                                          context.read<SettingsBloc>().add(UpdateOptionalParameters([
                                                (
                                                  id: context.read<SettingsBloc>().isParam1Enabled.id,
                                                  value: _isParam1Enabled.toString()
                                                ),
                                                (
                                                  id: context.read<SettingsBloc>().isParam2Enabled.id,
                                                  value: _isParam2Enabled.toString()
                                                ),
                                                (
                                                  id: context.read<SettingsBloc>().isParam3Enabled.id,
                                                  value: _isParam3Enabled.toString()
                                                ),
                                                (
                                                  id: context.read<SettingsBloc>().param1Value.id,
                                                  value: _param1Contorller.text.trim()
                                                ),
                                                (
                                                  id: context.read<SettingsBloc>().param2Value.id,
                                                  value: _param2Contorller.text.trim()
                                                ),
                                                (
                                                  id: context.read<SettingsBloc>().param3Value.id,
                                                  value: _param3Contorller.text.trim()
                                                ),
                                              ]));
                                        },
                                        btnPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                                        width: 200,
                                        btnMargin: const EdgeInsets.only(right: 24),
                                        btnText: S.current.save,
                                      ),
                              ),
                            ],
                          )),
                        );
                      },
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ParameterToggleOptionWidget extends StatefulWidget {
  const ParameterToggleOptionWidget(
      {required this.flag, super.key, required this.title, required this.subTitle, required this.onToggleChanged});

  final String title;
  final String subTitle;

  // final String tooltipText;
  final bool flag;
  final Function(bool flag) onToggleChanged;

  @override
  State<ParameterToggleOptionWidget> createState() => _ParameterToggleOptionWidgetState();
}

class _ParameterToggleOptionWidgetState extends State<ParameterToggleOptionWidget> {
  late bool toggle = widget.flag;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: context.textTheme.titleSmall?.copyWith(color: AppColors.headerColor, fontWeight: FontWeight.bold),
              ),
              Text(
                widget.subTitle,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.titleSmall?.copyWith(color: AppColors.gray),
              ),
            ],
          ),
        ),
        AppSwitchToggle(
          currentStatus: toggle,
          onStatusChanged: (status) {
            setState(() {
              toggle = status;
            });
            widget.onToggleChanged(status);
          },
          scale: .7,
        )
      ],
    );
  }
}
