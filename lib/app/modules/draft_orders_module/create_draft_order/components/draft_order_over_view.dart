import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medusa_admin/app/data/models/store/index.dart';
import 'package:medusa_admin/app/modules/components/adaptive_button.dart';
import 'package:medusa_admin/app/modules/components/custom_expansion_tile.dart';
import '../../../../../core/utils/colors.dart';
import '../../../components/currency_formatter.dart';
import '../controllers/create_draft_order_controller.dart';

class DraftOrderOverView extends StatelessWidget {
  const DraftOrderOverView(this.controller, {super.key});
  final CreateDraftOrderController controller;
  @override
  Widget build(BuildContext context) {
    final smallTextStyle = Theme.of(context).textTheme.titleSmall;
    final lightWhite = Get.isDarkMode ? Colors.white54 : Colors.black54;
    const space = SizedBox(height: 12.0);
    const halfSpace = SizedBox(height: 6.0);
    final lineItems = controller.lineItems + controller.customLineItems;
    final largeTextStyle = Theme.of(context).textTheme.titleLarge;
    final customer = controller.selectedCustomer ??
        Customer(
            email: 'Placeholder',
            firstName: 'Placeholder',
            lastName: 'Placeholder');
    final shippingAddress = controller.shippingAddress;
    final billingAddress = controller.sameAddress
        ? controller.shippingAddress
        : controller.billingAddress;
    final shippingOption = controller.selectedShippingOption;

    String getPrice(num? price) {
      final currencyFormatter = CurrencyTextInputFormatter(
          name: shippingOption?.region?.currencyCode);
      return '${shippingOption?.region?.currencyCode?.toUpperCase() ?? ''} ${currencyFormatter.format(price.toString())}';
    }

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        children: [
          CustomExpansionTile(
            label: 'Items',
            initiallyExpanded: true,
            children: [
              ListView.separated(
                separatorBuilder: (_, __) => const SizedBox(height: 12.0),
                shrinkWrap: true,
                padding: const EdgeInsets.only(bottom: 12.0),
                itemCount: lineItems.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => OverViewListTile(
                    lineItems[index],
                    currencyCode:
                        controller.selectedRegion?.currencyCode ?? ''),
              ),
              AdaptiveButton(
                  onPressed: () {},
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add),
                      Text('Add discount'),
                    ],
                  ))
            ],
          ),
          space,
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              color: context.theme.appBarTheme.backgroundColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Customer'),
                space,
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: ColorManager.getAvatarColor(customer.email),
                      maxRadius: 18,
                      child: Text(
                          customer.firstName == null
                              ? customer.email[0].capitalize ??
                                  customer.email[0]
                              : customer.firstName![0],
                          style: largeTextStyle!.copyWith(color: Colors.white)),
                    ),
                    const SizedBox(width: 12.0),
                    if(customer.firstName != null)
                    Flexible(
                        child: Text(
                            '${customer.firstName ?? ''} ${customer.lastName ?? ''} (${customer.email})',
                            style: smallTextStyle)),
                    if(customer.firstName == null)
                    Flexible(
                        child: Text(
                            customer.email,
                            style: smallTextStyle)),
                  ],
                ),
                halfSpace,
              ],
            ),
          ),
          space,
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              color: context.theme.appBarTheme.backgroundColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Shipping details'),
                space,
                // Address info
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Address',
                        style: smallTextStyle?.copyWith(color: lightWhite)),
                    Text(
                        '${shippingAddress.address1}${shippingAddress.address2 != null ? ',' : ''} ${shippingAddress.address2 ?? ''}',
                        style: smallTextStyle),
                    Text(
                        '${shippingAddress.postalCode} ${shippingAddress.city ?? ''}, ${shippingAddress.country?.name?.capitalize ?? ''}',
                        style: smallTextStyle),
                  ],
                ),
                space,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Shipping method',
                        style: smallTextStyle?.copyWith(color: lightWhite)),
                    Text(
                        '${shippingOption?.name ?? ''} - (${getPrice(shippingOption?.amount)})',
                        style: smallTextStyle),
                  ],
                ),

                halfSpace,
              ],
            ),
          ),
          space,
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              color: context.theme.appBarTheme.backgroundColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Billing details'),
                space,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Address',
                        style: smallTextStyle?.copyWith(color: lightWhite)),
                    Text(
                        '${billingAddress.address1}${billingAddress.address2 != null ? ',' : ''} ${billingAddress.address2 ?? ''}',
                        style: smallTextStyle),
                    Text(
                        '${billingAddress.postalCode} ${billingAddress.city ?? ''}, ${billingAddress.country?.name?.capitalize ?? ''}',
                        style: smallTextStyle),
                  ],
                ),
                halfSpace,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OverViewListTile extends StatelessWidget {
  const OverViewListTile(
    this.lineItem, {
    super.key,
    required this.currencyCode,
  });
  final LineItem lineItem;
  final String currencyCode;

  @override
  Widget build(BuildContext context) {
    final smallTextStyle = Theme.of(context).textTheme.titleSmall;
    final lightWhite = Get.isDarkMode ? Colors.white54 : Colors.black54;
    final mediumTextStyle = Theme.of(context).textTheme.titleMedium;
    final productVariant = lineItem.variant ??
        ProductVariant(title: lineItem.title, prices: [
          MoneyAmount(
            amount: lineItem.unitPrice?.toInt(),
            currencyCode: currencyCode,
          )
        ]);
    MoneyAmount? moneyAmount;
    final priceList =
        productVariant.prices?.where((e) => e.currencyCode == currencyCode);
    if (priceList?.isNotEmpty ?? false) {
      moneyAmount = priceList!.first;
    } else {
      moneyAmount = (productVariant.prices?.isNotEmpty ?? false)
          ? productVariant.prices!.first
          : MoneyAmount(amount: 0, currencyCode: 'usd');
    }
    String getPrice(num? price) {
      final currencyFormatter =
          CurrencyTextInputFormatter(name: moneyAmount?.currencyCode);
      return '${moneyAmount?.currencyCode?.toUpperCase() ?? ''} ${currencyFormatter.format(price.toString())}';
    }

    const space = SizedBox(width: 12.0);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Row(
            children: [
              //Image
              if (productVariant.product?.thumbnail != null)
                SizedBox(
                    width: 45,
                    child: CachedNetworkImage(
                      key: ValueKey(productVariant.product!.thumbnail!),
                      imageUrl: productVariant.product!.thumbnail!,
                      placeholder: (context, text) => const Center(
                          child: CircularProgressIndicator.adaptive()),
                      errorWidget: (context, string, error) => const Icon(
                          Icons.warning_rounded,
                          color: Colors.redAccent),
                    )),
              space,
              // Product, Variant name and price
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (productVariant.product?.title != null)
                      Text(
                        productVariant.product?.title ?? '',
                        style: mediumTextStyle,
                      ),
                    if (productVariant.title != null)
                      Text(productVariant.title ?? '',
                          style: smallTextStyle?.copyWith(color: lightWhite),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Variant quantity
        IntrinsicWidth(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('${getPrice(moneyAmount.amount)} x ${lineItem.quantity!}',
                  style: smallTextStyle, maxLines: 1),
              const Divider(height: 5),
              Text(getPrice(lineItem.quantity! * moneyAmount.amount!),
                  style: mediumTextStyle, maxLines: 1),
            ],
          ),
        ),
      ],
    );
  }
}
