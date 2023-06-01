import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:medusa_admin/app/data/models/store/draft_order.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../components/keep_alive_widget.dart';
import '../components/draft_order_card.dart';
import '../controllers/draft_orders_controller.dart';

class DraftOrdersView extends GetView<DraftOrdersController> {
  const DraftOrdersView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: 'draft_order',
        onPressed: () async {
          // await Get.toNamed(Routes.CREATE_DRAFT_ORDER);
        },
        child: Platform.isIOS ? const Icon(CupertinoIcons.add) : const Icon(Icons.add),
      ),
      body: SafeArea(
        child: KeepAliveWidget(
          child: SmartRefresher(
            controller: controller.refreshController,
            onRefresh: () => controller.pagingController.refresh(),
            header: GetPlatform.isIOS ? const ClassicHeader(completeText: '') : const MaterialClassicHeader(),
            child: PagedListView.separated(
              padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, kToolbarHeight * 1.4),
              pagingController: controller.pagingController,
              builderDelegate: PagedChildBuilderDelegate<DraftOrder>(
                  itemBuilder: (context, draftOrder, index) => DraftOrderCard(draftOrder),
                  noItemsFoundIndicatorBuilder: (_) =>  Center(child: Text(tr.noDraftOrders)),
                  firstPageProgressIndicatorBuilder: (context) =>
                      const Center(child: CircularProgressIndicator.adaptive())),
              separatorBuilder: (_, __) => const SizedBox(height: 12.0),
            ),
          ),
        ),
      ),
    );
  }
}
