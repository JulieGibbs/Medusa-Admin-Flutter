import 'package:dio/dio.dart';
import 'package:medusa_admin/core/constant/strings.dart';
import 'package:medusa_admin/data/service/storage_service.dart';
import 'package:medusa_admin_flutter/medusa_admin.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'di.dart';

abstract class MedusaAdminDi {
  static final Interceptor _interceptor = InterceptorsWrapper(
    onRequest: (options, handler) async {
      final authType = StorageService.appSettings.authType;
      FlutterSecureStorage secureStorage = getIt<FlutterSecureStorage>();
      switch (authType) {
        case AuthenticationType.cookie:
          if (options.headers['Cookie'] != null) {
            return handler.next(options);
          }
          try {
            final String? cookie =
                await secureStorage.read(key: AppConstants.cookieKey);
            if (cookie?.isNotEmpty ?? false) {
              options.headers['Cookie'] = cookie;
            }
          } catch (_) {}
          return handler.next(options);

        case AuthenticationType.token:
          if (options.headers['x-medusa-access-token'] != null) {
            return handler.next(options);
          }
          try {
            final String? token =
                await secureStorage.read(key: AppConstants.tokenKey);
            if (token?.isNotEmpty ?? false) {
              options.headers['x-medusa-access-token'] = token;
            }
          } catch (_) {}
          return handler.next(options);

        case AuthenticationType.jwt:
          if (options.headers['Authorization'] != null) {
            return handler.next(options);
          }
          try {
            final String? jwt =
                await secureStorage.read(key: AppConstants.jwtKey);
            if (jwt?.isNotEmpty ?? false) {
              options.headers['Authorization'] = 'Bearer $jwt';
            }
          } catch (_) {}
          return handler.next(options);
      }
    },
    onError: (DioException e, handler) async {
      if (e.response?.statusCode != 401) {
        return handler.next(e);
      }
      FlutterSecureStorage secureStorage = getIt<FlutterSecureStorage>();
      final authType = StorageService.appSettings.authType;
      switch (authType) {
        case AuthenticationType.cookie:
          try {
            await secureStorage.delete(key: AppConstants.cookieKey);
          } catch (_) {}
          return handler.next(e);
        case AuthenticationType.token:
          return handler.next(e);
        case AuthenticationType.jwt:
          try {
            await secureStorage.delete(key: AppConstants.jwtKey);
          } catch (_) {}
          return handler.next(e);
      }
    },
  );

  static Future<void> registerMedusaAdminSingleton() async {
    final url = StorageService.baseUrl!;
    final authType = StorageService.authType;
    final apiToken = authType == AuthenticationType.token
        ? await getIt<FlutterSecureStorage>().read(key: AppConstants.tokenKey)
        : null;
    if (!getIt.isRegistered<MedusaAdmin>()) {
      getIt.registerLazySingleton<MedusaAdmin>(
        () => MedusaAdmin.initialize(
            config: MedusaConfig(
                baseUrl: url,
                enableDebugging: false,
                authenticationType: authType,
                apiToken: apiToken),
            interceptors: [_interceptor]),
      );
    }
  }

  static Future<void> resetMedusaAdminSingleton() async {
    await getIt.resetLazySingleton<MedusaAdmin>();
  }
}
