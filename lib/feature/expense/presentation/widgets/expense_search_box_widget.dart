import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/widgets/rounded_btn.dart';

import '../../../../widgets/rounded_text_input.dart';
import '../../data/models/entity/expense_amount.dart';
import '../blocs/expense_cubit.dart';

class ExpenseSearchBoxWidget extends StatelessWidget {
  const ExpenseSearchBoxWidget({super.key, required this.expenseAmounts});

  final List<ExpenseAmount> expenseAmounts;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => RawAutocomplete<ExpenseAmount>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text.isNotEmpty && textEditingValue.text.isNum) {
            return expenseAmounts.where((option) {
              return option.amount.toLowerCase().contains(textEditingValue.text.toLowerCase());
            });
          }
          return [];
        },
        onSelected: (option) {
          context.read<ExpenseCubit>().getExpenses(requestedSearchText: option.amount);
        },
        fieldViewBuilder: (
          BuildContext context,
          TextEditingController textEditingController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted,
        ) {
          return RoundedTextInputWidget(
            suffixIcon: RoundedBtnWidget(
              height: 25,
              width: 45,
              btnText: '',
              btnIcon: const Icon(
                Icons.search_rounded,
                color: Colors.white,
                size: 15,
              ),
              onTap: () {
                context
                    .read<ExpenseCubit>()
                    .getExpenses(requestedSearchText: textEditingController.text.trim());
              },
            ),
            focusNode: focusNode,
            textEditController: textEditingController,
            hintText: S.current.searchByNameNoteAmount,
            onFieldSubmitted: (value) {
              onFieldSubmitted();
            },
          );
        },
        optionsViewBuilder: (
          BuildContext context,
          AutocompleteOnSelected<ExpenseAmount> onSelected,
          Iterable<ExpenseAmount> options,
        ) {
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              elevation: 4.0,
              child: SizedBox(
                height: 200.0,
                width: constraints.biggest.width,
                child: Scrollbar(
                  thumbVisibility: true,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: options.length,
                    itemBuilder: (BuildContext context, int index) {
                      final option = options.elementAt(index);
                      return GestureDetector(
                        onTap: () {
                          onSelected(option);
                        },
                        child: ListTile(
                          title: Text(option.amount),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
