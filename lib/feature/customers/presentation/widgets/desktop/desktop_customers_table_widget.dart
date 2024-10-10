import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/main_screen/presentation/blocs/main_screen_bloc.dart';
import 'package:merchant_dashboard/feature/region/presentation/blocs/region_cubit.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/injection.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../../widgets/profile_generator_image_widget.dart';
import '../../../data/models/entity/customer_list_info.dart';
import '../../blocs/customers/customer_bloc.dart';
import '../customer_details_dialog.dart';

class DesktopCustomersTableWidget extends StatelessWidget {
  final List<Customer> customers;
  final Function(Customer customer) onCustomerInformationTapped;

  const DesktopCustomersTableWidget({
    Key? key,
    required this.customers, required this.onCustomerInformationTapped
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: const {
        0: FlexColumnWidth(.4),
        5: FlexColumnWidth(1.7),
      },
      children: [
        context.headerTableRow([
          '',
          S.current.customerName,
          S.current.customerType,
          S.current.creditBalance,
          S.current.customerAddress,
          S.current.transactionHistory,
        ],alignment:  Alignment.centerLeft),
        ...customers
            .map((e) => TableRow(children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: ProfileGeneratorImageWidget(
                        itemLabel: e.name,
                        itemColorIndex: 1,
                        width: 40,
                        height: 40,
                      ),
                    ),
                  ),
                  TableCell(
                    child: Text(
                      e.name,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  TableCell(
                    child: Text(
                      e.phoneNumber,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  TableCell(
                    child: Text(
                        '${e.balance} ${getIt<MainScreenBloc>().branchGeneralInfo?.currency}',
                      textAlign: TextAlign.start,
                    ),
                  ),
                  TableCell(
                    child: Tooltip(
                      message:e.customerAddress?.fullAddress ?? '-',
                      child: Text(
                        e.customerAddress?.fullAddress ?? '-',
                        textAlign: TextAlign.start,maxLines: 2,overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  TableCell(
                      child: Wrap(
                    children: [
                      TextButton(
                        child: Text(S.current.viewDetails),
                        onPressed: () => Get.dialog(MultiBlocProvider(
                          providers: [
                            BlocProvider<CustomerBloc>.value(value: BlocProvider.of<CustomerBloc>(context)),
                            BlocProvider<RegionCubit>.value(value: BlocProvider.of<RegionCubit>(context)),
                          ],
                          child: CustomerDetailsDialog(customer: e),
                        )),
                      ),
                      TextButton(
                        child: Text(S.current.viewCustomerInformation),
                        onPressed: () => onCustomerInformationTapped(e),
                      ),
                    ],
                  )),
                ]))
            .toList()
      ],
    );
  }
}
