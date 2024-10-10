import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/date_picker_widget/date_range_picker_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../utils/mixins/mixins.dart';
import '../../../../../widgets/loading_widget.dart';
import '../../../../../widgets/rounded_btn.dart';
import '../../../../../widgets/scrollable_widget.dart';
import '../../../../../widgets/shimmer.dart';
import '../../../data/models/entity/products_reports.dart';
import '../../blocs/products/product_reports_cubit.dart';
import '../../widgets/desktop/products/desktop_products_report_table_widget.dart';

class DesktopProductReportsScreen extends StatefulWidget with DownloadUtils {
  DesktopProductReportsScreen({super.key});

  @override
  State<DesktopProductReportsScreen> createState() => _DesktopProductReportsScreenState();
}

class _DesktopProductReportsScreenState extends State<DesktopProductReportsScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.offset >= _scrollController.position.maxScrollExtent && !_scrollController.position.outOfRange) {
        context.read<ProductReportsCubit>().getProducts(getMore: true);
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
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                child: DateRangePickerWidget(
                  height: 50,
                  width: 450,
                  initialFromDate: context.select<ProductReportsCubit, String>((value) => value.fromDate),
                  initialToDate: context.select<ProductReportsCubit, String>((value) => value.toDate),
                  onDateRangeChanged: (String fromDate, String toDate) {
                    context.read<ProductReportsCubit>().getProducts(rFromDate: fromDate, rToDate: toDate);
                  },
                ),
              ),
              BlocConsumer<ProductReportsCubit, ProductReportsState>(
                listener: (context, state) {
                  if (state is GetDownloadLinkState && state.link != null) {
                    launchUrl(Uri.parse(state.link!));
                  }
                },
                builder: (context, state) {
                  return (state is GetDownloadLinkLoadingState)
                      ? const LoadingWidget()
                      : RoundedBtnWidget(
                          onTap: () => context.read<ProductReportsCubit>().getProductsReportsDownloadLink(),
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
          Expanded(
            child: BlocBuilder<ProductReportsCubit, ProductReportsState>(
              builder: (context, state) {
                if (state is GetProductsLoadingState) {
                  return ShimmerWidget(width: Get.width, height: Get.height);
                }

                return ScrollableWidget(
                  scrollController: _scrollController,
                  child: Column(
                    children: [
                      DesktopProductsReportTableWidget(
                          products: context.select<ProductReportsCubit, List<ProductItemReport>>(
                        (value) => value.productsPagination.listItems,
                      )),
                      Visibility(
                          visible: context.select<ProductReportsCubit, bool>((value) => value.productsPagination.hasMore) &&
                              state is! GetProductsFailedState,
                          child: const CupertinoActivityIndicator()),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
