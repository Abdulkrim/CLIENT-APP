import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchant_dashboard/feature/cashiers/data/models/entity/cashier.dart';
import 'package:merchant_dashboard/feature/cashiers/presentation/blocs/cashier_bloc.dart';
import 'package:merchant_dashboard/widgets/profile_generator_image_widget.dart';
import 'package:merchant_dashboard/feature/cashiers/presentation/widgets/cashier_details_widget.dart';
import 'package:merchant_dashboard/theme/theme_data.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/app_ink_well_widget.dart';
import 'package:merchant_dashboard/widgets/app_status_toggle_widget.dart';
import 'package:get/get.dart';

class MobileCashierListWidget extends StatefulWidget {
  final List<Cashier> cashiers;
  final bool hasMore;

  const MobileCashierListWidget({
    Key? key,
    required this.cashiers,
    required this.hasMore,
  }) : super(key: key);

  @override
  State<MobileCashierListWidget> createState() => _MobileCashierListWidgetState();
}

class _MobileCashierListWidgetState extends State<MobileCashierListWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        context.read<CashierBloc>().add(const GetAllCashiersEvent(getMore: true));
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      primary: false,
      itemCount: (widget.hasMore) ? widget.cashiers.length + 1 : widget.cashiers.length,
      itemBuilder: (context, index) => (index < widget.cashiers.length)
          ? MobileCashierItemWidget(cashier: widget.cashiers[index])
          : const CupertinoActivityIndicator(),
    );
  }
}

class MobileCashierItemWidget extends StatefulWidget {
  final Cashier cashier;

  const MobileCashierItemWidget({
    Key? key,
    required this.cashier,
  }) : super(key: key);

  @override
  State<MobileCashierItemWidget> createState() => _MobileCashierItemWidgetState();
}

class _MobileCashierItemWidgetState extends State<MobileCashierItemWidget> {
  late bool cashierStatus = widget.cashier.status;

  @override
  Widget build(BuildContext context) {
    return AppInkWell(
      onTap: () {
        Get.dialog(
          BlocProvider.value(
            value: BlocProvider.of<CashierBloc>(context),
            child: CashierDetailsWidget(
              cashier: widget.cashier,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: AppColors.lightGray,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(9),
        ),
        child: Row(
          children: [
            ProfileGeneratorImageWidget(itemLabel: widget.cashier.name, itemColorIndex: 3),
            context.sizedBoxWidthSmall,
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Text(widget.cashier.name,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold))),
                  ],
                ),
                context.sizedBoxHeightMicro,
                Row(
                  children: [
                    Expanded(
                        child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                          color: AppColors.transparentPrimaryColor,
                          borderRadius: const BorderRadius.all(Radius.circular(30))),
                      child: Center(
                        child: Text(
                          widget.cashier.cashierRole,
                          textAlign: TextAlign.center,
                          style: context.textTheme.labelSmall?.copyWith(
                              color: context.colorScheme.primaryColor, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )),
                    AppSwitchToggle(
                      currentStatus: cashierStatus,
                      onStatusChanged: (status) {
                        context.read<CashierBloc>().add(EditCashierRequestEvent(
                            cashierId: widget.cashier.id,
                            isActive: status,
                            cashierRoleName: widget.cashier.cashierRole,
                            cashierName: widget.cashier.name,
                            cashierRoleId: widget.cashier.cashierRoleId));
                        setState(() {
                          cashierStatus = status;
                        });
                      },
                    ),
                  ],
                )
              ],
            )),
          ],
        ),
      ),
    );
  }
}
