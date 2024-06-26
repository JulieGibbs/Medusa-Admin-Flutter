import 'package:injectable/injectable.dart';
import 'package:medusa_admin/core/error/failure.dart';
import 'package:medusa_admin_dart_client/medusa_admin.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../core/di/di.dart';

@lazySingleton
class ShippingProfileCrudUseCase {
  ShippingProfileRepository get _shippingProfileRepository =>
      getIt<MedusaAdmin>().shippingProfileRepository;

  Future<Result<ShippingProfile, Failure>> create(
      CreateShippingProfileReq userCreateShippingProfileReq) async {
    try {
      final result = await _shippingProfileRepository.create(
          userCreateShippingProfileReq: userCreateShippingProfileReq);
      return Success(result!);
    } catch (error) {
      return Error(Failure.from(error));
    }
  }

  Future<Result<ShippingProfile, Failure>> update(
      {required String id,
      required UpdateShippingProfileReq
          userUpdateShippingProfileReq}) async {
    try {
      final result = await _shippingProfileRepository.update(
          userUpdateShippingProfileReq: userUpdateShippingProfileReq, id: id);
      return Success(result!);
    } catch (error) {
      return Error(Failure.from(error));
    }
  }

  Future<Result<RetrieveAllShippingProfileRes, Failure>> loadAll(
      {Map<String, dynamic>? queryParams}) async {
    try {
      final result = await _shippingProfileRepository.retrieveAll(
          queryParams: queryParams);
      return Success(result!);
    } catch (error) {
      return Error(Failure.from(error));
    }
  }

  Future<Result<ShippingProfile, Failure>> load(String id,
      {Map<String, dynamic>? queryParams}) async {
    try {
      final result = await _shippingProfileRepository.retrieve(
          id: id, queryParams: queryParams);
      return Success(result!);
    } catch (error) {
      return Error(Failure.from(error));
    }
  }

  Future<Result<DeleteShippingProfileRes, Failure>> delete(
      String id) async {
    try {
      final result = await _shippingProfileRepository.delete(id: id);
      return Success(result!);
    } catch (error) {
      return Error(Failure.from(error));
    }
  }
}
