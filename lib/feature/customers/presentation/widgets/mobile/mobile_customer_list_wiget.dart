import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/customers/presentation/blocs/credit_history/credit_history_cubit.dart';
import 'package:merchant_dashboard/generated/assets.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/theme/theme_data.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/rounded_btn.dart';

import '../../../../../widgets/profile_generator_image_widget.dart';
import '../../../../region/presentation/blocs/region_cubit.dart';
import '../../../data/models/entity/customer_list_info.dart';
import '../../blocs/customers/customer_bloc.dart';
import '../customer_details_dialog.dart';
import 'mobile_customer_information_screen.dart';

class MobileCustomerListWidget extends StatefulWidget {
  const MobileCustomerListWidget({
    Key? key,
    required this.customers,
    required this.hasMore,
    required this.getCustomers,
  }) : super(key: key);

  final Function(bool getMore) getCustomers;
  final List<Customer> customers;
  final bool hasMore;

  @override
  State<MobileCustomerListWidget> createState() => _MobileCustomerListWidgetState();
}

class _MobileCustomerListWidgetState extends State<MobileCustomerListWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.offset >= _scrollController.position.maxScrollExtent && !_scrollController.position.outOfRange) {
        widget.getCustomers(true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        widget.getCustomers(false);
        return Future<void>.delayed(const Duration(seconds: 2));
      },
      child: ListView.builder(
        controller: _scrollController,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        primary: false,
        itemCount: (widget.hasMore && widget.customers.isNotEmpty) ? widget.customers.length + 1 : widget.customers.length,
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemBuilder: (context, index) => (index < widget.customers.length)
            ? _CustomerItemWidget(customer: widget.customers[index])
            : const CupertinoActivityIndicator(),
      ),
    );
  }
}

class _CustomerItemWidget extends StatelessWidget {
  const _CustomerItemWidget({required this.customer});

  final Customer customer;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: AppStyles.boxShadow,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              ProfileGeneratorImageWidget(
                itemLabel: customer.name,
                width: 50,
              ),
              context.sizedBoxWidthExtraSmall,
              Expanded(
                child: RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: '${S.current.customerName} \n', style: context.textTheme.bodyMedium?.copyWith(color: Colors.grey)),
                  TextSpan(text: customer.name, style: context.textTheme.bodyMedium),
                ])),
              ),
              IconButton(
                  onPressed: () =>  Get.to(MultiBlocProvider(
                    providers: [
                      BlocProvider<CustomerBloc>.value(value: BlocProvider.of<CustomerBloc>(context)),
                      BlocProvider<RegionCubit>.value(value: BlocProvider.of<RegionCubit>(context)),
                    ],
                    child: CustomerDetailsDialog(customer: customer),
                  )),
                  icon: SvgPicture.asset(
                    Assets.iconsIcEdit,
                  )),
            ],
          ),
          context.sizedBoxHeightExtraSmall,
          Row(
            children: [
              Expanded(
                child: RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: '${S.current.customerType} \n', style: context.textTheme.bodySmall?.copyWith(color: Colors.grey)),
                  TextSpan(text: customer.customerTypeName, style: context.textTheme.bodyMedium),
                ])),
              ),
              context.sizedBoxWidthMicro,
              Expanded(
                child: RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: '${S.current.creditBalance} \n', style: context.textTheme.bodySmall?.copyWith(color: Colors.grey)),
                  TextSpan(text: customer.balanceWithCurrency, style: context.textTheme.bodyMedium),
                ])),
              ),
              Expanded(
                child: RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: '${S.current.phoneNumber} \n', style: context.textTheme.bodySmall?.copyWith(color: Colors.grey)),
                  TextSpan(text: customer.phoneNumberWithoutPrefix, style: context.textTheme.bodyMedium),
                ])),
              ),
            ],
          ),
          context.sizedBoxHeightExtraSmall,
          RichText(
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              text: TextSpan(children: [
                TextSpan(
                    text: '${S.current.customerAddress} \n',
                    style: context.textTheme.bodySmall?.copyWith(color: Colors.grey)),
                TextSpan(
                  text: customer.customerAddress?.completeAddress,
                  style: context.textTheme.bodyMedium,
                ),
              ])),
          context.sizedBoxHeightExtraSmall,
          RoundedBtnWidget(
              onTap: () {
                Get.to(MultiBlocProvider(
                  providers: [
                    BlocProvider<CustomerBloc>.value(value: BlocProvider.of<CustomerBloc>(context)),
                    BlocProvider<CreditHistoryCubit>.value(value: BlocProvider.of<CreditHistoryCubit>(context)),
                  ],
                  child: MobileCustomerInformationScreen(customer: customer),
                ));
              },
              bgColor: Colors.white,
              boxBorder: Border.all(color: Colors.black),
              borderRadios: 10,
              btnPadding: const EdgeInsets.symmetric(vertical: 7),
              btnTextStyle: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              btnTextColor: Colors.black,
              btnText: S.current.viewCustomerInformation),
        ],
      ),
    );
  }
}
