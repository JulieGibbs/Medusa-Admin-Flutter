import 'package:dartz/dartz.dart';
import 'package:medusa_admin/app/data/models/store/index.dart';

import '../../datasource/remote/exception/api_error_handler.dart';
import '../../models/req/user_create_collection_req.dart';
import '../../models/res/collection.dart';

abstract class BaseCollection {
  Future<Either<UserCollectionsRes, Failure>> retrieveAll(
      {Map<String, dynamic>? customHeaders, Map<String, dynamic>? queryParameters});

  Future<Either<UserCollectionRes, Failure>> retrieve(
      {required String id, Map<String, dynamic>? customHeaders, Map<String, dynamic>? queryParameters});

  Future<Either<UserCreateCollectionRes, Failure>> create(
      {required UserCreateCollectionReq userCreateCollectionReq,
      Map<String, dynamic>? customHeaders,
      Map<String, dynamic>? queryParameters});
}
