import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/date_picker_widget/date_range_picker_widget.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../utils/mixins/mixins.dart';
import '../../../../../widgets/loading_widget.dart';
import '../../../../../widgets/rounded_btn.dart';
import '../../../../../widgets/scrollable_widget.dart';
import '../../../../../widgets/shimmer.dart';
import '../../../data/models/entity/sub_categories_reports.dart';
import '../../blocs/sub_categories/sub_category_reports_cubit.dart';
import '../../widgets/desktop/sub_categories/desktop_sub_category_report_table_widget.dart';

class DesktopSubCategoryReportsScreen extends StatefulWidget {
  const DesktopSubCategoryReportsScreen({super.key});

  @override
  State<DesktopSubCategoryReportsScreen> createState() => _DesktopSubCategoryReportsScreenState();
}

class _DesktopSubCategoryReportsScreenState extends State<DesktopSubCategoryReportsScreen> with DownloadUtils {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.offset >= _scrollController.position.maxScrollExtent && !_scrollController.position.outOfRange) {
        context.read<SubCategoryReportsCubit>().getSubCategories(getMore: true);
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
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              child: DateRangePickerWidget(
                height: 50,
                width: 450,
                initialFromDate: context.select<SubCategoryReportsCubit, String>((value) => value.fromDate),
                initialToDate: context.select<SubCategoryReportsCubit, String>((value) => value.toDate),
                onDateRangeChanged: (String fromDate, String toDate) {
                  context.read<SubCategoryReportsCubit>().getSubCategories(rFromDate: fromDate, rToDate: toDate);
                },
              ),
            ),
            BlocConsumer<SubCategoryReportsCubit, SubCategoryReportsState>(
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
          ],
        ),
        context.sizedBoxHeightExtraSmall,
        Expanded(
          child: BlocBuilder<SubCategoryReportsCubit, SubCategoryReportsState>(
            builder: (context, state) {
              if (state is GetSubCategoriesLoadingState) {
                return ShimmerWidget(width: Get.width, height: Get.height);
              }

              return ScrollableWidget(
                scrollController: _scrollController,
                child: Column(
                  children: [
                    DesktopSubCategoriesReportTableWidget(
                        subCategories: context.select<SubCategoryReportsCubit, List<SubCategoryItemReport>>(
                      (value) => value.subCategoriesPagination.listItems,
                    )),
                    Visibility(
                        visible:
                            context.select<SubCategoryReportsCubit, bool>((value) => value.subCategoriesPagination.hasMore) &&
                                state is! GetSubCategoriesFailedState,
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
