import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/utils/responsive_widgets/responsive_dialog_widget.dart';
import 'package:merchant_dashboard/widgets/scrollable_widget.dart';

import '../../../../generated/l10n.dart';
import '../../../../utils/snack_alert/snack_alert.dart';
import '../../../../widgets/item_hint_textfield_widget.dart';
import '../../../../widgets/loading_widget.dart';
import '../../../../widgets/rounded_btn.dart';
import '../../data/models/entity/table.dart' as ent;
import '../blocs/cubit/table_cubit.dart';

class TableDetailsWidget extends StatefulWidget {
  const TableDetailsWidget({super.key, this.table});

  final ent.Table? table;

  @override
  State<TableDetailsWidget> createState() => _TableDetailsWidgetState();
}

class _TableDetailsWidgetState extends State<TableDetailsWidget> {
  late final _tableNameController = TextEditingController(text: widget.table?.tableName);
  late final _tableNumberController = TextEditingController(text: widget.table?.tableNumber.toString());
  late final _tableCapacityController = TextEditingController(text: widget.table?.tableCapacity.toString());

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ResponsiveDialogWidget(
      height: 450,
      width: 350,
      title: (widget.table == null) ? S.current.addTable :S.current.editTable,
      child: ScrollableWidget(
        scrollViewPadding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ItemHintTextFieldWidget(
                  isRequired: true, textEditingController: _tableNameController, hintText: S.current.tableName),
              context.sizedBoxHeightExtraSmall,
              ItemHintTextFieldWidget(
                  isRequired: true,
                  textEditingController: _tableNumberController,
                  hintText: S.current.tableNumber,
                  keyboardType: TextInputType.number),
              context.sizedBoxHeightExtraSmall,
              ItemHintTextFieldWidget(
                  isRequired: true,
                  textEditingController: _tableCapacityController,
                  hintText: S.current.tableCapacity,
                  keyboardType: TextInputType.number),
              context.sizedBoxHeightSmall,
              BlocConsumer<TableCubit, TableState>(
                listener: (context, state) {
                  if (state is EditTableStates && state.successMessage.isNotEmpty) {
                    Get.back();
                    context.showCustomeAlert(state.successMessage, SnackBarType.success);
                  } else if (state is EditTableStates && state.errorMessage.isNotEmpty) {
                    context.showCustomeAlert(state.errorMessage, SnackBarType.error);
                  }
                },
                builder: (context, state) => (state is EditTableStates && state.isLoading)
                    ? const LoadingWidget()
                    : (widget.table != null)
                        ? Row(
                            children: [
                              Expanded(
                                child: RoundedBtnWidget(
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      context.read<TableCubit>().deleteTable(widget.table!.id);
                                    }
                                  },
                                  btnText: S.current.deleteTable,
                                  height: 35,
                                  width: 300,
                                  bgColor: Colors.white,
                                  btnTextColor: Colors.red,
                                  boxBorder: Border.all(color: Colors.red),
                                  btnTextStyle: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                child: RoundedBtnWidget(
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      context.read<TableCubit>().editTable(
                                          tableId: widget.table!.id,
                                          tableName: _tableNameController.text.trim(),
                                          tableNumber: _tableNumberController.text.trim(),
                                          tableCapacity: _tableCapacityController.text.trim());
                                    }
                                  },
                                  btnText: S.current.saveChanges,
                                  height: 35,
                                  width: 300,
                                  btnTextStyle: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          )
                        : Center(
                            child: RoundedBtnWidget(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<TableCubit>().addTable(
                                      tableName: _tableNameController.text.trim(),
                                      tableNumber: _tableNumberController.text.trim(),
                                      tableCapacity: _tableCapacityController.text.trim());
                                }
                              },
                              btnText: S.current.addTable,
                              height: 35,
                              width: 300,
                              btnTextStyle: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
              ),
              context.sizedBoxHeightSmall,
            ],
          ),
        ),
      ),
    );
  }
}
