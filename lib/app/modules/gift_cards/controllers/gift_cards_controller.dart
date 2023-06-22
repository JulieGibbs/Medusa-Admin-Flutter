import 'dart:async';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:medusa_admin/app/data/models/store/index.dart';
import 'package:medusa_admin/app/data/repository/gift_card/gift_card_repo.dart';
import 'package:medusa_admin/app/data/repository/product/products_repo.dart';

class GiftCardsController extends GetxController {
  GiftCardsController({required this.giftCardRepo, required this.productsRepo});
  final GiftCardRepo giftCardRepo;
  final ProductsRepo productsRepo;
  final giftCardsPagingController = PagingController<int, GiftCard>(firstPageKey: 0, invisibleItemsThreshold: 6);
  final productsPagingController = PagingController<int, Product>(firstPageKey: 0, invisibleItemsThreshold: 6);
  final int _pageSize = 20;

  @override
  void onInit() {
    giftCardsPagingController.addPageRequestListener((pageKey) => _fetchGiftCards(pageKey));
    productsPagingController.addPageRequestListener((pageKey) => _fetchProductGiftCards(pageKey));
    super.onInit();
  }

  Future<void> _fetchGiftCards(int pageKey) async {
    final result = await giftCardRepo.retrieveGiftCards(
      queryParameters: {
        'offset': giftCardsPagingController.itemList?.length ?? 0,
        'limit': _pageSize,
      },
    );
    result.when((success) {
      if (success.giftCards == null) {
        giftCardsPagingController.error = 'Error loading gift cards, received null value';
        return;
      }
      final isLastPage = success.giftCards!.length < _pageSize;
      if (isLastPage) {
        giftCardsPagingController.appendLastPage(success.giftCards!);
      } else {
        final nextPageKey = pageKey + success.giftCards!.length;
        giftCardsPagingController.appendPage(success.giftCards!, nextPageKey);
      }
      // refreshController.refreshCompleted();
    }, (error) {
      giftCardsPagingController.error = 'Error loading gift cards';
      // refreshController.refreshFailed();
    });
  }

  Future<void> _fetchProductGiftCards(int pageKey) async {
    final result = await productsRepo.retrieveAll(queryParams: {
      'is_giftcard': true,
    });
    result.when((success) {
      if (success.products == null) {
        productsPagingController.error = 'Error loading gift cards, received null value';
        return;
      }
      final isLastPage = success.products!.length < _pageSize;
      if (isLastPage) {
        productsPagingController.appendLastPage(success.products!);
      } else {
        final nextPageKey = pageKey + success.products!.length;
        productsPagingController.appendPage(success.products!, nextPageKey);
      }
      // refreshController.refreshCompleted();
    }, (error) {
      productsPagingController.error = 'Error loading gift cards';
      // refreshController.refreshFailed();
    });
  }
}
