import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:medusa_admin/app/data/repository/collection/collection_repo.dart';
import 'package:medusa_admin/app/data/repository/product/products_repo.dart';
import 'package:medusa_admin/app/modules/components/adaptive_button.dart';
import 'package:medusa_admin/app/modules/components/easy_loading.dart';
import '../../../../data/models/req/user_collection_req.dart';
import '../../../../data/models/store/product.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';

import '../../../components/adaptive_close_button.dart';

class CollectionProductsList extends StatelessWidget {
  const CollectionProductsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CollectionProductsController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            leading: const AdaptiveCloseButton(),
            title: const Text('Products'),
            actions: [
              AdaptiveButton(
                  onPressed: controller.isEqual
                      ? null
                      : () {
                          controller.save();
                        },
                  child: const Text('Save'))
            ],
          ),
          body: SafeArea(
              child: PagedListView(
            pagingController: controller.pagingController,
            builderDelegate: PagedChildBuilderDelegate<Product>(
                itemBuilder: (context, product, index) {
                  return CheckboxListTile(
                    title: Text(product.title!),
                    subtitle: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _getStatusIcon(product.status),
                        const SizedBox(width: 4.0),
                        Text(product.status.name.capitalize ?? product.status.name,
                            style: Theme.of(context).textTheme.titleSmall),
                      ],
                    ),
                    controlAffinity: ListTileControlAffinity.trailing,
                    secondary: product.thumbnail != null
                        ? SizedBox(
                            width: 45,
                            child: CachedNetworkImage(
                              key: ValueKey(product.thumbnail!),
                              imageUrl: product.thumbnail!,
                              placeholder: (context, text) => const Center(child: CircularProgressIndicator.adaptive()),
                              errorWidget: (context, string, error) =>
                                  const Icon(Icons.warning_rounded, color: Colors.redAccent),
                            ))
                        : null,
                    value: controller.productsIds.contains(product.id),
                    selected: product.collectionId == controller.collectionId,
                    onChanged: (value) {
                      if (value != null && value) {
                        controller.productsIds.add(product.id!);
                      } else if (value != null && !value) {
                        controller.productsIds.remove(product.id!);
                      }
                      controller.update();
                    },
                  );
                },
                firstPageProgressIndicatorBuilder: (context) =>
                    const Center(child: CircularProgressIndicator.adaptive())),
          )),
        );
      },
    );
  }

  Widget _getStatusIcon(ProductStatus status) {
    switch (status) {
      case ProductStatus.draft:
        return const Icon(Icons.circle, color: Colors.grey, size: 12);
      case ProductStatus.proposed:
        return const Icon(Icons.circle, color: Colors.grey, size: 12);

      case ProductStatus.published:
        return const Icon(Icons.circle, color: Colors.green, size: 12);

      case ProductStatus.rejected:
        return const Icon(Icons.circle, color: Colors.red, size: 12);
    }
  }
}

class CollectionProductsController extends GetxController {
  CollectionProductsController({required this.productsRepo, required this.collectionRepo});

  CollectionRepo collectionRepo;
  ProductsRepo productsRepo;
  final String collectionId = Get.arguments;
  final int _pageSize = 20;
  final PagingController<int, Product> pagingController = PagingController(firstPageKey: 0, invisibleItemsThreshold: 6);
  List<String> productsIds = [];
  final List<String> originalProductsIds = [];
  Function eq = const SetEquality().equals;
  bool get isEqual => eq(productsIds.toSet(), originalProductsIds.toSet());

  @override
  void onInit() {
    pagingController.addPageRequestListener((pageKey) => _fetchPage(pageKey));
    super.onInit();
  }

  Future<void> _fetchPage(int pageKey) async {
    final result = await productsRepo.retrieveAll(
      queryParameters: {
        'fields': 'id,title,thumbnail,status,handle,collection_id',
        'offset': pagingController.itemList?.length ?? 0,
        'limit': _pageSize,
      },
    );

    result.when((success) {
      final isLastPage = success.products!.length < _pageSize;
      success.products?.forEach((product) {
        productsIds.addIf(product.collectionId == collectionId, product.id!);
        originalProductsIds.addIf(product.collectionId == collectionId, product.id!);
      });

      if (isLastPage) {
        pagingController.appendLastPage(success.products!);
      } else {
        final nextPageKey = pageKey + success.products!.length;
        pagingController.appendPage(success.products!, nextPageKey);
      }
    }, (error) => pagingController.error = error.message);
  }

  Future<void> save() async {
    final addedProducts = productsIds.toSet().difference(originalProductsIds.toSet()).toList();
    final removedProducts = originalProductsIds.toSet().difference(productsIds.toSet()).toList();
    loading();
    if (addedProducts.isNotEmpty) {
      final result = await collectionRepo.updateProducts(
          userCollectionUpdateProductsReq:
              UserCollectionUpdateProductsReq(collectionId: collectionId, productsIds: addedProducts));
      result.when((success) {
        if (removedProducts.isEmpty) {
          EasyLoading.showSuccess('Collection updated');
          Get.back(result: true);
        } else {
          EasyLoading.showError('Error updating collection');
          return;
        }
      }, (error) {
        EasyLoading.showError('Error updating collection');
        return;
      });
    }
    if (removedProducts.isNotEmpty) {
      final result = await collectionRepo.removeProducts(
          userCollectionRemoveProductsReq:
              UserCollectionRemoveProductsReq(collectionId: collectionId, productsIds: removedProducts));
      result.when((success) {
        EasyLoading.showSuccess('Collection updated');
        Get.back(result: true);
      }, (error) {
        EasyLoading.showError('Error updating collection');
        return;
      });
    }
    dismissLoading();
  }
}

class CollectionProductsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CollectionProductsController(productsRepo: ProductsRepo(), collectionRepo: CollectionRepo()));
  }
}
