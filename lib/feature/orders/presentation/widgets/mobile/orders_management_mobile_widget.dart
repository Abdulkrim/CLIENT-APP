import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:merchant_dashboard/feature/orders/data/models/entity/orders.dart';
import 'package:merchant_dashboard/feature/orders/presentation/blocs/order_management_bloc.dart';
import 'package:merchant_dashboard/feature/orders/presentation/widgets/mobile/mobile_orders_list_widget.dart';
import 'package:merchant_dashboard/feature/orders/presentation/widgets/mobile/mobile_orders_management_inbo_box_widget.dart';
import 'package:merchant_dashboard/generated/assets.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/shimmer.dart';

import '../../../../../utils/snack_alert/snack_alert.dart';
import '../change_order_status_dialog.dart';
import '../desktop/desktop_status_order_filters_widget.dart';

class OrdersManagementMobileWidget extends StatefulWidget {
  const OrdersManagementMobileWidget({Key? key}) : super(key: key);

  @override
  State<OrdersManagementMobileWidget> createState() => _OrdersManagementMobileWidgetState();
}

class _OrdersManagementMobileWidgetState extends State<OrdersManagementMobileWidget> {
  @override
  void initState() {
    super.initState();
    context.read<OrderManagementBloc>().add(const GetBranchParametersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                  child: MobileOrdersManagementInfoBoxWidget(
                iconName: Assets.iconsOrder30days,
                boxValue: context.select<OrderManagementBloc, String>((value) => value.ordersCount),
                boxTitle: S.current.numberOfOrdersToday,
              )),
              context.sizedBoxWidthMicro,
              Expanded(
                  child: MobileOrdersManagementInfoBoxWidget(
                iconName: Assets.iconsSales30days,
                boxValue: context.select<OrderManagementBloc, String>((value) => value.salesCount),
                boxTitle: S.current.salesAmountToday,
              )),
            ],
          ),
          context.sizedBoxHeightMicro,
          Row(
            children: [
              Expanded(
                  child: MobileOrdersManagementInfoBoxWidget(
                iconName: Assets.iconsProductsCount,
                boxValue: context.select<OrderManagementBloc, String>((value) => value.productsCount),
                boxTitle: S.current.numberOfProductToday,
              )),
              context.sizedBoxWidthMicro,
              Expanded(
                  child: MobileOrdersManagementInfoBoxWidget(
                iconName: Assets.iconsCustomers30Days,
                boxValue: context.select<OrderManagementBloc, String>((value) => value.customersCount),
                boxTitle: S.current.numberOfCustomerToday,
              )),
            ],
          ),
          context.sizedBoxHeightUltraSmall,
          const DesktopStatusOrderFiltersWidget(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<OrderManagementBloc>().add(const GetAllOrdersData());

                return Future<void>.delayed(const Duration(seconds: 1));
              },
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
                        onPaymentTypeTap:
                            (int? paymentType, String? cashierId, String referenceID, num deliveryDiscount) {
                          context.read<OrderManagementBloc>().add(ChangeOrderStatusEvent(
                              orderItem: state.orderItem,
                              requestedStatusId: state.requestedStatusId,
                              deliveryDiscount: deliveryDiscount,
                              requestedStatusIsCompleted: state.requestedStatusIsCompleted,
                              selectedPaymentType: paymentType,
                              selectedCashierId: cashierId,
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

                  return MobileOrdersListWidget(
                      orders: context.select<OrderManagementBloc, List<OrderItem>>(
                    (value) => value.ordersPagination.listItems,
                  ));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
