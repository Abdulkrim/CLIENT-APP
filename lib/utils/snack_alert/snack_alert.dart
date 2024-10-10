import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:toastification/toastification.dart';

enum SnackBarType {
  error(ToastificationType.error),
  info(ToastificationType.info),
  alert(ToastificationType.warning),
  success(ToastificationType.success);

  const SnackBarType(this.type);
  final ToastificationType type;
}

extension ShowSnackBar on BuildContext {
  showCustomeAlert([String? msg, SnackBarType? snackBarType]) => toastification.show(
        context: this,
        type: snackBarType?.type ?? SnackBarType.info.type,
        style: ToastificationStyle.flat,
        description: Text(
          msg ?? 'Somthing went wrong',
          style: textTheme.bodyMedium,
        ),
        alignment: Alignment.topRight,
        autoCloseDuration: const Duration(seconds: 4),
        primaryColor: colorScheme.primaryColor,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: highModeShadow,
      );
}
