import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchant_dashboard/feature/main_screen/presentation/blocs/menu_drawer/menu_drawer_cubit.dart';

class BodyContentWidget extends StatelessWidget {
  const BodyContentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: context.select<MenuDrawerCubit, Widget>(
      (MenuDrawerCubit value) => value.selectedPageContent.screen,
    ));
  }
}
