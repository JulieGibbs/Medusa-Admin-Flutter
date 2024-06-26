import 'package:injectable/injectable.dart';
import 'package:medusa_admin/core/error/failure.dart';
import 'package:medusa_admin/core/di/di.dart';
import 'package:medusa_admin_dart_client/medusa_admin.dart';
import 'package:multiple_result/multiple_result.dart';

@lazySingleton
class CreateDraftUseCase {
  DraftOrderRepository get _draftRepository =>
      getIt<MedusaAdmin>().draftOrderRepository;
  static CreateDraftUseCase get instance => getIt<CreateDraftUseCase>();

  Future<Result<DraftOrder, Failure>> call(
    CreateDraftOrderReq userCreateDraftOrderReq,
  ) async {
    try {
      final result = await _draftRepository.createDraftOrder(
          userCreateDraftOrderReq: userCreateDraftOrderReq);
      return Success(result!);
    } catch (error) {
      return Error(Failure.from(error));
    }
  }
}
