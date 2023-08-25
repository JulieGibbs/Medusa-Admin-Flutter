import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:medusa_admin/app/data/models/store/index.dart';
import 'package:medusa_admin/app/data/repository/product/products_repo.dart';
import 'package:medusa_admin/app/modules/components/adaptive_back_button.dart';
import 'package:medusa_admin/app/modules/components/adaptive_button.dart';
import 'package:medusa_admin/app/modules/discount_module/discount_conditions/components/condition_product_list_tile.dart';

import '../../../components/search_text_field.dart';
import '../controllers/discount_conditions_controller.dart';
import 'condition_operator_card.dart';
import 'package:medusa_admin/core/utils/enums.dart';

class ConditionProductView extends StatelessWidget {
  const ConditionProductView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const space = SizedBox(height: 12.0);
    return GetBuilder<ConditionProductController>(
      init: ConditionProductController(productsRepo: ProductsRepo()),
      builder: (controller) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  leading: const AdaptiveBackButton(),
                  title: const Text('Choose products'),
                  actions: [
                    AdaptiveButton(
                        onPressed: controller.selectedProducts.isNotEmpty
                            ? () {
                                final res = DiscountConditionRes(
                                    operator:
                                        controller.discountConditionOperator,
                                    products: controller.selectedProducts,
                                    conditionType:
                                        DiscountConditionType.products);
                                Get.back(result: res);
                              }
                            : null,
                        child: const Text('Save')),
                  ],
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(kToolbarHeight),
                    child: Container(
                      height: kToolbarHeight,
                      padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4.0),
                      child: SearchTextField(
                        fillColor: context.theme.scaffoldBackgroundColor,
                        controller: controller.searchCtrl,
                        hintText:
                        'Search for product name, variant title ...',
                        onSuffixTap: () {
                          if (controller.searchTerm.isEmpty) return;
                          controller.searchCtrl.clear();
                          controller.searchTerm = '';
                          controller.pagingController.refresh();
                        },
                        onSubmitted: (val) {
                          if (controller.searchTerm != val &&
                              val.isNotEmpty) {
                            controller.searchTerm = val;
                            controller.pagingController.refresh();
                          }
                        },
                      ),
                    ),
                  ),
                ),
                if (!controller.updateMode)
                  SliverToBoxAdapter(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 8.0),
                    child: Column(
                      children: [
                        ConditionOperatorCard(
                          conditionOperator: DiscountConditionOperator.inn,
                          groupValue: controller.discountConditionOperator,
                          onTap: (val) {
                            controller.discountConditionOperator = val;
                            controller.update();
                          },
                        ),
                        space,
                        ConditionOperatorCard(
                          conditionOperator: DiscountConditionOperator.notIn,
                          groupValue: controller.discountConditionOperator,
                          onTap: (val) {
                            controller.discountConditionOperator = val;
                            controller.update();
                          },
                        ),
                      ],
                    ),
                  )),
                SliverSafeArea(
                  top: false,
                  sliver: PagedSliverList.separated(
                    separatorBuilder: (_, __) =>
                        const Divider(height: 0, indent: 16),
                    pagingController: controller.pagingController,
                    builderDelegate: PagedChildBuilderDelegate<Product>(
                      itemBuilder: (context, product, index) =>
                          ProductListTileWithVariantCount(
                              enabled: !controller.disabledProducts
                                  .map((e) => e.id!)
                                  .toList()
                                  .contains(product.id),
                              product: product,
                              value: controller.selectedProducts
                                  .map((e) => e.id!)
                                  .toList()
                                  .contains(product.id),
                              onChanged: (val) {
                                if (val == null) return;
                                if (val) {
                                  controller.selectedProducts.add(product);
                                } else {
                                  controller.selectedProducts
                                      .removeWhere((e) => e.id == product.id);
                                }
                                controller.update();
                              }),
                      firstPageProgressIndicatorBuilder: (context) =>
                          const Center(
                              child: CircularProgressIndicator.adaptive()),
                      noItemsFoundIndicatorBuilder: (context) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('No products found'),
                            if (controller.searchTerm.isNotEmpty)
                              AdaptiveButton(
                                  onPressed: () {
                                    controller.searchTerm = '';
                                    controller.searchCtrl.clear();
                                    controller.pagingController.refresh();
                                  },
                                  child: const Text('Clear search')),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ConditionProductController extends GetxController {
  ConditionProductController({required this.productsRepo});

  final ProductsRepo productsRepo;
  DiscountConditionOperator discountConditionOperator =
      DiscountConditionOperator.inn;
  final PagingController<int, Product> pagingController =
      PagingController(firstPageKey: 0, invisibleItemsThreshold: 6);
  final int _pageSize = 20;
  List<Product> selectedProducts = <Product>[];
  final List<Product> disabledProducts =
      Get.arguments is List<Product> ? Get.arguments : [];

  bool get updateMode => disabledProducts.isNotEmpty;
  final searchCtrl = TextEditingController();
  String searchTerm = '';

  @override
  void onInit() {
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.onInit();
  }

  @override
  void onClose() {
    searchCtrl.dispose();
    pagingController.dispose();
    super.onClose();
  }

  Future<void> _fetchPage(int pageKey) async {
    final result = await productsRepo.retrieveAll(
      queryParameters: {
        'offset': pagingController.itemList?.length ?? 0,
        'limit': _pageSize,
        'is_giftcard': 'false',
        if (searchTerm.isNotEmpty) 'q': searchTerm,
      },
    );

    result.when((success) {
      final isLastPage = success.products!.length < _pageSize;
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
