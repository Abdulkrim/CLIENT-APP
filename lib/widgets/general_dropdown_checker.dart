import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchant_dashboard/feature/main_screen/presentation/blocs/main_screen_bloc.dart';
import 'package:merchant_dashboard/widgets/select_branch_box_widget.dart';

class GeneralDropdownChecker extends StatelessWidget {
  final Widget child;


  const GeneralDropdownChecker({super.key, required this.child  });
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: (!context
          .select<MainScreenBloc, bool>((value) => value.isUserBranch)),
      replacement: child,
      child: const SelectBranchBoxWidget(),
    );
  }
}
