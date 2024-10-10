import 'package:bloc/bloc.dart' as bloc;
import 'package:dio/dio.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as fb;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/core/localazation/service/analytics/capture_event.dart';
import 'package:merchant_dashboard/core/localazation/service/localization_service/localization_service.dart';
import 'package:merchant_dashboard/core/notifications/pushy_service.dart';
import 'package:merchant_dashboard/core/utils/global.dart';
import 'package:merchant_dashboard/firebase_options.dart';
import 'package:merchant_dashboard/routes/app_routes.dart';
import 'package:merchant_dashboard/core/client/user_session.dart';
import 'package:merchant_dashboard/core/utils/app_environment.dart';
import 'package:merchant_dashboard/feature/auth/presentation/blocs/login_bloc.dart';
import 'package:merchant_dashboard/feature/main_screen/presentation/blocs/main_screen_bloc.dart';
import 'package:merchant_dashboard/injection.dart';
import 'package:merchant_dashboard/theme/theme_data.dart';
import 'package:merchant_dashboard/utils/bloc/global_app_bloc_delegate.dart';
import 'package:pushy_flutter/pushy_flutter.dart';
import 'package:sentry_dio/sentry_dio.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'core/utils/configuration.dart';
import 'feature/expense/presentation/blocs/expense_cubit.dart';
import 'feature/main_screen/presentation/blocs/menu_drawer/menu_drawer_cubit.dart';
import 'feature/subscription/presentation/blocs/payment/payment_status_cubit.dart';
import 'generated/l10n.dart';
import 'dart:io' show Platform;

void main() async {
  // await runZonedGuarded(() async {
  await GetStorage.init();

  configureDependencies(AppEnvironment.dev);

  WidgetsFlutterBinding.ensureInitialized();

  await FastCachedImageConfig.init(clearCacheAfter: const Duration(days: 30));

  await Firebase.initializeApp(
      name: (kIsWeb) ? null : 'CatalogakClientApp', options: DefaultFirebaseOptions.currentPlatform);

  CaptureAnalyticsEvents.captureEvents(
      eventName: 'AppOpen', logType: LogType.appOpen);

  if (kReleaseMode) {
    debugPrint = (String? message, {int? wrapWidth}) => '';
  } else {
    bloc.Bloc.observer = SimpleBlocObserver();
  }

  if (!kIsWeb) {
    if (!Platform.isWindows) {
      // PushyService.init();
      /*     initDynamicLinks();
      initUniLinks();*/
    }
  } else {
    /*   initDynamicLinks();
    initUniLinks();*/
  }

  await SentryFlutter.init(
    (options) => options
      ..dsn =
          'https://7fbc4ddc9fa6146e4cfe68df77a74099@o4504450281111552.ingest.sentry.io/4506743927603200'
      ..release = 'client.app@'
      ..debug = false//!kReleaseMode
      ..sampleRate = 7
      ..tracesSampleRate = 1
      ..environment = getIt<Configuration>().name,
    appRunner: () {
      getIt<Dio>().addSentry();
    },
  );

  runApp(MyApp(getIt<LocalizationService>()));
/*  }, (exception, stackTrace) async {
    await Sentry.captureException(exception, stackTrace: stackTrace);
  });*/
}

var isPhone = false.obs;

class MyApp extends StatefulWidget {
  final LocalizationService _localizationService;

  const MyApp(this._localizationService, {super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late String lang;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    isPhone(context.isPhone);

    return fb.MultiBlocProvider(
      providers: [
        fb.BlocProvider<LoginBloc>(
          create: (BuildContext context) => getIt<LoginBloc>(),
        ),
        fb.BlocProvider<MainScreenBloc>(
            create: (BuildContext context) => getIt<MainScreenBloc>()),
        fb.BlocProvider<PaymentStatusCubit>(
          create: (BuildContext context) => getIt<PaymentStatusCubit>(),
        ),
        fb.BlocProvider<MenuDrawerCubit>(
          create: (BuildContext context) => getIt<MenuDrawerCubit>(),
        ),
        fb.BlocProvider<ExpenseCubit>(
          create: (BuildContext context) => getIt<ExpenseCubit>()
            ..getExpenseAmount()
            ..getExpenseTypes()
            ..getPaymentTypes(),
        ),
      ],
      child: GetMaterialApp(
        title: 'Merchants Dashboard',
        scrollBehavior: MyCustomScrollBehavior(),
        enableLog: true,
        debugShowCheckedModeBanner: false,
        defaultTransition:
            (kIsWeb) ? Transition.noTransition : Transition.cupertino,
        getPages: AppRoutes.routes,
        // translations: Translation(),
        unknownRoute: getIt<IUserSession>().hasToken()
            ? AppRoutes.routes[0]
            : AppRoutes.routes[1],
        routingCallback: (value) {},
        theme: context.lightTheme,
        initialRoute: getIt<IUserSession>().hasToken()
            ? AppRoutes.mainRoute
            : AppRoutes.loginRoute,
        supportedLocales: S.delegate.supportedLocales,
        locale: Locale.fromSubtags(
          languageCode: lang,
        ),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          S.delegate,
        ],
        fallbackLocale: const Locale('en', 'US'),
        navigatorKey: GlobalRoutingKeys.navigationKey,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    lang = widget._localizationService.getLanguage();
    widget._localizationService.localizationStream.listen((event) {
      lang = event;
      setState(() {});
    });

    /* WidgetsBinding.instance.addPostFrameCallback((_) {
      getIt<MainScreenBloc>().myBottomNav = MenuModel.allMenuList();
    });*/
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

@pragma('vm:entry-point')
void backgroundNotificationListener(Map<String, dynamic> data) {
  // Print notification payload data
  // TODO : in case of testing  print('Received notification: $data');

  // Notification title
  String notificationTitle = 'Client App';

  // Attempt to extract the "message" property from the payload: {"message":"Hello World!"}
  String notificationText =
      data['message'] ?? 'Please check our app notifications';

  // Android: Displays a system notification
  // iOS: Displays an alert dialog
  Pushy.notify(notificationTitle, notificationText, data);
}
