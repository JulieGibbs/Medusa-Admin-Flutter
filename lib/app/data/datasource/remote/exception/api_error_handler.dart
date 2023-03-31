import 'package:dio/dio.dart';

class Failure {
  final int? code;
  final String message;
  final String type;
  Failure({this.code, required this.message, required this.type});

  @override
  String toString() {
    return 'code: $code,\n message : $message, \n type: $type';
  }

  factory Failure.from(dynamic error) {
    var failure = Failure(message: '', type: '');
    try {
      if (error is DioError) {
        switch (error.type) {
          case DioErrorType.cancel:
            failure = failure.copyWith(message: 'Request to API server was cancelled');
            break;
          case DioErrorType.connectionTimeout:
            failure = failure.copyWith(message: 'Connection timeout with API server');

            break;
          case DioErrorType.unknown:
            failure = failure.copyWith(message: 'Connection to API server failed due to internet connection');

            break;
          case DioErrorType.receiveTimeout:
            failure = failure.copyWith(message: 'Receive timeout in connection with API server');
            break;
          case DioErrorType.badResponse:
            switch (error.response?.statusCode) {
              case 401:
                failure = failure.copyWith(code: 401, message: 'Unauthorized');
                break;
              case 400:
              case 404:
              case 500:
              case 503:
                failure = failure.copyWith(
                    code: error.response?.statusCode, message: error.response?.statusMessage ?? '', type: '');
                break;
              case 422:
                if (error.response?.data is Map) {
                  final errorResponse = error.response?.data as Map;
                  failure = failure.copyWith(
                      code: error.response?.statusCode,
                      message: errorResponse['message'] ?? '',
                      type: errorResponse['type'] ?? '');
                } else {
                  failure = failure.copyWith(
                      code: error.response?.statusCode, message: 'Unexpected error occurred', type: '');
                }
                break;
              default:
                "Unexpected error occurred";
            }
            break;
          case DioErrorType.sendTimeout:
            failure = failure.copyWith(message: 'Send timeout with server');

            break;
          case DioErrorType.badCertificate:
            failure = failure.copyWith(message: 'Bad certificate');
            break;
          case DioErrorType.connectionError:
            failure = failure.copyWith(message: 'Connection error');

            break;
        }
      } else {
        failure = failure.copyWith(message: 'Unexpected error occurred');
      }
    } on FormatException catch (e) {
      failure = failure.copyWith(message: e.toString());
    }

    return failure;
  }

  Failure copyWith({
    int? code,
    String? message,
    String? type,
  }) =>
      Failure(code: code ?? this.code, message: message ?? this.message, type: type ?? this.type);
}
