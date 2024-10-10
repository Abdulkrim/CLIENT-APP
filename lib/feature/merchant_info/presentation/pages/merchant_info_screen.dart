import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/merchant_info/presentation/blocs/merchant_info_bloc.dart';
import 'package:merchant_dashboard/feature/merchant_info/presentation/widgets/desktop/desktop_merchant_info_ui.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/screenUtils/responsive.dart';
import 'package:merchant_dashboard/utils/snack_alert/snack_alert.dart';
import 'package:merchant_dashboard/widgets/general_dropdown_checker.dart';
import 'package:merchant_dashboard/widgets/shimmer.dart';


class MerchantInfoScreen extends StatelessWidget {
  const MerchantInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MerchantInfoBloc, MerchantInfoState>(
        listener: (context, state) {
          if (state is UpdateMerchantInfoState) {
            if (state.isSuccess) {
              Get.back();
              context.showCustomeAlert(
                  S.current.updatedSuccessfully, SnackBarType.success);
            } else if (state.errorMsg.isNotEmpty) {
              context.showCustomeAlert(state.errorMsg, SnackBarType.error);
            }
          } else if (state is DeleteMerchantLogoState) {
            if (state.isSuccess) {
              Get.back();
              context.showCustomeAlert(
                  S.current.deleteLogoSuccessfully, SnackBarType.success);
            } else if (state.errorMsg.isNotEmpty) {
              context.showCustomeAlert(state.errorMsg, SnackBarType.error);
            }
          }
        },
        builder: (context, state) => GeneralDropdownChecker(
              child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20.0),
                  physics: const BouncingScrollPhysics(),
                  child: (state is GetMerchantInformationLoadingState)
                      ? ShimmerWidget(width: Get.width, height: Get.height)
                      : const ResponsiveLayout(
                          desktopLayout: DesktopMerchantInfoUI(),
                          webLayout: DesktopMerchantInfoUI(),
                          mobileLayout: DesktopMerchantInfoUI(),
                          tabletLayout: DesktopMerchantInfoUI())),
            ));
  }
}

enum LogoTypes {
  logo(1),
  defaulltLogo(2),
  printingLogo(3),
  footerLogo(4);

  const LogoTypes(this.typeId);

  final int typeId;
}
