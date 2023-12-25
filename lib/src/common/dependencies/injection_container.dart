import 'package:contact_center/src/common/dependencies/br_dio.dart';
import 'package:contact_center/src/common/services/auth/auth_service.dart';
import 'package:contact_center/src/common/services/call/call_service.dart';
import 'package:contact_center/src/common/services/start_connect/connect_service.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.I;

initGetIt() {
  getIt.registerLazySingleton<BrDio>(
    () => BrDio(),
  );
  getIt.registerLazySingleton<AuthService>(
    () => AuthServiceImplement(brDio: getIt()),
  );
  getIt.registerLazySingleton<CallService>(
    () => CallServiceImplement(brDio: getIt()),
  );
  getIt.registerLazySingleton<ConnectService>(
    () => ConnectServiceImplement(brDio: getIt()),
  );

}
