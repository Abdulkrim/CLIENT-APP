import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/transaction/data/models/entity/transaction.dart';
import 'package:merchant_dashboard/feature/transaction/presentation/blocs/transaction_bloc.dart';
import 'package:merchant_dashboard/feature/transaction/presentation/widgets/desktop/desktop_transaction_filters_widget.dart';
import 'package:merchant_dashboard/feature/transaction/presentation/widgets/desktop/desktop_transaction_table_widget.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/scrollable_widget.dart';
import 'package:merchant_dashboard/widgets/shimmer.dart';

import '../../../../widgets/loading_widget.dart';
import '../../../../widgets/rounded_btn.dart';
import '../../../main_screen/presentation/blocs/menu_drawer/menu_drawer_cubit.dart';

class TransactionDesktopWidget extends StatefulWidget {
  const TransactionDesktopWidget({Key? key}) : super(key: key);

  @override
  State<TransactionDesktopWidget> createState() => _TransactionDesktopWidgetState();
}

class _TransactionDesktopWidgetState extends State<TransactionDesktopWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        context.read<TransactionBloc>().add(const GetAllTransactionsEvent(getMore: true));
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  context.watch<MenuDrawerCubit>().selectedPageContent.text,
                  style: context.textTheme.titleLarge,
                ),
                context.sizedBoxWidthMicro,
                IconButton(
                    onPressed: () {
                      context.read<TransactionBloc>().add(const GetAllTransactionsEvent());
                    },
                    icon: const Icon(
                      Icons.refresh_rounded,
                      color: Colors.black,
                    )),
              ],
            ),
            BlocBuilder<TransactionBloc, TransactionState>(
              builder: (context, state) {
                return (state is GetDownloadLinkLoadingState)
                    ? const LoadingWidget()
                    : RoundedBtnWidget(
                    onTap: () => context.read<TransactionBloc>().add(const GetDownloadLink()),
                    height: 35,
                    btnText: S.current.downloadReportOfTrans,
                    btnIcon: const Icon(
                      Icons.downloading_rounded,
                      color: Colors.white,
                    ));
              },
            ),
          ],
        ),
        context.sizedBoxHeightExtraSmall,
        const DesktopTransactionFiltersWidget(),
        context.sizedBoxHeightExtraSmall,
        Expanded(
          child: BlocBuilder<TransactionBloc, TransactionState>(
            builder: (context, state) {
              if (state is GetAllTransactionsLoadingState) {
                return ShimmerWidget(width: Get.width, height: Get.height);
              }
              if (state is WrongDateFilterRangeEnteredState) return const SizedBox();

              return ScrollableWidget(
                scrollController: _scrollController,
                child: Column(
                  children: [
                    DesktopTransactionTableWidget(
                        transactions: context.select<TransactionBloc, List<Transaction>>(
                              (value) => value.transactionsPagination.listItems,
                        )),
                    Visibility(
                        visible: context.select<TransactionBloc, bool>(
                                (value) => value.transactionsPagination.hasMore) &&
                            state is! GetTransactionFailedState,
                        child: const CupertinoActivityIndicator()),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
