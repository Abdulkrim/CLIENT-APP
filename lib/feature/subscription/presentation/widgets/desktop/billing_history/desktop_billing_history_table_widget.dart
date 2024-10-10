import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:merchant_dashboard/feature/subscription/data/models/entity/billing_history.dart';
import 'package:merchant_dashboard/generated/assets.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/loading_widget.dart';
import 'package:merchant_dashboard/widgets/rounded_btn.dart';

import '../../../../../../utils/mixins/mixins.dart';
import '../../../blocs/billing_history/cubit/billing_history_cubit.dart';

class DesktopBillingHistoryTableWidget extends StatelessWidget with DownloadUtils {
  final List<BillingHistoryItem> billings;

  const DesktopBillingHistoryTableWidget({
    Key? key,
    required this.billings,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          columnWidths: const {6: FractionColumnWidth(.2)},
          children: [
            context.headerTableRow([
              S.current.invoiceNo,
              S.current.subscriptionDate,
              S.current.payment,
              S.current.businessName,
              S.current.amount,
              S.current.status,
              '',
            ]),
            ...billings
                .map((e) => TableRow(children: [
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            e.invoiceId,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      TableCell(
                        child: Text(
                          e.paidOn,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      TableCell(
                        child: Text(
                          e.paymentModeName,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      TableCell(
                        child: Text(
                          e.branchSubscription,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      TableCell(
                        child: Text(
                          '${e.amount} ${e.currency}',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      TableCell(
                        child: Text(
                          e.paymentStatusName,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: e.isPending
                                  ? Colors.red
                                  : e.isCompleted
                                      ? context.colorScheme.primaryColor
                                      : null),
                        ),
                      ),
                      TableCell(
                          child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Visibility(
                            visible: e.isPending,
                            child: RoundedBtnWidget(
                              onTap: () {
                                context.read<BillingHistoryCubit>().rePaymentRequest(e.id);
                              },
                              btnText: S.current.pay,
                              borderRadios: 40,
                              btnPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            ),
                          ),
                          IconButton(
                              onPressed: () => openLink(url: e.downloadUrl),
                              icon: SvgPicture.asset(
                                Assets.iconsIcDownload,
                                width: 18,
                              ))
                        ],
                      )),
                    ]))
                .toList()
          ],
        ),
        BlocBuilder<BillingHistoryCubit, BillingHistoryState>(
            builder: (context, state) => Visibility(
                visible: state is RePaymentRequestState && state.isLoading, child: const LoadingWidget())),
      ],
    );
  }
}
