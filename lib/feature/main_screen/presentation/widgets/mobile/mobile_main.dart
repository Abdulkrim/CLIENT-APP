import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchant_dashboard/feature/main_screen/presentation/blocs/main_screen_bloc.dart';
import 'package:merchant_dashboard/feature/main_screen/presentation/widgets/desktop/body_content.dart';
import 'package:merchant_dashboard/feature/main_screen/presentation/widgets/mobile/app_drawer.dart';

import '../../blocs/menu_drawer/menu_drawer_cubit.dart';
import 'mobile_branches_dropdown_widget.dart';

class MobileMainWidget extends StatelessWidget {
  const MobileMainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuDrawerCubit>().scaffoldKey,
      drawer: const Drawer(
        backgroundColor: Color(0xffebebeb),
        child: AppDrawerWidget(),
      ),
      appBar: AppBar(
        title: Text(context.watch<MenuDrawerCubit>().selectedPageContent.text),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          SizedBox(
            width: 120,
            height: 100,
            child: Visibility(
              visible: context.select<MainScreenBloc, bool>(
                  (value) => (value.loggedInMerchantInfo?.isLoggedInUserG ?? true)),
              child: MobileBranchesDropDownWidget(),
            ),
          )
        ],
      ),
      body: const Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BodyContentWidget(),
        ],
      ),
    );
  }
}
