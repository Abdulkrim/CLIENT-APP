import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/core/utils/configuration.dart';
import 'package:merchant_dashboard/injection.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class CaptureAnalyticsEvents {
  static captureEvents({required String eventName, Map<String, String>? parameter, required LogType logType}) async {
    if (!getIt<Configuration>().isProduction) return;


    switch (logType) {
      case LogType.appOpen:
        FirebaseAnalytics.instance.logAppOpen();
        Sentry.captureEvent(SentryEvent(message: const SentryMessage('AppOpen'), level: SentryLevel.info, tags: parameter));
      case LogType.login:
        FirebaseAnalytics.instance.logLogin(parameters: parameter);
        Sentry.captureEvent(SentryEvent(message: const SentryMessage('Login'), level: SentryLevel.info, tags: parameter));
      case LogType.signup:
        FirebaseAnalytics.instance.logSignUp(parameters: parameter, signUpMethod: 'Email');
        Sentry.captureEvent(SentryEvent(message: const SentryMessage('Sign UP'), level: SentryLevel.info, tags: parameter));
      default:
        FirebaseAnalytics.instance.logEvent(name: eventName, parameters: parameter);
        Sentry.captureEvent(SentryEvent(message: SentryMessage(eventName), level: SentryLevel.info, tags: parameter));
    }
  }
}

enum LogType { appOpen, login, signup, normal }
