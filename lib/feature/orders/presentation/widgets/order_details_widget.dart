import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/orders/presentation/blocs/order_management_bloc.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/theme/theme_data.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/utils/responsive_widgets/responsive_dialog_widget.dart';
import 'package:merchant_dashboard/widgets/container_setting.dart';
import 'package:merchant_dashboard/widgets/loading_widget.dart';
import 'package:merchant_dashboard/widgets/scrollable_widget.dart';

import '../../../main_screen/presentation/blocs/main_screen_bloc.dart';
import 'customer_address_location.dart';

class OrderDetailsWidget extends StatefulWidget {
  final double? width;
  final double? height;
  final String orderId;
  final Function() onBackTap;

  const OrderDetailsWidget({Key? key, required this.onBackTap, this.width, this.height, required this.orderId}) : super(key: key);

  @override
  State<OrderDetailsWidget> createState() => _OrderDetailsWidgetState();
}

class _OrderDetailsWidgetState extends State<OrderDetailsWidget> {
  @override
  void initState() {
    super.initState();

    context.read<OrderManagementBloc>().add(GetOrderDetailsEvent(widget.orderId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextButton.icon(
              onPressed: widget.onBackTap,
              label: Text(
                S.current.orderDetails,
                style: context.textTheme.titleLarge,
              ),
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: ScrollableWidget(
              child: BlocBuilder<OrderManagementBloc, OrderManagementState>(
                builder: (context, state) => switch (state) {
                  GetOrderDetailsSuccessState() => Align(
                    alignment: Alignment.topLeft,
                    child: ContainerSetting(
                                padding: const EdgeInsets.symmetric( horizontal: 20 ,vertical: 30),
                      maxWidth: widget.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Text(
                                S.current.orderId,
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                  child: Text(state.order.id.toString(),
                                      textAlign: TextAlign.end,
                                      style: Theme.of(context).textTheme.titleSmall)),
                            ],
                          ),
                          context.sizedBoxHeightExtraSmall,
                          Row(
                            children: [
                              Text(
                                S.current.created,
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                  child: Text(state.order.createdOn,
                                      textAlign: TextAlign.end,
                                      style: Theme.of(context).textTheme.titleSmall)),
                            ],
                          ),
                          context.sizedBoxHeightExtraSmall,
                          Row(
                            children: [
                              Text(
                                S.current.status,
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                  child: Text(state.order.queueStatusName,
                                      textAlign: TextAlign.end,
                                      style: Theme.of(context).textTheme.titleSmall)),
                            ],
                          ),
                          context.sizedBoxHeightExtraSmall,
                          Row(
                            children: [
                              Text(
                                'Payment type',
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                  child: Text(state.order.paymentMods,
                                      textAlign: TextAlign.end,
                                      style: Theme.of(context).textTheme.titleSmall)),
                            ],
                          ),
                          context.sizedBoxHeightExtraSmall,
                          Row(
                            children: [
                              Text(
                                'Delivery service type',
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                  child: Text(state.order.deliveryServiceTypeTitle,
                                      textAlign: TextAlign.end,
                                      style: Theme.of(context).textTheme.titleSmall)),
                            ],
                          ),


                          context.sizedBoxHeightExtraSmall,
                          Row(
                            children: [
                              Text(
                                S.current.deliveryFee,
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                  child: Text(
                                      '${state.order.deliveryFee} ${context.select((MainScreenBloc bloc) => bloc.branchGeneralInfo?.currency)}',
                                      textAlign: TextAlign.end,
                                      style: context.textTheme.titleSmall)),
                            ],
                          ),
                          context.sizedBoxHeightExtraSmall,
                          Row(
                            children: [
                              Text(
                                S.current.deliveryDiscount,
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                  child: Text(
                                      '${state.order.deliveryFee} ${context.select((MainScreenBloc bloc) => bloc.branchGeneralInfo?.currency)}',
                                      textAlign: TextAlign.end,
                                      style: context.textTheme.titleSmall)),
                            ],
                          ),



                          context.sizedBoxHeightExtraSmall,
                          Row(
                            children: [
                              Text(
                                'Cashier',
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                  child: Text(state.order.transactionCashierName,
                                      textAlign: TextAlign.end,
                                      style: Theme.of(context).textTheme.titleSmall )),
                            ],
                          ),
                          context.sizedBoxHeightExtraSmall,
                          Divider(
                            color: AppColors.gray,
                            thickness: 0.5,
                          ),
                          context.sizedBoxHeightExtraSmall,
                          Row(
                            children: [
                              Text(
                                'Customer Name',
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                  child: Text(state.order.customer?.name ?? '',
                                      textAlign: TextAlign.end,
                                      style: Theme.of(context).textTheme.titleSmall)),
                            ],
                          ),
                          context.sizedBoxHeightExtraSmall,
                          Row(
                            children: [
                              Text(
                                S.current.phoneNumber,
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                  child: Text(state.order.customer?.phoneNumber ?? '',
                                      textAlign: TextAlign.end,
                                      style: Theme.of(context).textTheme.titleSmall)),
                            ],
                          ),
                          context.sizedBoxHeightExtraSmall,
                          Row(
                            children: [
                              Text(
                                S.current.address,
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                  child: Text(state.order.orderedAddress,
                                      textAlign: TextAlign.end,
                                      style: Theme.of(context).textTheme.titleSmall)),
                            ],
                          ),
                          context.sizedBoxHeightExtraSmall,
                          if(state.order.lat != 0 || state.order.lng != 0 )
                          CustomerAddressLocation(lat: state.order.lat , lng: state.order.lng),
                          context.sizedBoxHeightExtraSmall,
                          Row(
                            children: [
                              Text(
                                S.current.email,
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                  child: Text(state.order.customer?.email ?? '',
                                      textAlign: TextAlign.end,
                                      style: Theme.of(context).textTheme.titleSmall)),
                            ],
                          ),
                          ...[state.order.param1Object, state.order.param2Object, state.order.param3Object]
                              .map(
                                (e) => Visibility(
                                  visible: e.isEnabled,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      context.sizedBoxHeightExtraSmall,
                                      Row(
                                        children: [
                                          Text(
                                            e.paramHeader,
                                            style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                                          ),
                                          Expanded(
                                              child: Text(e.paramValue,
                                                  textAlign: TextAlign.end,
                                                  style: Theme.of(context).textTheme.titleSmall)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                          context.sizedBoxHeightExtraSmall,
                          Divider(
                            color: AppColors.gray,
                            thickness: 0.5,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.order.orderDetails.length,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${state.order.orderDetails[index].quantity}x ${state.order.orderDetails[index].itemNameEN}",
                                      style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Text(state.order.orderDetails[index].originalPrice.toStringAsFixed(2),
                                      textAlign: TextAlign.end,
                                      style: Theme.of(context).textTheme.titleSmall),
                                ],
                              ),
                            ),
                          ),
                          Divider(
                            color: AppColors.gray,
                            thickness: 0.5,
                          ),
                          context.sizedBoxHeightExtraSmall,
                          Row(
                            children: [
                              Text(
                                'Subtotal',
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                  child: Text(state.order.totalPrice.toStringAsFixed(2),
                                      textAlign: TextAlign.end,
                                      style: Theme.of(context).textTheme.titleSmall)),
                            ],
                          ),
                          context.sizedBoxHeightExtraSmall,
                          Row(
                            children: [
                              Text(
                                S.current.tax,
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                  child: Text(state.order.totalTax.toStringAsFixed(2),
                                      textAlign: TextAlign.end,
                                      style: Theme.of(context).textTheme.titleSmall)),
                            ],
                          ),
                          context.sizedBoxHeightExtraSmall,
                          Row(
                            children: [
                              Text(
                                S.current.total,
                                style: context.textTheme.titleMedium
                                    ?.copyWith(color: context.colorScheme.primaryColor, fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                  child: Text(state.order.totalFinalPrice.toStringAsFixed(2),
                                      textAlign: TextAlign.end,
                                      style: context.textTheme.titleMedium
                                          ?.copyWith(color: context.colorScheme.primaryColor, fontWeight: FontWeight.bold))),
                            ],
                          ),
                          context.sizedBoxHeightExtraSmall,
                        ],
                      ),
                    ),
                  ),
                  GetOrderDetailsLoadingState() => const Center(child: LoadingWidget()),
                  _ => const SizedBox(),
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
