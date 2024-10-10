import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/customers/presentation/blocs/customers/customer_bloc.dart';
import 'package:merchant_dashboard/feature/customers/presentation/widgets/desktop/desktop_customer_credit_hisotories_screen.dart';
import 'package:merchant_dashboard/feature/customers/presentation/widgets/desktop/desktop_customer_information_screen.dart';
import 'package:merchant_dashboard/feature/loyalty/presentation/widgets/desktop/desktop_loyalty_point_history_page.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../../generated/assets.dart';
import '../../../../../widgets/rounded_btn.dart';
import '../../../../../widgets/scrollable_widget.dart';
import '../../../../../widgets/search_box_widget.dart';
import '../../../../loyalty/presentation/widgets/desktop/desktop_points_history_page.dart';
import '../../../../main_screen/presentation/blocs/menu_drawer/menu_drawer_cubit.dart';
import '../../../../region/presentation/blocs/region_cubit.dart';
import '../../../data/models/entity/customer_list_info.dart';
import '../customer_details_dialog.dart';
import 'desktop_customers_table_widget.dart';

class CustomerDesktopWidget extends StatefulWidget {
  const CustomerDesktopWidget({super.key});

  @override
  State<CustomerDesktopWidget> createState() => _CustomerDesktopWidgetState();
}

class _CustomerDesktopWidgetState extends State<CustomerDesktopWidget> {
  final ScrollController _scrollController = ScrollController();
  late PageController _pageViewController;

  Customer? selectedCustomer;

  final _displayCustomersBar = true.obs;

  @override
  void initState() {
    super.initState();

    _pageViewController = PageController()
      ..addListener(() {
        _displayCustomersBar(_pageViewController.page == 0);
      });
    _scrollController.addListener(() {
      if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        context.read<CustomerBloc>().add(const GetAllCustomersEvent(getMore: true));
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Obx(
            () => Visibility(
              visible: _displayCustomersBar.value,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        context.watch<MenuDrawerCubit>().selectedPageContent.text,
                        style: context.textTheme.titleLarge,
                      ),
                    ),
                    RoundedBtnWidget(
                      onTap: () =>Get.dialog(MultiBlocProvider(
                        providers: [
                          BlocProvider<CustomerBloc>.value(value: BlocProvider.of<CustomerBloc>(context)),
                          BlocProvider<RegionCubit>.value(value: BlocProvider.of<RegionCubit>(context)),
                        ],
                        child: const CustomerDetailsDialog(),
                      )),
                      btnText: S.current.addCustomer,
                      btnIcon: SvgPicture.asset(Assets.iconsCustomersIcon, color: Colors.white, height: 20),
                      wrapWidth: true,
                      btnPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    ),
                    context.sizedBoxWidthExtraSmall,
                    SizedBox(
                      width: 250,
                      height: 40,
                      child: SearchBoxWidget(
                          hint: S.current.searchCustomer,
                          searchTextController: _searchController,
                          onSearchTapped: (String? text) => context
                              .read<CustomerBloc>()
                              .add(GetAllCustomersEvent.refresh(searchText: text))),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
              child: PageView(
            controller: _pageViewController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              ScrollableWidget(
                scrollController: _scrollController,
                child: Column(
                  children: [
                    DesktopCustomersTableWidget(
                        customers: context.watch<CustomerBloc>().customerPagination.listItems,
                        onCustomerInformationTapped: (Customer customer) {
                          selectedCustomer = customer;
                          setState(() {});
                          _pageViewController.jumpToPage(1);
                        }),
                    Visibility(
                        visible:
                            context.select<CustomerBloc, bool>((value) => value.customerPagination.hasMore),
                        child: const CupertinoActivityIndicator()),
                  ],
                ),
              ),
              selectedCustomer != null
                  ? DesktopCustomerInformationScreen(
                      customer: selectedCustomer!,
                      onCreditHistoriesTap: () {
                        _pageViewController.jumpToPage(2);
                      },
                      onLoyaltyHistoryTap: () => _pageViewController.jumpToPage(3),
                      onBackTap: () => _pageViewController.jumpToPage(0),
                    )
                  : const SizedBox(),
              selectedCustomer != null
                  ? DesktopCustomerCreditHistoriesScreen(
                      customer: selectedCustomer!,
                      onBackTap: () => _pageViewController.jumpToPage(1),
                    )
                  : const SizedBox(),
              selectedCustomer != null
                  ? DesktopLoyaltyPointHistoryPage(
                      customerId: selectedCustomer!.id,
                      onBackTap: () => _pageViewController.jumpToPage(2),
                      onPointHistoryTap: () => _pageViewController.jumpToPage(4),
                    )
                  : const SizedBox(),
              selectedCustomer != null
                  ? DesktopPointsHistoryPage(
                      onBackTap: () => _pageViewController.jumpToPage(3),
                    )
                  : const SizedBox(),
            ],
          ))
        ],
      ),
    );
  }
}
