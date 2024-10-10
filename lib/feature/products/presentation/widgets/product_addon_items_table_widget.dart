import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/products/data/models/entity/dependency_item.dart';
import 'package:merchant_dashboard/feature/products/presentation/blocs/products/products_bloc.dart';
import 'package:merchant_dashboard/feature/products/presentation/widgets/addons_list_dialog.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../generated/l10n.dart';

class ProductAddOnItemsTableWidget extends StatefulWidget {
  const ProductAddOnItemsTableWidget({super.key, required this.initialAddOnItems, required this.onAddOnsChanged});

  final List<DependencyItem> initialAddOnItems;
  final Function({required List<DependencyItem> addOns}) onAddOnsChanged;

  @override
  State<ProductAddOnItemsTableWidget> createState() => _ProductAddOnItemsTableWidgetState();
}

class _ProductAddOnItemsTableWidgetState extends State<ProductAddOnItemsTableWidget> {
  late List<DependencyItem> _selectedAddOns = widget.initialAddOnItems;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Wrap(
          children: _selectedAddOns
              .map((e) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: context.colorScheme.primaryColorLight,
                    ),
                    child: Text(
                      e.relatedItemNameEn,
                      style: context.textTheme.bodyMedium?.copyWith(),
                    ),
                  ))
              .toList(),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
            icon:  const  Icon(
              Icons.add_rounded,
              size: 15,
              color: Colors.grey,
            ),
            onPressed: () async {
              final List<DependencyItem>? selectedAddons = await ((context.isPhone) ? Get.to: Get.dialog)(BlocProvider<ProductsBloc>.value(
                value: BlocProvider.of<ProductsBloc>(context),
                child: AddOnsListDialog(
                  initialAddOnItems: _selectedAddOns,
                  allAddOnItems: context.read<ProductsBloc>().addOnProducts,
                ),
              ));

              if (selectedAddons != null) {
                setState(() {
                  _selectedAddOns = selectedAddons ?? [];
                });
                widget.onAddOnsChanged(addOns: _selectedAddOns);
              }
            },
            label: Text(
              S.current.manageAddOnItems,
              style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.primaryColor, fontWeight: FontWeight.w700),
            ),
          ),
        )
      ],
    );
  }
}
