import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/customers/presentation/blocs/customers/customer_bloc.dart';
import 'package:merchant_dashboard/feature/customers/presentation/pages/search_customer_screen.dart';
import 'package:merchant_dashboard/feature/main_screen/presentation/blocs/main_screen_bloc.dart';
import 'package:merchant_dashboard/feature/subscription/presentation/blocs/payment/payment_status_cubit.dart';
import 'package:merchant_dashboard/feature/subscription/presentation/widgets/desktop/checkout/payment_result_screen.dart';
import 'package:merchant_dashboard/feature/transaction/presentation/blocs/transaction_bloc.dart';
import 'package:merchant_dashboard/injection.dart';
import 'package:merchant_dashboard/routes/route_guard.dart';
import 'package:merchant_dashboard/feature/auth/presentation/pages/login.dart';
import 'package:merchant_dashboard/feature/main_screen/presentation/pages/main_screen.dart';

class AppRoutes {
  static const mainRoute = "/main";
  static const loginRoute = "/login/:nl";
  static const customerSearchRoute = "/customerSearch";
  static const deleteAccountRoute = "/deleteAccount";
  static const pay = "/pay/:payId";
  // static const signupGuide = "/signup-guide";

  static final routes = <GetPage<dynamic>>[
    GetPage(
        name: mainRoute,
        page: () => BlocProvider<MainScreenBloc>.value(
              value: getIt<MainScreenBloc>()..add(const InitalEventsCall()),
              child: const MainScreen(),
            ),
        middlewares: [MainRouteGuard()]),
 /*   GetPage(
      name: signupGuide,
      page: () => BlocProvider<SignUpBloc>(
        create: (context) => getIt<SignUpBloc>()..add(GetAllBusinessTypesEvent()),
        child: const SignupSetupGuideScreen(),
      ),
      middlewares: [LoginRouteGuard()],
    ),*/
    GetPage(
        name: loginRoute,
        page: () => LoginScreen(isSignUpDefault: (Get.parameters['nl'] ?? '') == 'register'),
        middlewares: [LoginRouteGuard()]),
    GetPage(
      name: pay,
      page: () => BlocProvider<PaymentStatusCubit>.value(
        value: getIt<PaymentStatusCubit>()..checkPaymentStatus(payId: Get.parameters['payId'] ?? '-'),
        child: PaymentResultScreen(
            onContinueTapped: () {
              Get.offAllNamed(mainRoute);
            },
            payId: Get.parameters['payId'] ?? '-'),
      ),
    ),
    GetPage(
        name: customerSearchRoute,
        page: () => MultiBlocProvider(
                providers: [
                  BlocProvider<CustomerBloc>(
                    create: (context) => getIt<CustomerBloc>(),
                  ),
                  BlocProvider.value(value: getIt<TransactionBloc>()),
                ],
                child: SearchCustomerScreen(
                  phoneNumber: Get.arguments?['phone'],
                )),
        middlewares: [MainRouteGuard()])
  ];
}
