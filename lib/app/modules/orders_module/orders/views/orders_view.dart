import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:medusa_admin/app/modules/components/keep_alive_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../data/models/store/order.dart';
import '../../../draft_orders_module/draft_orders/views/draft_orders_view.dart';
import '../components/order_card.dart';
import '../components/orders_app_bar.dart';
import '../controllers/orders_controller.dart';

class OrdersView extends GetView<OrdersController> {
  const OrdersView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final tabController = controller.tabController;
    return Scaffold(
      appBar: OrdersAppBar(tabController: tabController, topViewPadding: MediaQuery.of(context).viewPadding.top),
      body: SafeArea(
        child: TabBarView(physics: const NeverScrollableScrollPhysics(), controller: tabController, children: [
          KeepAliveWidget(
            child: Scaffold(
              floatingActionButton: FloatingActionButton(
                heroTag: 'orders',
                onPressed: () {},
                child: Icon(Icons.adaptive.share),
              ),
              body: SmartRefresher(
                controller: controller.refreshController,
                onRefresh: () => controller.pagingController.refresh(),
                header: GetPlatform.isIOS ? const ClassicHeader(completeText: '') : const MaterialClassicHeader(),
                child: PagedListView.separated(
                  padding: const EdgeInsets.all(12.0),
                  pagingController: controller.pagingController,
                  builderDelegate: PagedChildBuilderDelegate<Order>(
                      itemBuilder: (context, order, index) => AlternativeOrderCard(order),
                      noItemsFoundIndicatorBuilder: (_) => const Center(child: Text('No orders yet!')),
                      firstPageProgressIndicatorBuilder: (context) =>
                          const Center(child: CircularProgressIndicator.adaptive())),
                  separatorBuilder: (_, __) => const SizedBox(height: 12.0),
                ),
              ),
            ),
          ),
          const KeepAliveWidget(child: DraftOrdersView())
        ]),
      ),
    );
  }
}
