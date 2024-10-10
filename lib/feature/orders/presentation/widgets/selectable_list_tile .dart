import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';

class SelectableListTile extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;
  final String title;
  final Widget leading;

  const SelectableListTile({
    required this.isSelected,
    required this.onTap,
    required this.title,
    required this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.orange : Colors.transparent,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(8.0),
          title: Text(
            title,
            style: context.textTheme.bodyMedium,
          ),
          leading: leading,
        ),
      ),
    );
  }
}
