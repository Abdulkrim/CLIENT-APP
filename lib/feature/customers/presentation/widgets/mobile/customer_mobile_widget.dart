import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/widgets/loading_widget.dart';

import '../../../../../generated/assets.dart';
import '../../../../../widgets/rounded_btn.dart';
import '../../../../../widgets/search_box_widget.dart';
import '../../../../main_screen/presentation/blocs/menu_drawer/menu_drawer_cubit.dart';
import '../../../../region/presentation/blocs/region_cubit.dart';
import '../../../data/models/entity/customer_list_info.dart';
import '../../blocs/customers/customer_bloc.dart';
import '../customer_details_dialog.dart';
import 'mobile_customer_list_wiget.dart';

class CustomerMobileWidget extends StatefulWidget {
  const CustomerMobileWidget({super.key});

  @override
  State<CustomerMobileWidget> createState() => _CustomerMobileWidgetState();
}

class _CustomerMobileWidgetState extends State<CustomerMobileWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        context.read<CustomerBloc>().add(const GetAllCustomersEvent(getMore: true));
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
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  context.watch<MenuDrawerCubit>().selectedPageContent.text,
                  style: context.textTheme.titleLarge,
                ),
              ),
              context.sizedBoxWidthExtraSmall,
              RoundedBtnWidget(
                onTap: () {
                  Get.to(MultiBlocProvider(
                    providers: [
                      BlocProvider<CustomerBloc>.value(value: BlocProvider.of<CustomerBloc>(context)),
                      BlocProvider<RegionCubit>.value(value: BlocProvider.of<RegionCubit>(context)),
                    ],
                    child: const CustomerDetailsDialog(),
                  ));
                },
                btnText: S.current.addCustomer,
                btnIcon: SvgPicture.asset(Assets.iconsCustomersIcon, color: Colors.white, height: 20),
                wrapWidth: true,
                btnPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              ),
            ],
          ),
          context.sizedBoxHeightExtraSmall,
          SearchBoxWidget(
              hint: S.current.searchCustomer,
              onSearchTapped: (String? text) =>
                  context.read<CustomerBloc>().add(GetAllCustomersEvent.refresh(searchText: text))),
          Expanded(
              child: BlocConsumer<CustomerBloc, CustomerState>(
                  listener: (context, state) {
                    /*  if (state is UpdateCustomerState && state.message.isNotEmpty) {  
                      Get.back();
                      context.showCustomeAlert(state.message, SnackBarType.success);
                      context.read<CustomerBloc>().add(const GetAllCustomersEvent(getMore: false));
                    } else if (state is UpdateCustomerState && state.errorMessage != null) {
                      context.showCustomeAlert(state.errorMessage!, SnackBarType.error);
                    }*/
                  },
                  builder: (context, state) => (state is GetCustomerLoadingState)
                      ? const LoadingWidget()
                      : MobileCustomerListWidget(
                          customers: context.select<CustomerBloc, List<Customer>>(
                              (value) => value.customerPagination.listItems),
                          hasMore:
                              context.select<CustomerBloc, bool>((value) => value.customerPagination.hasMore),
                          getCustomers: (getMore) =>
                              context.read<CustomerBloc>().add(GetAllCustomersEvent(getMore: getMore)),
                        )))
        ],
      ),
    );
  }
}
