import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/orders/data/models/entity/orders.dart';
import 'package:merchant_dashboard/feature/orders/presentation/blocs/order_management_bloc.dart';
import 'package:merchant_dashboard/generated/assets.dart';
import 'package:merchant_dashboard/theme/theme_data.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../widgets/rounded_btn.dart';

class OrderStatusBoxWidget extends StatelessWidget {
  final OrderItem orderItem;

  const OrderStatusBoxWidget({Key? key, required this.orderItem}) : super(key: key);

  // final buttonKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: orderItem.possibleStatuses.isNotEmpty ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(
        onTapDown: (details) {
          if (orderItem.possibleStatuses.isNotEmpty) {
            final RenderBox buttonRenderBox = context.findRenderObject() as RenderBox;
            final Offset position = buttonRenderBox.localToGlobal(Offset.zero);
            showMenu(
                elevation: 10,
                context: context,
                position: RelativeRect.fromLTRB(
                  position.dx,
                  position.dy + buttonRenderBox.size.height,
                  position.dx + buttonRenderBox.size.width,
                  position.dy + buttonRenderBox.size.height,
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                color: Colors.white,
                surfaceTintColor: Colors.white,
                items: orderItem.possibleStatuses
                    .map(
                      (e) => PopupMenuItem(
                        enabled: false,
                        padding: const EdgeInsets.all(8),
                        child: Center(
                          child: RoundedBtnWidget(
                            onTap: () {
                              context.read<OrderManagementBloc>().add(ChangeOrderStatusEvent(
                                  orderItem: orderItem, requestedStatusIsCompleted: e.isCompleted, requestedStatusId: e.id));
                              Get.back();
                            },
                            btnText: e.name,
                            width: 100,
                            btnMargin: const EdgeInsets.all(0),
                            height: 30,
                            borderRadios: 30.0,
                            bgColor: AppColors.black,
                            btnTextColor: Colors.white,
                          ),
                        ),
                      ),
                    )
                    .toList());
          }
        },
        child: Center(
          child: Container(

            width: 170,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            decoration: BoxDecoration(
              color:
                  orderItem.possibleStatuses.isNotEmpty ? context.colorScheme.primaryColor : context.colorScheme.primaryColorDark,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.white),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  orderItem.queueStatusName,
                  textAlign: TextAlign.center,
                  style: context.textTheme.labelLarge?.copyWith(color: Colors.white),
                ),
                if (orderItem.possibleStatuses.isNotEmpty)
                  SvgPicture.asset(
                    Assets.iconsDropDownArrow,
                    color: Colors.white,
                    height: 15,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
