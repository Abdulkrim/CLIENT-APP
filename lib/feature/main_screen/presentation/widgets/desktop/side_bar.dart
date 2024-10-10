import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/core/localazation/service/localization_service/localization_service.dart';
import 'package:merchant_dashboard/feature/main_screen/presentation/blocs/menu_drawer/menu_drawer_cubit.dart';
import 'package:merchant_dashboard/injection.dart';
import 'package:merchant_dashboard/routes/app_routes.dart';
import 'package:merchant_dashboard/feature/main_screen/presentation/blocs/main_screen_bloc.dart';
import 'package:merchant_dashboard/feature/main_screen/presentation/widgets/desktop/desktop_branches_dropdown_widget.dart';
import 'package:merchant_dashboard/feature/main_screen/presentation/widgets/logout_button.dart';
import 'package:merchant_dashboard/feature/main_screen/presentation/widgets/menu_items.dart';
import 'package:merchant_dashboard/generated/assets.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/scrollable_widget.dart';

import '../../../../../core/constants/defaults.dart';
import '../merchant_name_widget.dart';

class SideBarWidget extends StatelessWidget {
  const SideBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (UIDefaults.drawerItemsWidth + 50),
      padding: const EdgeInsets.only(bottom: 16),
      color: const Color.fromARGB(255, 246, 246, 246),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: ScrollableWidget(
            showAlwaysScrollbar: true,
            child: Column(
              children: [
                context.sizedBoxHeightExtraSmall,
                SvgPicture.asset(Assets.logoCatalogakLogo, height: 46),
                context.sizedBoxHeightExtraSmall,
                const MerchantNameWidget(),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: DesktopBranchesDropDownWidget(),
                ),
                const MenuItemsWidget()
              ],
            ),
          )),
          context.sizedBoxHeightSmall,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Expanded(
                    child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '  ${context.select((MainScreenBloc bloc) => bloc.loggedInMerchantInfo?.userName)}',
                        style: context.textTheme.bodyMedium,
                      ),
                    )
                  ],
                )),
                DropdownButton(
                    // dropdownColor: Theme.of(context).primaryColor,
                    value: Localizations.localeOf(context).languageCode,
                    style: const TextStyle(color: Colors.green),
                    underline: Container(),
                    icon: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(Icons.arrow_drop_down_rounded, color: Colors.green),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'ar',
                        child: Text(
                          'العربية',
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'en',
                        child: Text(
                          'English',
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'tr',
                        child: Text(
                          'Turkey',
                        ),
                      ),
                    ],
                    onChanged: (newLang) async {
                      getIt<LocalizationService>().setLanguage(newLang.toString());
                      await Get.updateLocale(Locale.fromSubtags(languageCode: newLang ?? 'en'));
                      context.read<MenuDrawerCubit>().changeLanguage(newLang!);
                    }),
              ],
            ),
          ),
          LogoutButtonWidget(
            onLogoutClick: () {
              context.read<MainScreenBloc>().logOutUser();
              Get.offAllNamed(AppRoutes.loginRoute);
            },
          )
        ],
      ),
    );
  }
}
