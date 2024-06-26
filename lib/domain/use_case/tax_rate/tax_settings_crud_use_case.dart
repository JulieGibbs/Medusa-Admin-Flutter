import 'package:injectable/injectable.dart';
import 'package:medusa_admin/core/error/failure.dart';
import 'package:medusa_admin/core/di/di.dart';
import 'package:medusa_admin_dart_client/medusa_admin.dart';
import 'package:multiple_result/multiple_result.dart';

@lazySingleton
class TaxSettingsCrudUseCase {
  TaxRateRepository get _taxRateRepository =>
      getIt<MedusaAdmin>().taxRateRepository;

  static TaxSettingsCrudUseCase get instance => getIt<TaxSettingsCrudUseCase>();

  Future<Result<RetrieveTaxRatesRes, Failure>> fetchAll({
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final result = await _taxRateRepository.retrieveTaxRates(
          queryParams: queryParameters);
      return Success(result!);
    } catch (error) {
      return Error(Failure.from(error));
    }
  }

  Future<Result<TaxRate, Failure>> fetch(
    String id, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final result = await _taxRateRepository.retrieveTaxRate(
          queryParams: queryParameters, id: id);
      return Success(result!);
    } catch (error) {
      return Error(Failure.from(error));
    }
  }

  Future<Result<DeleteTaxRateRes, Failure>> delete(String id) async {
    try {
      final result = await _taxRateRepository.deleteTaxRate(id: id);
      return Success(result!);
    } catch (error) {
      return Error(Failure.from(error));
    }
  }

  Future<Result<TaxRate, Failure>> create(
      CreateTaxRateReq userCreateTaxRateReq) async {
    try {
      final result = await _taxRateRepository.createTaxRate(
          userCreateTaxRateReq: userCreateTaxRateReq);
      return Success(result!);
    } catch (e) {
      return Error(Failure.from(e));
    }
  }

  Future<Result<TaxRate, Failure>> update({
    required String id,
    required UpdateTaxRateReq userUpdateTaxRateReq,
  }) async {
    try {
      final result = await _taxRateRepository.updateTaxRate(
          id: '', userUpdateTaxRateReq: userUpdateTaxRateReq);
      return Success(result!);
    } catch (e) {
      return Error(Failure.from(e));
    }
  }
}
