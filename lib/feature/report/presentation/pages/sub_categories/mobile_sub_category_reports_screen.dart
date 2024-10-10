import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/report/data/models/entity/sub_categories_reports.dart';
import 'package:merchant_dashboard/utils/mixins/mixins.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../widgets/date_picker_widget/date_range_picker_widget.dart';
import '../../../../../widgets/loading_widget.dart';
import '../../../../../widgets/rounded_btn.dart';
import '../../../../../widgets/shimmer.dart';
import '../../blocs/sub_categories/sub_category_reports_cubit.dart';
import '../../widgets/mobile/sub_category/sub_category_reports_list_widget.dart';

class MobileSubCategoryReportsScreen extends StatelessWidget with DownloadUtils {
  const MobileSubCategoryReportsScreen({super.key});

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
                    initialFromDate: context.select<SubCategoryReportsCubit, String>((value) => value.fromDate),
                    initialToDate: context.select<SubCategoryReportsCubit, String>((value) => value.toDate),
                    onDateRangeChanged: (String fromDate, String toDate) {
                      context.read<SubCategoryReportsCubit>().getSubCategories(rFromDate: fromDate, rToDate: toDate);
                    },
                  )
                ],
              ),
            ],
          ),
          Center(
            child: BlocConsumer<SubCategoryReportsCubit, SubCategoryReportsState>(
              listener: (context, state) {
                if (state is GetDownloadLinkState && state.link != null) {
                  openLink(url: state.link!);
                }
              },
              builder: (context, state) {
                return (state is GetDownloadLinkLoadingState)
                    ? const LoadingWidget()
                    : RoundedBtnWidget(
                        onTap: () => context.read<SubCategoryReportsCubit>().getSubCategoriesReportsDownloadLink(),
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
            child: BlocBuilder<SubCategoryReportsCubit, SubCategoryReportsState>(
              builder: (context, state) {
                if (state is GetSubCategoriesLoadingState) {
                  return ShimmerWidget(width: Get.width, height: Get.height);
                }
                return MobileSubCategoryReportsListWidge(
                  getSubCategories: (getMore) => context.read<SubCategoryReportsCubit>().getSubCategories(getMore: getMore),
                  subCategories: context.select<SubCategoryReportsCubit, List<SubCategoryItemReport>>(
                    (value) => value.subCategoriesPagination.listItems,
                  ),
                  hasMore: context.select<SubCategoryReportsCubit, bool>((value) => value.subCategoriesPagination.hasMore),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
