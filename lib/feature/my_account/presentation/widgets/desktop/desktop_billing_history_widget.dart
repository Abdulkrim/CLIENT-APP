import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/my_account/presentation/blocs/my_account_bloc.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/rounded_dropdown_list.dart';

import '../../../../../theme/theme_data.dart';

class DesktopBillingHistory extends StatelessWidget {
  const DesktopBillingHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        context.sizedBoxHeightMicro,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: Get.width * 0.3,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: AppColors.lightGray,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(9),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: 'October 2022',
                        hintStyle: context.textTheme.labelLarge?.copyWith(color: Colors.grey),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  context.sizedBoxWidthMicro,
                  const Text("|"),
                  context.sizedBoxWidthMicro,
                  Expanded(
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: 'October 2022',
                        hintStyle: context.textTheme.labelLarge?.copyWith(color: Colors.grey),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            RoundedDropDownList(
                selectedValue: context.watch<MyAccountBloc>().selectedValue,
                onChange: (p0) {},
                items: context
                    .watch<MyAccountBloc>()
                    .sortType
                    .map<DropdownMenuItem<dynamic>>((dynamic value) => DropdownMenuItem<dynamic>(
                          value: value,
                          child: SizedBox(
                            width: Get.width * 0.11,
                            child: Text(
                              value,
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                        ))
                    .toList()),
          ],
        ),
        Expanded(
            child: Container(
          margin: const EdgeInsets.only(left: 8.0, right: 8.0, top: 10.0),
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: AppColors.lightGray,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: SingleChildScrollView(
            child: Table(
              children: [
                TableRow(
                    decoration: BoxDecoration(
                      color: const Color(0xfff5f6fa),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    children: const [
                      TableCell(
                        child: SizedBox(
                          height: 40.0,
                          child: Center(
                            child: Text(
                              'Invoice No',
                              style: TextStyle(
                                color: Color(0xffa8a8a8),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: SizedBox(
                          height: 40.0,
                          child: Center(
                            child: Text(
                              'Subscription date',
                              style: TextStyle(
                                color: Color(0xffa8a8a8),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: SizedBox(
                          height: 40.0,
                          child: Center(
                            child: Text(
                              'Payment',
                              style: TextStyle(
                                color: Color(0xffa8a8a8),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: SizedBox(
                          height: 40.0,
                          child: Center(
                            child: Text(
                              'Business Name',
                              style: TextStyle(
                                color: Color(0xffa8a8a8),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: SizedBox(
                          height: 40.0,
                          child: Center(
                            child: Text(
                              'Subscription Plan',
                              style: TextStyle(
                                color: Color(0xffa8a8a8),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: SizedBox(
                          height: 40.0,
                          child: Center(
                            child: Text(
                              'Subscription Renews',
                              style: TextStyle(
                                color: Color(0xffa8a8a8),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: SizedBox(
                          height: 40.0,
                          child: Center(
                            child: Text(
                              'Status',
                              style: TextStyle(
                                color: Color(0xffa8a8a8),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: SizedBox(
                          height: 40.0,
                          child: Center(
                            child: Text(
                              '',
                              style: TextStyle(
                                color: Color(0xffa8a8a8),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ]),
                for (var i = 0; i < 10; i++)
                  TableRow(children: [
                    TableCell(
                      child: SizedBox(
                        height: 40.0,
                        child: Center(
                          child: Text(
                            '56ADC5825DEW',
                            style: context.textTheme.bodySmall,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: SizedBox(
                        height: 40.0,
                        child: Center(
                          child: Text(
                            '15/10/2022',
                            style: context.textTheme.bodySmall,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    const TableCell(
                      child: SizedBox(
                        height: 40.0,
                        child: Center(
                            child: Icon(
                          Icons.credit_card_sharp,
                          color: Colors.red,
                        )),
                      ),
                    ),
                    TableCell(
                      child: SizedBox(
                        height: 40.0,
                        child: Center(
                          child: Text(
                            'KFC',
                            style: context.textTheme.bodySmall,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: SizedBox(
                        height: 40.0,
                        child: Center(
                          child: Text(
                            'AED 900 / Year',
                            style: context.textTheme.bodySmall,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: SizedBox(
                        height: 40.0,
                        child: Center(
                          child: Text(
                            '15/11/2022',
                            style: context.textTheme.bodySmall,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: SizedBox(
                        height: 40.0,
                        child: Center(
                          child: Text(
                            'Pending',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: context.colorScheme.primaryColor),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    const TableCell(
                      child: SizedBox(
                        height: 40.0,
                        child: Center(
                            child: Icon(
                          Icons.cloud_download_rounded,
                          color: Colors.black,
                        )),
                      ),
                    ),
                  ])
              ],
            ),
          ),
        )),
      ],
    );
  }
}
