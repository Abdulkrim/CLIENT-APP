import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/settings/presentation/widgets/add_payment_mode_dialog.dart';
import 'package:merchant_dashboard/theme/theme_data.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/container_setting.dart';
import 'package:merchant_dashboard/widgets/payment_mode_select_widget.dart';

import '../../../../generated/l10n.dart';
import '../../data/models/entity/payment_type.dart';
import '../blocs/settings_bloc.dart';

class ManagePaymentModesWidget extends StatefulWidget {
  const ManagePaymentModesWidget({super.key, required this.onPaymentsChanged});

  final Function(List<int> selectedPayments) onPaymentsChanged;

  @override
  State<ManagePaymentModesWidget> createState() => _ManagePaymentModesWidgetState();
}

class _ManagePaymentModesWidgetState extends State<ManagePaymentModesWidget> {
  late List<int> _selectedPayments = [];

  @override
  void initState() {
    super.initState();
    context.read<SettingsBloc>().add(const GetAllPaymentTypes());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingsBloc, SettingsState>(
      listener: (context, state) {
        if (state is GetPaymentSettingsState) {
          _selectedPayments = state.parameters?.payment.map((e) => e.id).toList() ?? [];

          setState(() {});
        } else if (state is GetPaymentTypesStates && state.isSuccess) {
          if (_selectedPayments.isEmpty) {
            _selectedPayments = context.read<SettingsBloc>().paymentTypes.where((e) => e.isDefault).map((e) => e.id).toList();


          }       widget.onPaymentsChanged(_selectedPayments);
          setState(() {});
        }
      },
      child: ContainerSetting(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(crossAxisAlignment:CrossAxisAlignment.start ,children: [
            Text(S.current.payment, style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold,color: AppColors.headerColor)),
            context.sizedBoxHeightMicro,
            Text(S.current.selectPaymentMode, style: context.textTheme.titleSmall?.copyWith(color: AppColors.gray)),

            context.sizedBoxHeightExtraSmall,

            Wrap(
              spacing: 15,
              runSpacing: 15,
              children: context
                  .select<SettingsBloc, List<PaymentType>>((value) => value.paymentTypes)
                  .map(
                    (PaymentType e) => PaymentModeSelectWidget(
                  type: e,
                  isSelected: _selectedPayments.contains(e.id),
                  onStatusChanged: () {
                    setState(() => _selectedPayments.contains(e.id) ? _selectedPayments.remove(e.id) : _selectedPayments.add(e.id));
                    widget.onPaymentsChanged(_selectedPayments);
                  },

                ),
              )
                  .toList(),),

            context.sizedBoxHeightExtraSmall,

            TextButton.icon(
              style: TextButton.styleFrom(overlayColor:  context.colorScheme.primaryColor,padding: EdgeInsets.zero),
              onPressed: () => Get.dialog(BlocProvider.value(
                value: BlocProvider.of<SettingsBloc>(context),
                child: const AddPaymentModeDialog(),
              )),
              icon:   const Icon(Icons.add_rounded,color: Colors.black,),
              label: Text(S.current.addPaymentType,style: const TextStyle(color: Colors.black),),)
          ]),
        ),
      ),
    );
  }
}
