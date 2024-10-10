import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:merchant_dashboard/feature/expense/data/models/entity/expense_type.dart';
import 'package:merchant_dashboard/feature/expense/data/models/entity/expenses_info.dart';
import 'package:merchant_dashboard/feature/expense/presentation/blocs/expense_cubit.dart';
import 'package:merchant_dashboard/feature/settings/data/models/entity/payment_type.dart';
import 'package:merchant_dashboard/generated/assets.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/utils/responsive_widgets/responsive_dialog_widget.dart';
import 'package:merchant_dashboard/utils/snack_alert/snack_alert.dart';
import 'package:merchant_dashboard/widgets/loading_widget.dart';
import 'package:merchant_dashboard/widgets/rounded_btn.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../../theme/theme_data.dart';
import '../../../../../widgets/rounded_dropdown_list.dart';
import '../../../../../widgets/rounded_text_input.dart';
import '../../../../../widgets/scrollable_widget.dart';
import '../add_expnse_type_dialog.dart';
import '../choose_file_widget.dart';

class DesktopAddExpenseWidget extends StatefulWidget {
  const DesktopAddExpenseWidget({super.key, this.expenseItem});

  final ExpenseItem? expenseItem;

  @override
  State<DesktopAddExpenseWidget> createState() =>
      DesktopAddExpenseWidgetState();
}

class DesktopAddExpenseWidgetState extends State<DesktopAddExpenseWidget> {
  final _formKey = GlobalKey<FormState>();
  // List<ExpenseType> _expenseTypes = [];
  List<PaymentType> _paymentTypes = [];

  PaymentType? _selectedPaymentType;
  ExpenseType? _selectedExpenseType;
  late final TextEditingController _dateTextController =
      TextEditingController(text: widget.expenseItem?.formattedDate ?? '');

  XFile? _selectedFile;

  late final _amountTextController =
      TextEditingController(text: widget.expenseItem?.amount.toString() ?? '');
  late final _noteTextController =
      TextEditingController(text: widget.expenseItem?.note ?? '');

