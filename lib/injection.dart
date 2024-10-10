import 'package:get_it/get_it.dart';
import 'package:merchant_dashboard/injection.config.dart';
import 'package:injectable/injectable.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
void configureDependencies(String env) => getIt.init(environment: env);

Future<void> resetInjection() async {
  await getIt.reset();
}
