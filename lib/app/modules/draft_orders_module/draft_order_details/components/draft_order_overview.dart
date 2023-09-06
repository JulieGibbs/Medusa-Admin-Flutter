import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:medusa_admin/app/data/models/store/index.dart';
import 'package:medusa_admin/app/data/service/store_service.dart';
import 'package:medusa_admin/app/modules/components/currency_formatter.dart';
import 'package:medusa_admin/app/modules/components/date_time_card.dart';
import 'package:medusa_admin/app/modules/draft_orders_module/draft_orders/components/draft_order_status_label.dart';

class DraftOrderOverview extends StatelessWidget {
  const DraftOrderOverview(this.draftOrder, {Key? key}) : super(key: key);
  final DraftOrder draftOrder;
  @override
  Widget build(BuildContext context) {
    final smallTextStyle = Theme.of(context).textTheme.titleSmall;
    final mediumTextStyle = Theme.of(context).textTheme.titleMedium;
    final lightWhite = Get.isDarkMode ? Colors.white54 : Colors.black54;
    final email = draftOrder.cart?.email;
    final billingAddress = draftOrder.cart?.billingAddress;
    final currencyCode = draftOrder.cart!.region!.currencyCode;
    var amount = draftOrder.cart!.total!;
    final currencyFormatter = CurrencyTextInputFormatter(name: currencyCode);

    final symbolNative =
        StoreService.store.currencies?.firstWhere((element) => element.code == currencyCode, orElse: (){
          final simpleCurrency = NumberFormat.simpleCurrency(name: currencyCode?.toUpperCase());
          return Currency(name:simpleCurrency.currencyName, symbolNative:simpleCurrency.currencySymbol , code:simpleCurrency.currencyName);
        }).symbolNative;

    const space = SizedBox(height: 12.0);
    const halfSpace = SizedBox(height: 6.0);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        color: Theme.of(context).expansionTileTheme.backgroundColor,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('#${draftOrder.displayId!}', style: Theme.of(context).textTheme.titleLarge),
                  halfSpace,
                  if (draftOrder.cart != null && draftOrder.cart!.createdAt != null)
                    Text(
                      'on ${formatDate(draftOrder.cart!.createdAt)} at ${formatTime(draftOrder.cart!.createdAt)}',
                      style: Theme.of(context).textTheme.titleMedium,
                    )
                ],
              ),
              DraftOrderStatusLabel(draftOrder.status!),
            ],
          ),
          space,
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(email ?? 'Email: N/A', style: mediumTextStyle),
                      const SizedBox(height: 6.0),
                      Text(billingAddress?.phone?.toString() ?? 'Phone: N/A',
                          style: smallTextStyle?.copyWith(color: lightWhite)),
                    ],
                  ),
                ),
                const VerticalDivider(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${symbolNative ?? ''} ${currencyFormatter.format(amount.toString())}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 6.0),
                    Text(
                      'Amount (${currencyCode?.toUpperCase()})',
                      style: smallTextStyle?.copyWith(color: lightWhite),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
