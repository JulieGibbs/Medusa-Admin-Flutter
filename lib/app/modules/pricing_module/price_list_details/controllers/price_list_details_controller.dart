import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:medusa_admin/app/data/models/store/index.dart';
import 'package:medusa_admin/app/data/repository/price_list/price_list_repo.dart';
import 'package:medusa_admin/app/modules/components/easy_loading.dart';
import 'package:medusa_admin/app/modules/pricing_module/pricing/controllers/pricing_controller.dart';

class PriceListDetailsController extends GetxController with StateMixin<PriceList> {
  PriceListDetailsController({required this.priceListRepo});
  final PriceListRepo priceListRepo;
  String id = Get.arguments;
  final pagingController = PagingController<int, Product>(firstPageKey: 0, invisibleItemsThreshold: 6);
  final int _pageSize = 20;
  @override
  Future<void> onInit() async {
    await loadPriceList();
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.onInit();
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }
  //
  // @override
  // void onClose() {
  //   super.onClose();
  // }

  Future<void> deletePriceList(BuildContext context) async {
    final confirmDelete = await showOkCancelAlertDialog(
      context: context,
      title: 'Delete price list',
      message: 'Are you sure you want to delete this price list?',
      okLabel: 'Yes, delete',
      isDestructiveAction: true,
    );
    if (confirmDelete != OkCancelResult.ok) {
      return;
    }

    loading();
    final result = await priceListRepo.deletePriceList(id: id);

    result.when(
      (success) {
        if (success.deleted) {
          EasyLoading.showSuccess('Price list deleted');
          PricingController.instance.pagingController.refresh();
          Get.back();
        } else {
          Get.snackbar('Error deleting price list', 'Unknown error', snackPosition: SnackPosition.BOTTOM);
        }
      },
      (error) => Get.snackbar('Error deleting price list ${error.code ?? ''}', error.message,
          snackPosition: SnackPosition.BOTTOM),
    );
  }

  Future<void> loadPriceList() async {
    change(null, status: RxStatus.loading());
    final result = await priceListRepo.retrievePriceList(id: id);
    result.when((success) => change(success.priceList!, status: RxStatus.success()),
        (error) => change(null, status: RxStatus.error(error.message)));
  }

  Future<void> loadPriceListProducts() async {
    change(null, status: RxStatus.loading());
    final result = await priceListRepo.retrievePriceListProducts(id: id);

    result.when((success) {}, (error) {});
  }

  Future<void> _fetchPage(int pageKey) async {
    final result = await priceListRepo.retrievePriceListProducts(
      id: id,
      queryParameters: {
        'offset': pagingController.itemList?.length ?? 0,
        'limit': _pageSize,
      },
    );

    result.when((success) {
      final isLastPage = success.products!.length < _pageSize;
      update([5]);
      if (isLastPage) {
        pagingController.appendLastPage(success.products!);
      } else {
        final nextPageKey = pageKey + success.products!.length;
        pagingController.appendPage(success.products!, nextPageKey);
      }
    }, (error) {
      pagingController.error = error.message;
    });
  }
}
