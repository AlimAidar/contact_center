import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../environment_config.dart';

class BrDio {
  Dio dio = Dio(BaseOptions(baseUrl: EnvironmentConfig.apiUrl));

  Dio get instance => dio;

  set path(String path) => dio = Dio(
        BaseOptions(baseUrl: EnvironmentConfig.apiUrl + path),
      )..interceptors.addAll([
          BrDioInterceptor(),
          // LogInterceptor(
          //   request: true,
          //   requestBody: true,
          //   requestHeader: true,
          //   responseBody: true,
          //   responseHeader: false,
          //   error: true,
          // ),
        ]);

  BrDio() {
    dio.interceptors.addAll([
      BrDioInterceptor(),
      // LogInterceptor(
      //   request: true,
      //   requestBody: true,
      //   requestHeader: true,
      //   responseBody: true,
      //   responseHeader: false,
      //   error: true,
      // ),
    ]);
  }
}

class BrDioInterceptor extends Interceptor {
  Dio dio = Dio(BaseOptions(baseUrl: EnvironmentConfig.apiUrl));
  Box tokensBox = Hive.box('tokens');

  @override
  onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Authorization'] = 'Bearer ${tokensBox.get('access')}';

    super.onRequest(options, handler);
  }

  // @override
  // void onError(DioError err, ErrorInterceptorHandler handler) {
  //   if (err.response?.statusCode == 401) {
  //     // getIt<AuthCubitOut>().logOut();
  //   }
  //   super.onError(err, handler);
  // }

  // @override
  // Future onError(
  //   DioError err,
  //   ErrorInterceptorHandler handler,
  // ) async {
  //   await Sentry.captureException(
  //     err.response,
  //   );
  //   if ((err.response?.statusCode ?? 0) == HttpStatus.unauthorized) {
  //     try {
  //       await refreshToken();
  //     } on DioError {
  //       rethrow;
  //     }
  //   } else if ((err.response?.statusCode ?? 0) ==
  //       HttpStatus.unprocessableEntity) {
  //     // try {
  //     //   await refreshToken();
  //     // } on DioError catch (e) {
  //     //   throw e;
  //     // }
  //   } else if ((err.response?.statusCode ?? 0) == HttpStatus.notFound) {
  //     getIt<NotFoundLogic>().statusSubject.add(404);
  //   }
  //   return super.onError(err, handler);
  // }

  // Future refreshToken() async {
  //   Response response = await dio.post(
  //     'authorization/refresh/',
  //     data: {
  //       'refreshToken': tokensBox.get('refresh'),
  //     },
  //   );

  //   TokenModel tokens = TokenModel.fromJson(response.data['tokens']);

  //   await tokensBox.put('access', tokens.accessToken);
  //   await tokensBox.put('refresh', tokens.refreshToken);
  // }
}
