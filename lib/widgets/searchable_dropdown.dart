import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../generated/l10n.dart';
import '../theme/theme_data.dart';

enum SearchableDropDownItemMode { leading, title, both }

class SearchableDropDownModel<T> {
  final T? item;
  final String displayName;
  final Widget? leadingWidget;
  final SearchableDropDownItemMode searchableDropDownSelectedItemMode;
  final SearchableDropDownItemMode searchableDropDownItemMode;

  SearchableDropDownModel({
    required this.item,
    required this.displayName,
    this.leadingWidget,
    this.searchableDropDownSelectedItemMode = SearchableDropDownItemMode.title,
    this.searchableDropDownItemMode = SearchableDropDownItemMode.title,
  });
}

class SearchableDropdown<T> extends StatefulWidget {
  const SearchableDropdown({
    super.key,
    required this.items,
    required this.onSelectedItemChanged,
    this.isRequired = false,
    this.isEnabled = true,
    this.preDefinedItem,
    this.validator,
  });

  final String? Function(SearchableDropDownModel<T>?)? validator;
  final List<SearchableDropDownModel<T>> items;
  final SearchableDropDownModel<T>? preDefinedItem;
  final Function(SearchableDropDownModel<T>? selectedItem) onSelectedItemChanged;
  final bool isRequired;
  final bool isEnabled;

  @override
  State<SearchableDropdown<T>> createState() => _SearchableDropdownState<T>();
}

class _SearchableDropdownState<T> extends State<SearchableDropdown<T>> {
  late SearchableDropDownModel<T>? _selectedItem = widget.preDefinedItem;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<SearchableDropDownModel<T>>(
        filterFn: (cat, filter) => cat.displayName.toLowerCase().contains(filter.toLowerCase()),
        autoValidateMode: AutovalidateMode.onUserInteraction,
        validator: widget.validator ?? (value) => (widget.isRequired && value?.displayName == null) ? S.current.thisFieldRequired : null,
        enabled: widget.isEnabled,
        items: widget.items,
        selectedItem: _selectedItem,
        onChanged: (value) {
          setState(() {
            _selectedItem = value;
          });

          widget.onSelectedItemChanged(_selectedItem);
        },
        popupProps: PopupProps.menu(
          searchFieldProps: TextFieldProps(
            autofocus: true,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(
                  color: context.colorScheme.primaryColor,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(
                  color: Color(0xffeeeeee),
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(
                  color: Color(0xffeeeeee),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(
                  color: Color(0xffeeeeee),
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(
                  color: Colors.redAccent,
                ),
              ),
              hintStyle: const TextStyle(color: Colors.grey),
              filled: true,
              fillColor: Colors.white70,
            ),
          ),
          showSelectedItems: true,
          containerBuilder: (ctx, popupWidget) {
            return DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.white,
              ),
              child: popupWidget,
            );
          },
          itemBuilder: (context, item, isSelected) => switch (item.searchableDropDownItemMode) {
            SearchableDropDownItemMode.leading when item.leadingWidget != null => item.leadingWidget!,
            SearchableDropDownItemMode.both => ListTile(
                leading: item.leadingWidget,
                title: Text(item.displayName ?? '',
                    style: context.textTheme.labelMedium?.copyWith(color: AppColors.black),
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip),
              ),
            _ => ListTile(
                title: Text(
                  item.displayName ?? '',
                  style: context.textTheme.labelMedium?.copyWith(color: AppColors.black),
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.clip,
                ),
              )
          },
          showSearchBox: true,
          constraints: const BoxConstraints(maxHeight: 300),
          emptyBuilder: (context, searchEntry) => ListTile(
            onTap: () {
              setState(() {
                _selectedItem = SearchableDropDownModel(item: null, displayName: searchEntry);
              });

              Get.back();
              widget.onSelectedItemChanged(_selectedItem);
            },
            title: Text(searchEntry,
                style: context.textTheme.labelMedium?.copyWith(color: AppColors.black),
                textAlign: TextAlign.start,
                overflow: TextOverflow.clip),
          ),
        ),
        compareFn: (item, selectedItem) => item.displayName.toLowerCase() == selectedItem.displayName.toLowerCase(),
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                color: context.colorScheme.primaryColor,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(
                color: Color(0xffeeeeee),
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(
                color: Color(0xffeeeeee),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(
                color: Color(0xffeeeeee),
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(
                color: Colors.redAccent,
              ),
            ),
            filled: true,
            fillColor: AppColors.white,
          ),
        ),
        dropdownBuilder: (context, selectedItem) => switch (selectedItem?.searchableDropDownSelectedItemMode) {
              SearchableDropDownItemMode.leading when selectedItem!.leadingWidget != null => selectedItem.leadingWidget!,
              SearchableDropDownItemMode.both => Row(
                  children: [
                    if (selectedItem != null && selectedItem.leadingWidget != null) selectedItem.leadingWidget!,
                    Text('  ${selectedItem?.displayName ?? ''}',
                        style: context.textTheme.labelMedium?.copyWith(color: AppColors.black),
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip),
                  ],
                ),
              _ => Text(
                  selectedItem?.displayName ?? '-',
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  style: context.textTheme.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                ),
            });
  }
}
