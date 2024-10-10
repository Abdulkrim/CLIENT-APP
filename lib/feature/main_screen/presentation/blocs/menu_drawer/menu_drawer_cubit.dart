import 'package:bloc/bloc.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/feature/main_screen/presentation/widgets/missing_save_data_alert.dart';

import '../../../data/models/menu_model.dart';
import '../../../data/repository/main_repository.dart';

part 'menu_drawer_state.dart';

@singleton
class MenuDrawerCubit extends Cubit<MenuDrawerState> {
  final IMainRepository _mainRepository;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  MenuDrawerCubit(this._mainRepository) : super(MenuDrawerInitial());

  late List<MenuModel> menuItems = MenuModel.allMenuList;
  late MenuModel selectedPageContent = menuItems[1];

  List<String> requestedRemoveItems = [];
 bool isPreviousScreenHasData = false;
  void clearData() {
    menuItems = MenuModel.allMenuList;
    selectedPageContent = menuItems[1];
    requestedRemoveItems.clear();
  }

  void changeLanguage(String newLang) {
    _applyRemoveMenuItems();
    emit(ChangeLanguageState(newLang));
  }

  void _applyRemoveMenuItems() {

    menuItems = MenuModel.allMenuList..removeWhere((element) => requestedRemoveItems.contains(element.pageKey));

    for (var main in menuItems) {
      // todo refactor it
      for (var item in main.subList) {
        if (requestedRemoveItems.contains(item.pageKey)) {
          main.subList.remove(item);
        }
      }
    }
  }

  void removeFromMenuList({required String menuItemKey}) {
    emit(const RemovedMenuItemState(isLoading: true));
    requestedRemoveItems.add(menuItemKey);
    _applyRemoveMenuItems();

    emit(const RemovedMenuItemState(isSuccess: true));
  }

  void restoreToMenuList({required String menuItemKey}) {
    emit(const RemovedMenuItemState(isLoading: true));
    requestedRemoveItems.remove(menuItemKey);
    _applyRemoveMenuItems();
    emit(const RemovedMenuItemState(isSuccess: true));
  }

  void goToSpecificPage({required String pageKey}) {
    selectedPageContent = menuItems.firstWhere((element) => element.pageKey == pageKey);
    emit(BodyContentChangeState(selectedPageContent.pageKey));
  }

  void changeBodyContent({required MenuModel? menuItem}) {
    if (menuItem == null) return; emit(BodyContentChangeState(''));
    selectedPageContent = menuItem;
    emit(BodyContentChangeState(menuItem.pageKey));
    closeDrawer();
  }

  void forceRedirectToSubscriptionPage({String errorMessage = 'Your subscription has expired, please renew your subscription'}) {
    if (!_mainRepository.isLoggedInUserG()) {
      _mainRepository.logoutUser();
      emit(UserSubscriptionStatusesState(errorMessage, shouldLogout: true));
    } else {
      selectedPageContent = menuItems.firstWhere((element) => element.pageKey == MenuModel.systemManagementSubscription);

      closeDrawer();
      emit(UserSubscriptionStatusesState(errorMessage));
    }
  }

  void closeDrawer() async {
    scaffoldKey.currentState?.openEndDrawer();
  }

  checkIfPreviousScreenHasUnSavedData({required MenuModel? menuItem}) {
    if (isPreviousScreenHasData) {
      showMissingSaveDataAlert(onYesTapped: () {
        changeBodyContent(menuItem: menuItem);
      });
    } else {
      changeBodyContent(menuItem: menuItem);
    }
  }
}
