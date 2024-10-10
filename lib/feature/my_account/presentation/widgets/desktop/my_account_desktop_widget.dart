import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/my_account/data/models/entity/account_details.dart';
import 'package:merchant_dashboard/feature/my_account/presentation/blocs/my_account_bloc.dart';
import 'package:merchant_dashboard/feature/my_account/presentation/widgets/desktop/desktop_account_summery_widget.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/utils/snack_alert/snack_alert.dart';
import 'package:merchant_dashboard/widgets/shimmer.dart';

import '../../../../main_screen/presentation/blocs/menu_drawer/menu_drawer_cubit.dart';

class MyAccountDesktopWidget extends StatefulWidget {
  const MyAccountDesktopWidget({Key? key}) : super(key: key);

  @override
  State<MyAccountDesktopWidget> createState() => _MyAccountDesktopWidgetState();
}

class _MyAccountDesktopWidgetState extends State<MyAccountDesktopWidget> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this); // length =3 is for next version
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MyAccountBloc, MyAccountState>(
      listenWhen: (previous, current) => current is UpdateAccountDetailsSuccessState,
      listener: (context, state) {
        if (state is UpdateAccountDetailsSuccessState) {
          context.showCustomeAlert(state.message);
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  context.watch<MenuDrawerCubit>().selectedPageContent.text,
                  style: context.textTheme.titleLarge,
                ),
              ),
            ],
          ),
          context.sizedBoxHeightSmall,
          const Divider(
            height: 0.5,
            thickness: 0.5,
            color: Colors.grey,
          ),
          Row(
            children: [
              TabBar(
                controller: _tabController,
                labelColor: context.colorScheme.primaryColor,
                unselectedLabelColor: Colors.black,
                indicatorColor: context.colorScheme.primaryColor,
                isScrollable: true,
                tabs: const [
                  Tab(text: 'Account Summery'),
                  // Tab(text: 'Billing History'),visible: hideForThisV,
                  // Tab(text: 'Subscription Plan'),
                ],
              ),
            ],
          ),
          const Divider(
            height: 0.5,
            thickness: 0.5,
            color: Colors.grey,
          ),
          Expanded(
              child: TabBarView(
            controller: _tabController,
            children: [
              BlocBuilder<MyAccountBloc, MyAccountState>(
                builder: (context, state) {
                  if (state is AccountDetailsLoadingState) {
                    return ShimmerWidget(
                      width: Get.width,
                      height: Get.height,
                    );
                  }
                  return DesktopAccountSummeryWidget(
                    accountDetails:
                        context.select<MyAccountBloc, AccountDetails?>((value) => value.accountDetails),
                  );
                },
              ),
              // DesktopBillingHistory(), visible: hideForThisV,
              // DesktopSubscriptionPlan(),
            ],
          )),
        ],
      ),
    );
  }
}
