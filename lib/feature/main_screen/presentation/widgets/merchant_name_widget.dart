import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../blocs/main_screen_bloc.dart';

class MerchantNameWidget extends StatelessWidget {
  const MerchantNameWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !(context.select<MainScreenBloc, bool>(
          (value) => value.loggedInMerchantInfo?.isLoggedInUserG ?? true)),
      child: Padding(
        padding: const EdgeInsets.only(left: 35, right: 16),
        child: Text(
          context.select<MainScreenBloc, String>(
              (value) => value.loggedInMerchantInfo?.merchantName ?? '-'),
          style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
        ),
      ),
    );
  }
}
