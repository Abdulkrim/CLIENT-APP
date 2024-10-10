import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/core/constants/defaults.dart';
import 'package:merchant_dashboard/feature/my_account/data/models/entity/account_details.dart';
import 'package:merchant_dashboard/feature/my_account/presentation/blocs/my_account_bloc.dart';
import 'package:merchant_dashboard/feature/my_account/presentation/widgets/mobile/mobile_account_summery_widget.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/rounded_btn.dart';

class MyAccountMobileWidget extends StatefulWidget {
  const MyAccountMobileWidget({Key? key}) : super(key: key);

  @override
  State<MyAccountMobileWidget> createState() => _MyAccountMobileWidgetState();
}

class _MyAccountMobileWidgetState extends State<MyAccountMobileWidget> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        context.sizedBoxHeightExtraSmall,
        Visibility(
          visible: hideForThisV,
          child: SizedBox(
            height: 50,
            width: Get.width,
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: false,
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                Visibility(
                  visible: hideForThisV,
                  child: RoundedBtnWidget(
                    onTap: () => context.read<MyAccountBloc>().add(const AccountSummaryRequestEvent()),
                    btnText: "Account Summary",
                    width: 150,
                    borderRadios: 40,
                    height: 40,
                    btnTextStyle: context.textTheme.titleSmall,
                    btnTextColor:
                        (context.select<MyAccountBloc, int>((MyAccountBloc value) => value.selectedTab) == 0)
                            ? Colors.white
                            : Colors.black,
                    bgColor: (context.select<MyAccountBloc, int>((MyAccountBloc value) => value.selectedTab) == 0)
                        ? context.colorScheme.primaryColor
                        : Colors.transparent,
                    boxBorder: Border.all(color: context.colorScheme.primaryColor),
                  ),
                ),
                Visibility(
                  visible: hideForThisV,
                  child: RoundedBtnWidget(
                    onTap: () => context.read<MyAccountBloc>().add(const BillingHistoryRequestEvent()),
                    btnText: "Billing History",
                    width: 150,
                    borderRadios: 40,
                    height: 40,
                    btnTextStyle: context.textTheme.titleSmall,
                    btnTextColor:
                        (context.select<MyAccountBloc, int>((MyAccountBloc value) => value.selectedTab) == 1)
                            ? Colors.white
                            : Colors.black,
                    bgColor:
                        (context.select<MyAccountBloc, int>((MyAccountBloc value) => value.selectedTab) == 1)
                            ? context.colorScheme.primaryColor
                            : Colors.transparent,
                    boxBorder: Border.all(color: context.colorScheme.primaryColor),
                  ),
                ),
                Visibility(
                  visible: hideForThisV,
                  child: RoundedBtnWidget(
                    onTap: () => context.read<MyAccountBloc>().add(const SubscriptionPlanRequestEvent()),
                    btnText: "Subscription Plan",
                    width: 150,
                    borderRadios: 40,
                    height: 40,
                    btnTextStyle: context.textTheme.titleSmall,
                    btnTextColor:
                        (context.select<MyAccountBloc, int>((MyAccountBloc value) => value.selectedTab) == 2)
                            ? Colors.white
                            : Colors.black,
                    bgColor:
                        (context.select<MyAccountBloc, int>((MyAccountBloc value) => value.selectedTab) == 2)
                            ? context.colorScheme.primaryColor
                            : Colors.transparent,
                    boxBorder: Border.all(color: context.colorScheme.primaryColor),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
            child: BlocListener<MyAccountBloc, MyAccountState>(
          listener: (context, state) {
            if (state is TopTabItemSelectedState) {
              _controller.animateToPage(state.pos,
                  duration: Defaults.defaultAnimDuration, curve: Curves.easeIn);
            }
          },
          child: PageView(
            controller: _controller,
            children: [
                MobileAccountSummeryWidget(
                accountDetails:
                context.select<MyAccountBloc, AccountDetails?>((value) => value.accountDetails),
              ),
              // const MobileBillingHistoryWidget(),
              // const MobileSubscriptionPlanWidget(),
            ],
          ),
        ))
      ],
    );
  }
}
