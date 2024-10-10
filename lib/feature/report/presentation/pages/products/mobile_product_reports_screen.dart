import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/report/data/models/entity/products_reports.dart';
import 'package:merchant_dashboard/feature/report/presentation/blocs/products/product_reports_cubit.dart';
import 'package:merchant_dashboard/utils/mixins/mixins.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../widgets/date_picker_widget/date_range_picker_widget.dart';
import '../../../../../widgets/loading_widget.dart';
import '../../../../../widgets/rounded_btn.dart';
import '../../../../../widgets/shimmer.dart';
import '../../widgets/mobile/product/mobile_product_reports_list_widget.dart';

class MobileProductReportsScreen extends StatelessWidget with DownloadUtils {
  const MobileProductReportsScreen({super.key});

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
              Text(
                S.current.filter,
                style: context.textTheme.titleLarge,
              ),
              Row(
                children: [
                  DateRangePickerWidget(
                    initialFromDate: context.select<ProductReportsCubit, String>((value) => value.fromDate),
                    initialToDate: context.select<ProductReportsCubit, String>((value) => value.toDate),
                    onDateRangeChanged: (String fromDate, String toDate) {
                      context.read<ProductReportsCubit>().getProducts(rFromDate: fromDate, rToDate: toDate);
                    },
                  )
                ],
              ),
            ],
          ),
          Center(
            child: BlocConsumer<ProductReportsCubit, ProductReportsState>(
              listener: (context, state) {
                if (state is GetDownloadLinkState && state.link != null) {
                  openLink(url: state.link!);
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
          ),
          Expanded(
            child: BlocBuilder<ProductReportsCubit, ProductReportsState>(
              builder: (context, state) {
                if (state is GetProductsLoadingState) {
                  return ShimmerWidget(width: Get.width, height: Get.height);
                }
                return MobileProductReportsListWidge(
                  getProducts: (getMore) => context.read<ProductReportsCubit>().getProducts(getMore: getMore),
                  products: context.select<ProductReportsCubit, List<ProductItemReport>>(
                    (value) => value.productsPagination.listItems,
                  ),
                  hasMore: context.select<ProductReportsCubit, bool>((value) => value.productsPagination.hasMore),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
