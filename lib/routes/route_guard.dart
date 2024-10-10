import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/routes/app_routes.dart';
import 'package:merchant_dashboard/core/client/user_session.dart';
import 'package:merchant_dashboard/injection.dart';

import '../feature/main_screen/presentation/blocs/main_screen_bloc.dart';


class MainRouteGuard extends GetMiddleware{

  @override
  RouteSettings? redirect(String? route) {
    return !getIt<IUserSession>().hasToken() ? const RouteSettings(name: AppRoutes.loginRoute): null;
  }
}


class LoginRouteGuard extends GetMiddleware{
  @override
  RouteSettings? redirect(String? route) {
    getIt<MainScreenBloc>().logOutUser();
    return super.redirect(route);
  }
}