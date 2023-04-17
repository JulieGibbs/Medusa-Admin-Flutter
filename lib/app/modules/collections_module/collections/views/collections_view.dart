import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:medusa_admin/app/data/models/store/index.dart';
import 'package:medusa_admin/app/modules/components/adaptive_filled_button.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../routes/app_pages.dart';
import '../components/collection_list_tile.dart';
import '../controllers/collections_controller.dart';

class CollectionsView extends GetView<CollectionsController> {
  const CollectionsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final largeTextStyle = Theme.of(context).textTheme.titleLarge;
    final mediumTextStyle = Theme.of(context).textTheme.titleMedium;
    return Scaffold(
      body: SafeArea(
        child: SmartRefresher(
          controller: controller.refreshController,
          onRefresh: () => controller.pagingController.refresh(),
          header: GetPlatform.isIOS ? const ClassicHeader(completeText: '') : const MaterialClassicHeader(),
          child: PagedListView(
            pagingController: controller.pagingController,
            padding: const EdgeInsets.only(bottom: kToolbarHeight),
            builderDelegate: PagedChildBuilderDelegate<ProductCollection>(
              itemBuilder: (context, collection, index) => CollectionListTile(collection,
                  tileColor: index.isOdd ? Theme.of(context).appBarTheme.backgroundColor : null),
              firstPageProgressIndicatorBuilder: (context) => const Center(child: CircularProgressIndicator.adaptive()),
              noItemsFoundIndicatorBuilder: (_) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (controller.searchTerm.value.isEmpty)
                    Column(
                      children: [
                        Text('No collections yet!', style: largeTextStyle, textAlign: TextAlign.center),
                        const SizedBox(height: 12.0),
                        AdaptiveFilledButton(
                            onPressed: () => Get.toNamed(Routes.CREATE_COLLECTION),
                            child: const Text('Add collection', style: TextStyle(color: Colors.white)))
                      ],
                    ),
                  if (controller.searchTerm.value.isNotEmpty) Text('No collections found', style: mediumTextStyle),
                ],
              ),
            ),
            // separatorBuilder: (_, __) =>
            //     GetPlatform.isAndroid ? const Divider(height: 0) : const Divider(height: 0, indent: 16.0),
          ),
        ),
      ),
    );
  }
}
