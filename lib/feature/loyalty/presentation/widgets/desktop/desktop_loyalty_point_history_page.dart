import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/loyalty/presentation/blocs/loyalty_point/loyalty_point_history_cubit.dart';
import 'package:merchant_dashboard/generated/assets.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/loading_widget.dart';
import 'package:merchant_dashboard/widgets/rounded_btn.dart';
import 'package:merchant_dashboard/widgets/scrollable_widget.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../widgets/date_picker_widget/date_range_picker_widget.dart';
import 'desktop_loyalty_history_table_widget.dart';

class DesktopLoyaltyPointHistoryPage extends StatefulWidget {
  const DesktopLoyaltyPointHistoryPage(
      {super.key, required this.onBackTap, required this.onPointHistoryTap, required this.customerId});

  final String customerId;
  final Function() onBackTap;
  final Function() onPointHistoryTap;

  @override
  State<DesktopLoyaltyPointHistoryPage> createState() => _DesktopLoyaltyPointHistoryPageState();
}

class _DesktopLoyaltyPointHistoryPageState extends State<DesktopLoyaltyPointHistoryPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    context.read<LoyaltyPointHistoryCubit>().getLoyaltyPointHistory(customerId: widget.customerId);

    _scrollController.addListener(() {
      if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        context
            .read<LoyaltyPointHistoryCubit>()
            .getLoyaltyPointHistory(getMore: true, customerId: widget.customerId);
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
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  onPressed: widget.onBackTap,
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  )),
              context.sizedBoxWidthMicro,
              Text(
                S.current.loyaltyPointHistory,
                style: context.textTheme.titleLarge,
              ),
            ],
          ),
          Expanded(
              child: Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                DateRangePickerWidget(
                  height: 50,
                  width: 350,
                  initialFromDate:
                      context.select<LoyaltyPointHistoryCubit, String>((value) => value.fromDate),
                  initialToDate: context.select<LoyaltyPointHistoryCubit, String>((value) => value.toDate),
                  onDateRangeChanged: (String fromDate, String toDate) {
                    context.read<LoyaltyPointHistoryCubit>().getLoyaltyPointHistory(
                        customerId: widget.customerId, rFromDate: fromDate, rToDate: toDate);
                  },
                ),
                RoundedBtnWidget(
                    onTap: widget.onPointHistoryTap,
                    btnText: S.current.viewPoints,
                    btnPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                    btnIcon: SvgPicture.asset(Assets.iconsViewPoints))
              ],
            ),
          )),
        ],
      ),
      context.sizedBoxHeightExtraSmall,
      Expanded(child: BlocBuilder<LoyaltyPointHistoryCubit, LoyaltyPointHistoryState>(
        builder: (context, state) {
          return (state is GetLoyaltyPointHistoryState && state.isLoading)
              ? const LoadingWidget()
              : ScrollableWidget(
                  scrollController: _scrollController,
                  child: Column(
                    children: [
                      DesktopLoyaltyHistoryTableWidget(
                        onLoyaltyInformationTapped: (point) {},
                        points: context
                            .select((LoyaltyPointHistoryCubit bloc) => bloc.pointsPagination.listItems),
                      ),
                      Visibility(
                          visible: context.select<LoyaltyPointHistoryCubit, bool>(
                                  (value) => value.pointsPagination.hasMore) &&
                              (state is GetLoyaltyPointHistoryState && state.errorMessage == null),
                          child: const CupertinoActivityIndicator()),
                    ],
                  ),
                );
        },
      ))
    ]);
  }
}
