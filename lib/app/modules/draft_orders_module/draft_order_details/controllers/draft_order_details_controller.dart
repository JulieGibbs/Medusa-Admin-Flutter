import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medusa_admin/app/data/models/store/index.dart';
import 'package:medusa_admin/app/data/repository/draft_order/draft_order_repo.dart';
import 'package:medusa_admin/app/modules/components/easy_loading.dart';
import 'package:medusa_admin/app/modules/draft_orders_module/draft_orders/controllers/draft_orders_controller.dart';

class DraftOrderDetailsController extends GetxController with StateMixin<DraftOrder> {
  DraftOrderDetailsController({required this.draftOrderRepo});

  final DraftOrderRepo draftOrderRepo;
  final scrollController = ScrollController();
  final summeryKey = GlobalKey();
  final paymentKey = GlobalKey();
  final shippingKey = GlobalKey();
  final customerKey = GlobalKey();
  String id = Get.arguments;

  @override
  Future<void> onInit() async {
    await loadDraftOrder();
    super.onInit();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  Future<void> loadDraftOrder() async {
    change(null, status: RxStatus.loading());
    final result = await draftOrderRepo.retrieveDraftOrder(
      id: id,
      queryParameters: {
        'expand': 'order,cart',
      },
    );
    result.when((success) {
      if (success.draftOrder != null) {
        change(success.draftOrder!, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.empty());
      }
    }, (error) => change(null, status: RxStatus.error(error.message)));
  }

  Future<void> markAsPaid() async {
    loading();
    final result = await draftOrderRepo.registerPayment(id: id);
    result.when((success) async {
      if (success.order != null) {
        Get.snackbar('Success', 'Successfully marked as paid', snackPosition: SnackPosition.BOTTOM);
      }
      await loadDraftOrder();
      DraftOrdersController.instance.pagingController.refresh();
    }, (error) {
      Get.snackbar('Error marking as paid ${error.code ?? ''}', error.message, snackPosition: SnackPosition.BOTTOM);
    });
    dismissLoading();
  }
}
