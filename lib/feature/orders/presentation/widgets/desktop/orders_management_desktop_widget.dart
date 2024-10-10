import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/orders/data/models/entity/orders.dart';
import 'package:merchant_dashboard/feature/orders/presentation/blocs/order_management_bloc.dart';
import 'package:merchant_dashboard/feature/orders/presentation/widgets/desktop/desktop_orders_table_widget.dart';
import 'package:merchant_dashboard/feature/orders/presentation/widgets/desktop/desktop_orders_management_info_box_widget.dart';
import 'package:merchant_dashboard/generated/assets.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/scrollable_widget.dart';
import 'package:merchant_dashboard/widgets/shimmer.dart';

import '../../../../../utils/snack_alert/snack_alert.dart';
import '../../../../main_screen/presentation/blocs/menu_drawer/menu_drawer_cubit.dart';
import '../change_order_status_dialog.dart';
import '../order_details_widget.dart';
import 'desktop_status_order_filters_widget.dart';

class OrdersManagementDesktopWidget extends StatefulWidget {
  const OrdersManagementDesktopWidget({Key? key}) : super(key: key);

  @override
  State<OrdersManagementDesktopWidget> createState() => _OrdersManagementDesktopWidgetState();
}

class _OrdersManagementDesktopWidgetState extends State<OrdersManagementDesktopWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    context.read<OrderManagementBloc>().add(const GetBranchParametersEvent());

    _scrollController.addListener(() {
      if (_scrollController.offset >= _scrollController.position.maxScrollExtent && !_scrollController.position.outOfRange) {
        context.read<OrderManagementBloc>().add(const GetAllOrderRequestEvent(getMore: true));
      }
    });
  }

 /* @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }*/

  OrderItem? orderItem;
  final _pageViewController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageViewController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(20),          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        context.watch<MenuDrawerCubit>().selectedPageContent.text,
                        style: context.textTheme.titleLarge,
                      ),
                      context.sizedBoxWidthMicro,
                      IconButton(
                          onPressed: () {
                            context.read<OrderManagementBloc>().add(const GetAllOrdersData());
                          },
                          icon: const Icon(
                            Icons.refresh_rounded,
                            color: Colors.black,
                          )),
                    ],
                  ),
                  const DesktopStatusOrderFiltersWidget(),
                ],
              ),
              context.sizedBoxHeightMicro,
              Wrap(
                alignment: WrapAlignment.start,
                children: [
                  DesktopOrderManagementInfoBox(
                    iconName: Assets.iconsOrder30days,
                    boxValue: context.select<OrderManagementBloc, String>((value) => value.ordersCount),
                    boxTitle: S.current.numberOfOrdersToday,
                  ),
                  DesktopOrderManagementInfoBox(
                    iconName: Assets.iconsSales30days,
                    boxValue: context.select<OrderManagementBloc, String>((value) => value.salesCount.toDoubleFixed(2)),
                    boxTitle: S.current.salesAmountToday,
                  ),
                  DesktopOrderManagementInfoBox(
                    iconName: Assets.iconsProductsCount,
                    boxValue: context.select<OrderManagementBloc, String>((value) => value.productsCount),
                    boxTitle: S.current.numberOfProductToday,
                  ),
                  DesktopOrderManagementInfoBox(
                    iconName: Assets.iconsCustomers30Days,
                    boxValue: context.select<OrderManagementBloc, String>((value) => value.customersCount),
                    boxTitle: S.current.numberOfCustomerToday,
                  ),
                ],
              ),
              context.sizedBoxHeightSmall,
              Expanded(
                child: BlocConsumer<OrderManagementBloc, OrderManagementState>(
                  listener: (context, state) {
                    if (state is ChangeOrderStatusFailedState) {
                      context.showCustomeAlert(state.msg, SnackBarType.error);
                    }
                    if (state is ShowPaymentTypeDialog) {
                      Get.dialog(BlocProvider<OrderManagementBloc>.value(
                        value: BlocProvider.of<OrderManagementBloc>(context),
                        child: ChangeOrderStatusDialog(
                          paymentModes: state.paymentModes,
                          maxDiscount: state.orderItem.deliveryMaxDiscount,
                          showDelieryDiscount: state.orderItem.deliveryDiscountAllowed,
                          deliveryFee: state.orderItem.deliveryFee,
                          userPayTypeDefinedId: state.orderItem.userPayTypeDefinedId,
                          cashiers: context.read<OrderManagementBloc>().cashiers,
                          onPaymentTypeTap: (int? paymentType, String? cashierId, String referenceID, num deliveryDiscount) {
                            context.read<OrderManagementBloc>().add(ChangeOrderStatusEvent(
                                orderItem: state.orderItem,
                                requestedStatusId: state.requestedStatusId,
                                requestedStatusIsCompleted: state.requestedStatusIsCompleted,
                                selectedPaymentType: paymentType,
                                selectedCashierId: cashierId,
                                deliveryDiscount: deliveryDiscount,
                                referenceID: referenceID));

                            Get.back();
                          },
                        ),
                      ));
                    }
                  },
                  builder: (context, state) {
                    if (state is AllOrdersDataLoadingState || state is ChangeOrderStatusLoadingState) {
                      return ShimmerWidget(width: Get.width, height: Get.height);
                    }
                    return ScrollableWidget(
                      scrollController: _scrollController,
                      child: Column(
                        children: [
                          DesktopOrdersTableWidget(
                              onOrderDetailsTap: (orderItem) {
                                setState(() => this.orderItem = orderItem);
                                _pageViewController.jumpToPage(1);
                              },
                              allOrders: context.select<OrderManagementBloc, List<OrderItem>>(
                                (value) => value.ordersPagination.listItems,
                              )),
                          Visibility(
                              visible: context.select<OrderManagementBloc, bool>((value) => value.ordersPagination.hasMore) &&
                                  state is! GetOrdersFailedState,
                              child: const CupertinoActivityIndicator()),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        OrderDetailsWidget(orderId: orderItem?.originalId ?? '0' , width: 500, onBackTap: (){
          setState(() => orderItem = null);
          _pageViewController.jumpToPage(0);
        },),

      ],
    );
  }
}
