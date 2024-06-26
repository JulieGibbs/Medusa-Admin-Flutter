import 'package:dio/dio.dart';
import 'package:medusa_admin/core/constant/strings.dart';
import 'package:medusa_admin/core/utils/enums.dart';
import 'package:medusa_admin/data/service/auth_preference_service.dart';
import 'package:medusa_admin_dart_client/medusa_admin.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'di.dart';

abstract class MedusaAdminDi {
  static final Interceptor _loggerInterceptor = PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: false,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90);
  static final Interceptor _authInterceptor = InterceptorsWrapper(
    onRequest: (options, handler) async {
      final authType = AuthPreferenceService.authTypeGetter;
      final secureStorage = getIt<FlutterSecureStorage>();
      try {
        switch (authType) {
          case AuthenticationType.cookie:
            if (options.headers['Cookie'] != null) {
              break;
            }
            final String? cookie =
                await secureStorage.read(key: AppConstants.cookieKey);
            if (cookie?.isNotEmpty ?? false) {
              options.headers['Cookie'] = cookie;
            }
            break;

          case AuthenticationType.token:
            if (options.headers['x-medusa-access-token'] != null) {
              break;
            }
            final String? token =
                await secureStorage.read(key: AppConstants.tokenKey);
            if (token?.isNotEmpty ?? false) {
              options.headers['x-medusa-access-token'] = token;
            }
            break;
          case AuthenticationType.jwt:
            if (options.headers['Authorization'] != null) {
              break;
            }
            final String? jwt =
                await secureStorage.read(key: AppConstants.jwtKey);
            if (jwt?.isNotEmpty ?? false) {
              options.headers['Authorization'] = 'Bearer $jwt';
            }
            break;
        }
      } catch (_) {}
      handler.next(options);
    },
    onError: (DioException e, handler) async {
      if (e.response?.statusCode != 401) {
        handler.next(e);
        return;
      }
      final secureStorage = getIt<FlutterSecureStorage>();
      final authType = AuthPreferenceService.authTypeGetter;
      try {
        AuthPreferenceService.instance.setIsAuthenticated(false);
        if (authType == AuthenticationType.cookie) {
          await secureStorage.delete(key: AppConstants.cookieKey);
        }
        // if(authType == AuthenticationType.token && e.requestOptions.path.endsWith('/auth')){
        //   await secureStorage.delete(key: AppConstants.tokenKey);
        // }
        if (authType == AuthenticationType.jwt) {
          await secureStorage.delete(key: AppConstants.jwtKey);
        }
      } catch (_) {}
      handler.next(e);
    },
  );
  static Future<void> registerMedusaAdminSingleton() async {
    if (!getIt.isRegistered<MedusaAdmin>()) {
      getIt.registerLazySingleton<MedusaAdmin>(
        () => MedusaAdmin.initialize(
          baseUrl: AuthPreferenceService.baseUrlGetter!,
          interceptors: [_authInterceptor, _loggerInterceptor],
        ),
      );
    }
  }

  static Future<void> resetMedusaAdminSingleton() async {
    await getIt.resetLazySingleton<MedusaAdmin>();
  }
}
