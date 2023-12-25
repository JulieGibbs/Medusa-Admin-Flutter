import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:medusa_admin/app/data/models/store/index.dart';
import 'package:medusa_admin/app/modules/products_module/product_details/controllers/product_details_controller.dart';
import 'package:medusa_admin/core/utils/colors.dart';
import 'package:medusa_admin/core/utils/extension.dart';
import 'package:medusa_admin/route/app_router.dart';

import '../../../components/custom_expansion_tile.dart';
import '../../add_update_product/controllers/add_update_product_controller.dart';

class ProductDetailsThumbnail extends GetView<ProductDetailsController> {
  const ProductDetailsThumbnail(
      {super.key,
      required this.product,
      this.onExpansionChanged,
      this.expansionKey});
  final Product product;
  final void Function(bool)? onExpansionChanged;
  final Key? expansionKey;
  @override
  Widget build(BuildContext context) {
    final manatee = ColorManager.manatee;
    final smallTextStyle = context.bodySmall;
    const space = Gap(12);
    final buttonText = product.thumbnail == null ? 'Add' : 'Edit';
    return CustomExpansionTile(
      key: expansionKey,
      maintainState: true,
      onExpansionChanged: onExpansionChanged,
      controlAffinity: ListTileControlAffinity.leading,
      title: Text('Thumbnail', style: Theme.of(context).textTheme.bodyLarge),
      trailing: GetPlatform.isAndroid
          ? TextButton(
              onPressed: () async {
                await context
                    .pushRoute(AddUpdateProductRoute(
                        updateProductReq:
                            UpdateProductReq(product: product, number: 4)))
                    .then((result) async {
                  if (result != null) {
                    await controller.fetchProduct();
                  }
                });
              },
              child: Text(buttonText))
          : CupertinoButton(
              onPressed: () async {
                await context
                    .pushRoute(AddUpdateProductRoute(
                        updateProductReq:
                            UpdateProductReq(product: product, number: 4)))
                    .then((result) async {
                  if (result != null) {
                    await controller.fetchProduct();
                  }
                });
              },
              padding: EdgeInsets.zero,
              child: Text(buttonText)),
      childrenPadding:
          const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      children: [
        if (product.thumbnail != null)
          GestureDetector(
              onTap: () => context.pushRoute(ImagePreviewRoute(
                imageUrl: product.thumbnail!,
                heroTag: 'thumbnail',
              )),
              child: SizedBox(
                  height: 120,
                  child: Hero(
                      tag: 'thumbnail',
                      child: CachedNetworkImage(imageUrl: product.thumbnail!)))),
        if (product.thumbnail == null)
          Text('No thumbnail added',
              style: smallTextStyle?.copyWith(color: manatee)),
        space,
      ],
    );
  }
}
