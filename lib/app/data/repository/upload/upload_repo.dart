import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:medusa_admin/app/data/datasource/remote/exception/api_error_handler.dart';
import 'package:medusa_admin/app/data/models/res/upload.dart';
import 'package:medusa_admin/app/data/repository/upload/base_upload.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:dio/dio.dart';
import '../../datasource/remote/dio/dio_client.dart';

class UploadRepo extends BaseUpload {
  final _dataProvider = DioClient(dio: Dio());

  /// Removes an uploaded file using the installed file service
  @override
  Future<Result<UserDeleteFileRes, Failure>> deleteFile({
    /// key of the file to delete
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

  /// Creates a pre-signed download url for a file
  @override
  Future<Result<UserGetFileUrlRes, Failure>> getFileUrl({
    /// key of the file to obtain the download link for
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

  /// Uploads at least one file to the specific file service that is installed in Medusa.
  @override
  Future<Result<UserUploadFileRes, Failure>> uploadFile({
    required List<File> files,
    Map<String, dynamic>? customHeaders,
  }) async {
    try {
      if (customHeaders != null) {
        _dataProvider.dio.options.headers.addAll(customHeaders);
      }
      _dataProvider.dio.options.headers.addAll({'Content-Type': 'image/jpeg'});

      List<MultipartFile> multipartFiles = [];

      for (var file in files) {
        String fileName = file.path.split('/').last;
        multipartFiles.add(await MultipartFile.fromFile(file.path, filename: fileName));
      }

      FormData formData = FormData.fromMap({"files": multipartFiles});

      final response = await _dataProvider.post(uri: '/uploads', data: formData);
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

  /// Uploads at least one file with ACL or a non-public bucket to the specific file service that is installed in Medusa.
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