  @override
  Widget build(BuildContext context) {
    /*  _expenseTypes = context.select<ExpenseCubit, List<ExpenseType>>((bloc) {
      _selectedExpenseType ??= bloc.expenseTypes.firstWhereOrNull((element) => element.id == widget.expenseItem?.expenseTypeId) ??
          bloc.expenseTypes.first;
      return bloc.expenseTypes;
    });*/

    _paymentTypes = context.select<ExpenseCubit, List<PaymentType>>((bloc) {
      _selectedPaymentType ??= bloc.paymentModes.firstWhereOrNull(
              (element) => element.id == widget.expenseItem?.paymentModeId) ??
          bloc.paymentModes.first;
      return bloc.paymentModes;
    });

    return ResponsiveDialogWidget(
      width: 700,
      height: 650,
      title: (widget.expenseItem != null)
          ? S.current.editExpense
          : S.current.addExpense,
      child: ScrollableWidget(
          scrollViewPadding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: BlocListener<ExpenseCubit, ExpenseState>(
              listener: (context, state) {
                if (state is AddExpenseTypesState &&
                    state.successMessage.isNotEmpty) {
                  setState(() => _selectedExpenseType =
                      context.read<ExpenseCubit>().expenseTypes.last);
                }
              },
              child: Column(
                children: [
                  (context.mediaQuerySize.width > 700)
                      ? Row(
                          children: [
                            Expanded(child: _expenseTypeWidget(context)),
                            context.sizedBoxWidthMicro,
                            Expanded(child: _paymentModeWidgett(context)),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _expenseTypeWidget(context),
                            _paymentModeWidgett(context),
                          ],
                        ),
                  context.sizedBoxHeightExtraSmall,
                  SizedBox(
                    height: 110,
                    child: Row(
                      children: [
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(S.current.expenseAmount,
                                style: context.textTheme.titleSmall
                                    ?.copyWith(fontWeight: FontWeight.bold)),
                            context.sizedBoxHeightMicro,
                            RoundedTextInputWidget(
                              hintText: S.current.enterTheAmountExpense,
                              textEditController: _amountTextController,
                              isRequired: true,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true, signed: true),
                            ),
                          ],
                        )),
                        context.sizedBoxWidthExtraSmall,
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(S.current.expenseDate,
                                style: context.textTheme.titleSmall
                                    ?.copyWith(fontWeight: FontWeight.bold)),
                            context.sizedBoxHeightMicro,
                            GestureDetector(
                                onTap: () {
                                  Get.defaultDialog(
                                    title: '',
                                    titlePadding: const EdgeInsets.all(0),
                                    content: SizedBox(
                                      height: 310,
                                      width: 400,
                                      child: SfDateRangePicker(
                                        headerStyle:
                                            const DateRangePickerHeaderStyle(
                                                backgroundColor:
                                                    Colors.transparent),
                                        showTodayButton: true,
                                        backgroundColor: Colors.transparent,
                                        showActionButtons: true,
                                        confirmText: S.current.select,
                                        maxDate: DateTime.now(),
                                        onSelectionChanged:
                                            (DateRangePickerSelectionChangedArgs
                                                args) {},
                                        selectionMode:
                                            DateRangePickerSelectionMode.single,
                                        onCancel: () => Get.back(),
                                        onSubmit: (p0) {
                                          _dateTextController.text =
                                              '${(p0 as DateTime).year}/${p0.month}/${p0.day}';
                                          // _selectedExpenseDate = dateTextContoller.text;
                                          Get.back();
                                        },
                                      ),
                                    ),
                                  );
                                },
                                child: RoundedTextInputWidget(
                                  hintText: '10/10/2023',
                                  isEnable: false,
                                  isRequired: true,
                                  textEditController: _dateTextController,
                                  suffixIcon: const Icon(
                                    Icons.calendar_month,
                                    size: 15,
                                  ),
                                )),
                            /*  RoundedSingleDatePickerWidget(
                            initalDate: widget.expenseItem?.formattedDate,
                            isRequired: true,
                            onDateSelected: (selectedDate) => _selectedExpenseDate = selectedDate,
                          ), */
                          ],
                        )),
                      ],
                    ),
                  ),
                  Text(S.current.uploadInvoice,
                      style: context.textTheme.titleSmall
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  context.sizedBoxHeightMicro,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ChooseFileWidget(
                      width: 350,
                      acceptableFileTypes: FileType.pdfAndImage,
                      onImageChanged: (file) {
                        _selectedFile = file;
                      },
                    ),
                  ),
                  context.sizedBoxHeightExtraSmall,
                  Text(S.current.notes,
                      style: context.textTheme.titleSmall
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  context.sizedBoxHeightMicro,
                  RoundedTextInputWidget(
                    hintText: S.current.enterNotesHere,
                    textEditController: _noteTextController,
                    contentPadding: const EdgeInsets.all(10),
                    minLines: 5,
                    maxLines: 5,
                    keyboardType: TextInputType.multiline,
                  ),
                  context.sizedBoxHeightSmall,
                  BlocConsumer<ExpenseCubit, ExpenseState>(
                      listener: (context, state) {
                        if (state is AddExpenseState &&
                            state.successMessage.isNotEmpty) {
                          Get.back();
                          context.showCustomeAlert(
                              state.successMessage, SnackBarType.success);
                        } else if (state is AddExpenseState &&
                            state.errorMessage.isNotEmpty) {
                          context.showCustomeAlert(
                              state.errorMessage, SnackBarType.error);
                        }
                      },
                      builder: (context, state) => (state is AddExpenseState &&
                              state.isLoading)
                          ? const LoadingWidget()
                          : Row(
                              children: [
                                Visibility(
                                  visible: widget.expenseItem != null,
                                  child: Expanded(
                                    flex: 2,
                                    child: RoundedBtnWidget(
                                      onTap: () => context
                                          .read<ExpenseCubit>()
                                          .deleteExpense(
                                              widget.expenseItem!.id),
                                      btnText: S.current.deleteExpense,
                                      height: 35,
                                      width: 300,
                                      bgColor: Colors.white,
                                      btnTextColor: Colors.red,
                                      boxBorder: Border.all(color: Colors.red),
                                      btnTextStyle: Theme.of(context)
                                          .textTheme
                                          .titleSmall
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: RoundedBtnWidget(
                                    width: 100,
                                    height: 35,
                                    onTap: () {
                                      if (_formKey.currentState!.validate()) {
                                        if (widget.expenseItem != null) {
                                          context
                                              .read<ExpenseCubit>()
                                              .editExpense(
                                                  expenseId:
                                                      widget.expenseItem!.id,
                                                  expenseTypeId:
                                                      _selectedExpenseType!.id,
                                                  paymentModeId:
                                                      _selectedPaymentType!.id,
                                                  amount: _amountTextController
                                                      .text
                                                      .trim(),
                                                  note: _noteTextController.text
                                                      .trim(),
                                                  date: _dateTextController.text
                                                      .trim(),
                                                  file: _selectedFile);
                                        } else {
                                          context.read<ExpenseCubit>().addExpense(
                                              expenseTypeId:
                                                  _selectedExpenseType!.id,
                                              paymentModeId:
                                                  _selectedPaymentType!.id,
                                              amount: _amountTextController.text
                                                  .trim(),
                                              note: _noteTextController.text
                                                  .trim(),
                                              date: _dateTextController.text
                                                  .trim(),
                                              file: _selectedFile);
                                        }
                                      }
                                    },
                                    btnText: S.current.save,
                                  ),
                                ),
                              ],
                            ))
                ],
              ),
            ),
          )),
    );
  }

  Column _paymentModeWidgett(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(S.current.selectPaymentMode,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(fontWeight: FontWeight.bold)),
        context.sizedBoxHeightMicro,
        RoundedDropDownList(
            margin: EdgeInsets.zero,
            validator: (p0) =>
                (p0.id == 0) ? S.current.selectPaymentMode : null,
            selectedValue: _selectedPaymentType,
            isExpanded: true,
            onChange: (p0) => _selectedPaymentType = p0,
            items: _paymentTypes
                .map((e) => DropdownMenuItem<PaymentType>(
                    value: e,
                    child: Text(
                      e.name,
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.copyWith(color: AppColors.black),
                    )))
                .toList()),
      ],
    );
  }

  Column _expenseTypeWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(S.current.typeOfExpense,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(fontWeight: FontWeight.bold)),
        context.sizedBoxHeightMicro,
        Row(
          children: [
            Expanded(
              child: RoundedDropDownList(
                  margin: EdgeInsets.zero,
                  validator: (p0) =>
                      (p0.id == 0) ? S.current.selectTheExpenseType : null,
                  selectedValue: _selectedExpenseType ??
                      context.read<ExpenseCubit>().expenseTypes.first,
                  isExpanded: true,
                  onChange: (p0) => _selectedExpenseType = p0,
                  items: context
                      .select((ExpenseCubit bloc) => bloc.expenseTypes)
                      .map((e) => DropdownMenuItem<ExpenseType>(
                          value: e,
                          child: Text(
                            e.name,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(color: AppColors.black),
                          )))
                      .toList()),
            ),
            IconButton(
              onPressed: () {
                Get.dialog(
                  BlocProvider.value(
                    value: BlocProvider.of<ExpenseCubit>(context),
                    child: AddExpenseTypeDialog(),
                  ),
                );
              },
              icon: SvgPicture.asset(
                Assets.iconsAddIcon,
                width: 25,
              ),
            )
          ],
        ),
      ],
    );
  }
}
