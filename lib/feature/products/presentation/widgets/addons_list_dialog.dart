import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/utils/responsive_widgets/responsive_dialog_widget.dart';
import 'package:merchant_dashboard/widgets/rounded_btn.dart';
import 'package:merchant_dashboard/widgets/search_box_widget.dart';

import '../../../../generated/l10n.dart';
import '../../data/models/entity/dependency_item.dart';
import '../../data/models/entity/products.dart';

class AddOnsListDialog extends StatefulWidget {
  const AddOnsListDialog({super.key, required this.initialAddOnItems, required this.allAddOnItems});

  final List<DependencyItem> initialAddOnItems;
  final List<Product> allAddOnItems;

  @override
  State<AddOnsListDialog> createState() => _AddOnsListDialogState();
}

class _AddOnsListDialogState extends State<AddOnsListDialog> {
  late final List<int> _selectedAddOns = widget.initialAddOnItems.map((e) => e.itemId).toList();
  late List<Product> _addOnItems = widget.allAddOnItems;

  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ResponsiveDialogWidget(
        title: S.current.manageAddOnItems,
        width: context.isPhone ? null : 450,
        height: context.isPhone ? null : 550,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SearchBoxWidget(
                searchTextController: _textController,
                onSearchTapped: (text) {
                  if (text != null && text.isNotEmpty) {
                    _addOnItems = widget.allAddOnItems
                        .where((element) => element.productNameEN.toLowerCase().contains(text.trim().toLowerCase()))
                        .toList();
                  } else {
                    _addOnItems = widget.allAddOnItems;
                  }
                  setState(() {});
                },
              ),
              context.sizedBoxHeightExtraSmall,
              Expanded(
                child: ListView.builder(
                    primary: true,
                    itemCount: _addOnItems.length,
                    itemBuilder: (context, index) => CheckboxListTile(
                          title: Text(_addOnItems[index].productNameEN),
                          value: _selectedAddOns.contains(_addOnItems[index].productId),
                          onChanged: (bool? value) {
                            if (_selectedAddOns.contains(_addOnItems[index].productId)) {
                              _selectedAddOns.remove(_addOnItems[index].productId);
                            } else {
                              _selectedAddOns.add(_addOnItems[index].productId);
                            }
                            setState(() {});
                          },
                        )),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: RoundedBtnWidget(
                  onTap: () {
                    Get.back(
                        result: _selectedAddOns
                            .map((addOnId) =>
                                widget.allAddOnItems.firstWhere((element) => element.productId == addOnId).toDependencyItem())
                            .toList());
                  },
                  btnPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                  btnText: S.current.save,
                ),
              )
            ],
          ),
        ));
  }
}
