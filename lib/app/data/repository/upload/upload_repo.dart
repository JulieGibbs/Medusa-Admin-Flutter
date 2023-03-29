import 'dart:developer';
import 'package:medusa_admin/app/data/datasource/remote/exception/api_error_handler.dart';
import 'package:medusa_admin/app/data/models/res/upload.dart';
import 'package:medusa_admin/app/data/repository/upload/base_upload.dart';
import 'package:multiple_result/multiple_result.dart';
import '../../service/dio_service.dart';

class UploadRepo extends BaseUpload {
  final _dataProvider = DioService.instance.dio;

  @override
  Future<Result<UserDeleteFileRes, Failure>> deleteFile({
    required String fileKey,
    Map<String, dynamic>? customHeaders,
  }) async {
    try {
      if (customHeaders != null) {
        _dataProvider.dio.options.headers.addAll(customHeaders);
      }
      final response = await _dataProvider.delete('/uploads', data: {'file_key': fileKey});
      if (response.statusCode == 200) {
        return Success(UserDeleteFileRes.fromJson(response.data));
      } else {
        return Error(Failure.from(response));
      }
    } catch (error, stackTrace) {
      log(error.toString(), stackTrace: stackTrace);
      return Error(Failure.from(error));
    }
  }

  @override
  Future<Result<UserGetFileUrlRes, Failure>> getFileUrl({
    required String fileKey,
    Map<String, dynamic>? customHeaders,
  }) async {
    try {
      if (customHeaders != null) {
        _dataProvider.dio.options.headers.addAll(customHeaders);
      }
      final response = await _dataProvider.post(uri: '/uploads/download-url', data: {'file_key': fileKey});
      if (response.statusCode == 200) {
        return Success(UserGetFileUrlRes.fromJson(response.data));
      } else {
        return Error(Failure.from(response));
      }
    } catch (error, stackTrace) {
      log(error.toString(), stackTrace: stackTrace);
      return Error(Failure.from(error));
    }
  }

  @override
  Future<Result<UserUploadFileRes, Failure>> uploadFile({
    required List<String> files,
    Map<String, dynamic>? customHeaders,
  }) async {
    try {
      if (customHeaders != null) {
        _dataProvider.dio.options.headers.addAll(customHeaders);
      }
      final response = await _dataProvider.post(uri: '/uploads/download-url', data: {'files': files});
      if (response.statusCode == 200) {
        return Success(UserUploadFileRes.fromJson(response.data));
      } else {
        return Error(Failure.from(response));
      }
    } catch (error, stackTrace) {
      log(error.toString(), stackTrace: stackTrace);
      return Error(Failure.from(error));
    }
  }

  @override
  Future<Result<UserUploadFileRes, Failure>> uploadProtectedFile({
    required List<String> files,
    Map<String, dynamic>? customHeaders,
  }) async {
    try {
      if (customHeaders != null) {
        _dataProvider.dio.options.headers.addAll(customHeaders);
      }
      final response = await _dataProvider.post(uri: '/uploads/download-url', data: {'files': files});
      if (response.statusCode == 200) {
        return Success(UserUploadFileRes.fromJson(response.data));
      } else {
        return Error(Failure.from(response));
      }
    } catch (error, stackTrace) {
      log(error.toString(), stackTrace: stackTrace);
      return Error(Failure.from(error));
    }
  }
}
