import 'package:flutter/material.dart';
import 'package:merchant_dashboard/feature/settings/data/models/entity/payment_type.dart';
import 'package:merchant_dashboard/theme/theme_data.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

class PaymentModeSelectWidget extends StatefulWidget {
  final PaymentType type;
  final Function() onStatusChanged;
  bool isSelected;
  PaymentModeSelectWidget(
      {super.key,
        required this.type,
        required this.isSelected,
        required this.onStatusChanged});

  @override
  State<PaymentModeSelectWidget> createState() =>
      _PaymentModeSelectWidgetState();
}

class _PaymentModeSelectWidgetState extends State<PaymentModeSelectWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          widget.isSelected = !widget.isSelected;
        });
        widget.onStatusChanged();
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: widget.isSelected ? AppColors.headerColor : Colors.white,
            border: Border.all(color: Colors.grey)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              !widget.isSelected
                  ? const Icon(
                Icons.add,
                color: Colors.black,
                size: 18,
              )
                  : const Icon(
                Icons.check,
                color: Colors.white,
                size: 18,
              ),
              SizedBox(width: 5),
              Text(
                widget.type.name,
                style: TextStyle(
                    color: widget.isSelected ? Colors.white : Colors.black),
              )
            ],
          ),
        ),
      ),
    );
  }
}
