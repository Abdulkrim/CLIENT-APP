import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/core/localazation/service/localization_service/localization_service.dart';
import 'package:merchant_dashboard/injection.dart';
import 'package:merchant_dashboard/routes/app_routes.dart';
import 'package:merchant_dashboard/feature/main_screen/presentation/blocs/main_screen_bloc.dart';
import 'package:merchant_dashboard/feature/main_screen/presentation/widgets/logout_button.dart';
import 'package:merchant_dashboard/feature/main_screen/presentation/widgets/menu_items.dart';
import 'package:merchant_dashboard/generated/assets.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../../widgets/scrollable_widget.dart';
import '../../blocs/menu_drawer/menu_drawer_cubit.dart';
import '../merchant_name_widget.dart';

class AppDrawerWidget extends StatelessWidget {
  const AppDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 247, 247, 247),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: ScrollableWidget(
            child: Column(
              children: [
                context.sizedBoxHeightSmall,
                SvgPicture.asset(
                  Assets.logoCatalogakLogo,
                  height: 46,
                ),
                context.sizedBoxHeightSmall,
                const MerchantNameWidget(),
                context.sizedBoxHeightExtraSmall,
                const MenuItemsWidget()
              ],
            ),
          )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Expanded(
                    child: Row(
                  children: [
                    const Icon(Icons.account_circle),
                    Expanded(
                      child: Text(
                        overflow: TextOverflow.ellipsis,
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
                      child: Icon(Icons.arrow_drop_down_rounded,
                          color: Colors.green),
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
                    onChanged: (newLang) async{
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
