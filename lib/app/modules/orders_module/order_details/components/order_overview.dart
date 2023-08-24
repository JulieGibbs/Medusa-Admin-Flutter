import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medusa_admin/app/data/models/store/index.dart';
import 'package:medusa_admin/app/modules/components/date_time_card.dart';

import 'order_status_label.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrderOverview extends StatelessWidget {
  const OrderOverview({Key? key, required this.order}) : super(key: key);
  final Order order;
  @override
  Widget build(BuildContext context) {
    final smallTextStyle = Theme.of(context).textTheme.titleSmall;
    final lightWhite = Get.isDarkMode ? Colors.white54 : Colors.black54;
    final tr = AppLocalizations.of(context)!;

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
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('#${order.displayId!}', style: Theme.of(context).textTheme.titleLarge),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.copy, size: 14))
                    ],
                  ),
                  if ( order.cart?.completedAt != null)
                    Text(
                      'on ${formatDate(order.cart!.completedAt)} at ${formatTime(order.cart!.completedAt)}',
                      style: Theme.of(context).textTheme.titleMedium,
                    )
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(tr.orderStatus, style: smallTextStyle!.copyWith(color: lightWhite)),
                  const SizedBox(height: 6.0),
                  OrderStatusLabel(orderStatus: order.status),
                ],
              ),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(order.email!, style: Theme.of(context).textTheme.titleMedium),
                    if (order.billingAddress != null && order.billingAddress!.phone != null)
                      Text(order.billingAddress!.phone.toString(), style: Theme.of(context).textTheme.titleMedium),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(tr.payment, style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.grey)),
                  if (order.payments?.isNotEmpty ?? false)
                    Text(order.payments!.first.providerId?.capitalize ?? '',
                        style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
