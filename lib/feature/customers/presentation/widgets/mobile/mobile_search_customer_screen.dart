import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/customers/data/models/entity/customer_orders.dart';
import 'package:merchant_dashboard/feature/transaction/presentation/widgets/mobile/mobile_transaction_list_widget.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/custom_tabbar/cutsom_top_tabbar.dart';
import 'package:merchant_dashboard/widgets/custom_tabbar/tab_item.dart';
import 'package:merchant_dashboard/widgets/empty_box_widget.dart';
import 'package:merchant_dashboard/widgets/loading_widget.dart';
import 'package:merchant_dashboard/widgets/search_box_widget.dart';

import '../../../../../theme/theme_data.dart';
import '../../../../../widgets/shimmer.dart';
import '../../../../transaction/data/models/entity/transaction.dart';
import '../../blocs/customers/customer_bloc.dart';
import 'customer_orders_list_widget.dart';

class MobileSearchCustomerScreen extends StatefulWidget {
  const MobileSearchCustomerScreen({super.key, this.phoneNumber});

  final String? phoneNumber;

  @override
  State<MobileSearchCustomerScreen> createState() => _MobileSearchCustomerScreenState();
}

class _MobileSearchCustomerScreenState extends State<MobileSearchCustomerScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                context.sizedBoxHeightSmall,
                Row(
                  children: [
                    IconButton(
                        onPressed: () => Get.back(),
                        padding: EdgeInsets.zero,
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.black,
                        )),
                    Expanded(
                      child: SearchBoxWidget(
                        searchTextController: _searchController,
                        onSearchTapped: (text) {
                          if ((text ?? '').length > 4) {
                            context.read<CustomerBloc>().add(SearchForCustomer(text!));
                            _tabController.animateTo(0);
                          }
                        },
                        hint: '+971234567891',
                      ),
                    ),
                  ],
                ),
                context.sizedBoxHeightExtraSmall,
                BlocBuilder<CustomerBloc, CustomerState>(
                    buildWhen: (previous, current) =>
                        current is GetCustomerLoadingState ||
                        current is SearchCustomerFailedState ||
                        current is SearchCustomerSuccessState,
                    builder: (context, state) {
                      if (state is GetCustomerLoadingState) {
                        return const LoadingWidget();
                      }
                      return Visibility(
                        visible: context.select<CustomerBloc, bool>((value) => value.foundCustomer != null),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: AppColors.lightGray,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(text: 'Name: ', style: context.textTheme.bodyMedium),
                                TextSpan(
                                    text: context.select<CustomerBloc, String>(
                                        (value) => value.foundCustomer?.name ?? ''),
                                    style:
                                        context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                              ])),
                              context.sizedBoxHeightMicro,
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(text: '${S.current.phoneNumber} : ', style: context.textTheme.bodyMedium),
                                TextSpan(
                                    text: context.select<CustomerBloc, String>(
                                        (value) => value.foundCustomer?.phoneNumber ?? ''),
                                    style:
                                        context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                              ])),
                              context.sizedBoxHeightMicro,
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(text: '${S.current.address} : ', style: context.textTheme.bodyMedium),
                                TextSpan(
                                    text: context.select<CustomerBloc, String>(
                                        (value) => value.foundCustomer?.customerAddress?.fullAddress ?? ''),
                                    style:
                                        context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                              ])),
                              context.sizedBoxHeightMicro,
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(text: '${S.current.email} : ', style: context.textTheme.bodyMedium),
                                TextSpan(
                                    text: context.select<CustomerBloc, String>(
                                        (value) => value.foundCustomer?.email ?? ''),
                                    style:
                                        context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                              ])),
                            ],
                          ),
                        ),
                      );
                    }),
                context.sizedBoxHeightExtraSmall,
                Visibility(
                  visible: context.select<CustomerBloc, bool>(
                          (value) => value.transactionsPagination.listItems.isNotEmpty) ||
                      context
                          .select<CustomerBloc, bool>((value) => value.ordersPagination.listItems.isNotEmpty),
                  child: CustomTopTabbar(tabs: [
                    TabItem(S.current.orders, (index) {
                      _tabController.animateTo(0);
                    }),
                    TabItem(S.current.transactions, (index) {
                      _tabController.animateTo(1);
                    }),
                  ]),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      BlocBuilder<CustomerBloc, CustomerState>(
                        builder: (context, state) {
                          if (state is GetCustomerOrdersLoadingState) {
                            return ShimmerWidget(width: Get.width, height: Get.height);
                          } else if (context
                              .select<CustomerBloc, bool>((value) => value.ordersPagination.isQuiteEmpty)) {
                            return const Center(
                                child: EmptyBoxWidget(
                              showBtn: false,
                              descriptionText: '',
                            ));
                          }

                          return CustomerOrdersListWidget(
                            getOrders: (getMore) =>
                                context.read<CustomerBloc>().add(GetCustomerOrders(getMore: getMore)),
                            orders: context.select<CustomerBloc, List<CustomerOrder>>(
                              (value) => value.ordersPagination.listItems,
                            ),
                            hasMore:
                                context.select<CustomerBloc, bool>((value) => value.ordersPagination.hasMore),
                          );
                        },
                      ),
                      BlocBuilder<CustomerBloc, CustomerState>(
                        builder: (context, state) {
                          if (state is GetCustomerTransactionsLoadingState) {
                            return ShimmerWidget(width: Get.width, height: Get.height);
                          } else if (context.select<CustomerBloc, bool>(
                              (value) => value.transactionsPagination.isQuiteEmpty)) {
                            return const Center(
                                child: EmptyBoxWidget(
                              showBtn: false,
                              descriptionText: '',
                            ));
                          }
                          return MobileTransactionListWidget(
                            getTransactions: (getMore) =>
                                context.read<CustomerBloc>().add(GetCustomerTransactions(getMore: getMore)),
                            transactions: context.select<CustomerBloc, List<Transaction>>(
                                (value) => value.transactionsPagination.listItems),
                            hasMore: context
                                .select<CustomerBloc, bool>((value) => value.transactionsPagination.hasMore),
                          );
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
            Center(
              child: BlocBuilder<CustomerBloc, CustomerState>(
                builder: (context, state) {
                  return Visibility(
                    visible: state is SearchCustomerFailedState,
                    child: const EmptyBoxWidget(
                      showBtn: false,
                      descriptionText: '',
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
