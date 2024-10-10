import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/cashiers/data/models/entity/cashier.dart';
import 'package:merchant_dashboard/feature/cashiers/presentation/blocs/cashier_bloc.dart';
import 'package:merchant_dashboard/feature/cashiers/presentation/widgets/cashier_details_widget.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/widgets/profile_generator_image_widget.dart';
import 'package:merchant_dashboard/theme/theme_data.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/app_ink_well_widget.dart';
import 'package:merchant_dashboard/widgets/app_status_toggle_widget.dart';
import 'package:merchant_dashboard/widgets/scrollable_widget.dart';

class DesktopCashiersListWidget extends StatefulWidget {
  final List<Cashier> cashiers;

  const DesktopCashiersListWidget({
    Key? key,
    required this.cashiers,
  }) : super(key: key);

  @override
  State<DesktopCashiersListWidget> createState() => _DesktopCashiersListWidgetState();
}

class _DesktopCashiersListWidgetState extends State<DesktopCashiersListWidget> {
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
    return ScrollableWidget(
      scrollController: _scrollController,
      child: Column(
        children: [
          LayoutBuilder(builder: (context, constraints) {
            int crossAxisCount = (constraints.maxWidth / 220).floor();

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 300,
                   crossAxisSpacing: 8, mainAxisSpacing: 8),
              itemCount: widget.cashiers.length,
              itemBuilder: (context, index) => _DesktopCashierItemWidget(cashier: widget.cashiers[index]),
            );
          }),
          Visibility(
              visible: context.select<CashierBloc, bool>((value) => value.cashierPagination.hasMore),
              child: const CupertinoActivityIndicator()),
        ],
      ),
    );
  }
}

class _DesktopCashierItemWidget extends StatefulWidget {
  final Cashier cashier;

  const _DesktopCashierItemWidget({required this.cashier});

  @override
  State<_DesktopCashierItemWidget> createState() => _DesktopCashierItemWidgetState();
}

class _DesktopCashierItemWidgetState extends State<_DesktopCashierItemWidget> {
  late bool cashierStatus = widget.cashier.status;

  @override
  Widget build(BuildContext context) {
    return AppInkWell(
      hoverColor: Colors.transparent,
      onTap: () {
        Get.dialog(BlocProvider.value(
          value: BlocProvider.of<CashierBloc>(context),
          child: CashierDetailsWidget(
            cashier: widget.cashier,
          ),
        ));
      },
      child: Container(

        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: AppColors.lightGray,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(9),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                cashierStatus ? S.current.active :S.current.inActive,
                style: context.textTheme.titleSmall,
              ),
            ),
            context.sizedBoxHeightExtraSmall,
            ProfileGeneratorImageWidget(itemLabel: widget.cashier.name, itemColorIndex: 3),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(widget.cashier.name,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              ),
            ),
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
                      style: context.textTheme.labelSmall
                          ?.copyWith(color: context.colorScheme.primaryColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                )),
                AppSwitchToggle(
                  label: '',
                  currentStatus: cashierStatus,
                  onStatusChanged: (status) {
                    context.read<CashierBloc>().add(EditCashierRequestEvent(
                        cashierId: widget.cashier.id,
                        isActive: status,
                        cashierName: widget.cashier.name,
                        cashierRoleName: widget.cashier.cashierRole,
                        cashierRoleId: widget.cashier.cashierRoleId));
                    setState(() {
                      cashierStatus = status;
                    });
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
