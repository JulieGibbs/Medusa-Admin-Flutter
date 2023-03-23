import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:medusa_admin/app/data/models/store/index.dart';
import 'package:medusa_admin/app/data/repository/collection/collection_repo.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CollectionsController extends GetxController {
  static CollectionsController instance = Get.find<CollectionsController>();
  CollectionsController({required this.collectionRepo});
  final CollectionRepo collectionRepo;
  RxInt collectionCount = 0.obs;
  RefreshController refreshController = RefreshController();

  final PagingController<int, ProductCollection> pagingController =
      PagingController(firstPageKey: 0, invisibleItemsThreshold: 6);
  final int _pageSize = 20;

  @override
  void onInit() {
    pagingController.addPageRequestListener((pageKey) {
      debugPrint('Getting data');
      _fetchPage(pageKey);
    });
    super.onInit();
  }



  Future<void> _fetchPage(int pageKey) async {
    final result = await collectionRepo.retrieveAll(queryParameters: {
      'offset': pagingController.itemList?.length ?? 0,
      'limit': _pageSize,
    });
    result.when((success) {
      final isLastPage = success.collections!.length < _pageSize;
      collectionCount.value = success.count ?? 0;
      if (isLastPage) {
        pagingController.appendLastPage(success.collections!);
      } else {
        final nextPageKey = pageKey + success.collections!.length;
        pagingController.appendPage(success.collections!, nextPageKey);
      }
      refreshController.refreshCompleted();
    }, (error) {
      refreshController.refreshFailed();
      pagingController.error = 'Error loading orders';
    });
  }
}
