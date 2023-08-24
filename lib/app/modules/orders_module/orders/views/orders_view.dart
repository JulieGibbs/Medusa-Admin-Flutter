import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:medusa_admin/app/modules/components/scrolling_expandable_fab.dart';
import 'package:medusa_admin/app/modules/medusa_search/controllers/medusa_search_controller.dart';
import 'package:medusa_admin/app/modules/orders_module/orders/components/orders_filter_view.dart';
import 'package:medusa_admin/app/routes/app_pages.dart';
import 'package:medusa_admin/core/utils/medusa_icons_icons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../../core/utils/colors.dart';
import '../../../../../core/utils/enums.dart';
import '../../../../data/models/store/order.dart';
import '../../../components/adaptive_button.dart';
import '../../../components/adaptive_icon.dart';
import '../components/order_card.dart';
import '../controllers/orders_controller.dart';

class OrdersView extends GetView<OrdersController> {
  const OrdersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: const OrdersBottomAppBar(),
      floatingActionButton: ScrollingExpandableFab(
        controller: controller.scrollController,
        label: 'Export Orders',
        icon: const Icon(MedusaIcons.arrow_up_tray),
        onPressed: () {},
      ),
      body: SmartRefresher(
        controller: controller.refreshController,
        onRefresh: () => controller.pagingController.refresh(),
        header: GetPlatform.isIOS
            ? const ClassicHeader(completeText: '')
            : const MaterialClassicHeader(),
        child: PagedListView.separated(
          scrollController: controller.scrollController,
          padding: const EdgeInsets.only(bottom: 120, top: 4.0),
          pagingController: controller.pagingController,
          builderDelegate: PagedChildBuilderDelegate<Order>(
              itemBuilder: (context, order, index) =>
                  AlternativeOrderCard(order),
              noItemsFoundIndicatorBuilder: (_) {
                if (controller.orderFilter != null &&
                    controller.orderFilter?.count() != 0) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('No Orders found'),
                      AdaptiveButton(
                          onPressed: () => controller.resetFilter(),
                          child: const Text('Clear filters'))
                    ],
                  );
                }

                return Center(child: Text(tr.noOrders));
              },
              firstPageProgressIndicatorBuilder: (context) =>
                  const Center(child: CircularProgressIndicator.adaptive())),
          separatorBuilder: (_, __) => const Divider(height: 1),
        ),
      ),
    );
  }
}

class OrdersBottomAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const OrdersBottomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final lightWhite = Get.isDarkMode ? Colors.white54 : Colors.black54;
    return Container(
      color: context.theme.appBarTheme.backgroundColor,
      height: kToolbarHeight,
      child: Row(
        children: [
          AdaptiveIcon(
              onPressed: () async => await Get.toNamed(Routes.MEDUSA_SEARCH,
                  arguments: SearchReq(searchCategory: SearchCategory.orders)),
              icon: const Icon(MedusaIcons.magnifying_glass)),
          const SizedBox(width: 6.0),
          GetBuilder<OrdersController>(builder: (controller) {
            return InkWell(
              onLongPress: () => controller.resetFilter(),
              onTap: () async {
                await showBarModalBottomSheet(
                    context: context,
                    builder: (context) => OrdersFilterView(
                      regions: controller.regions,
                      orderFilter: controller.orderFilter,
                      context: context,
                      salesChannels: controller.salesChannels,
                      onResetTap: (){
                        controller.resetFilter();
                        Get.back();
                      },
                    )).then((result) {
                      if(result is OrderFilter){
                        controller.updateFilter(result);
                      }
                });
              },
              child: Chip(
                side: BorderSide(
                    color: (controller.orderFilter?.count() ?? 0) != 0
                        ? ColorManager.primary
                        : Colors.transparent),
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6.0))),
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Filters',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(color: lightWhite)),
                    if (controller.orderFilter?.count() != null &&
                        controller.orderFilter?.count() != 0)
                      Text(' ${controller.orderFilter?.count() ?? ''}',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(color: ColorManager.primary)),
                  ],
                ),
                padding: EdgeInsets.zero,
              ),
            );
          }),
        ],
      ),
    );
  }
}
