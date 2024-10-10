import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchant_dashboard/feature/manage_features/presentation/blocs/cubit/manage_feautre_cubit.dart';

class ManageFeature extends StatelessWidget {
  const ManageFeature({
    super.key,
    required this.child,
    required this.widgetKey,
  });

  final Widget child;
  final String? widgetKey;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: (widgetKey == null) ? true : context.watch<ManageFeautreCubit>().isFeatureEnable(widgetKey!),
      child: child,
    );
  }
}
