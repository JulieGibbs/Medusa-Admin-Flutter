import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:medusa_admin/core/extension/context_extension.dart';
import 'package:medusa_admin_dart_client/medusa_admin.dart';
import 'package:flex_expansion_tile/flex_expansion_tile.dart';

import '../../../../../core/constant/colors.dart';
import 'package:medusa_admin/core/extension/text_style_extension.dart';

class DraftOrderShipping extends StatelessWidget {
  const DraftOrderShipping(this.draftOrder, {super.key});
  final DraftOrder draftOrder;
  @override
  Widget build(BuildContext context) {
    const manatee = ColorManager.manatee;
    final smallTextStyle = context.bodySmall;
    final mediumTextStyle = context.bodyMedium;
    const space = Gap(12);
    const halfSpace = Gap(6);
    return FlexExpansionTile(
      title: const Text('Shipping'),
      onExpansionChanged: (expanded) async {
        if (expanded && key is GlobalKey) {
          await (key as GlobalKey).currentContext.ensureVisibility();
        }
      },
      controlAffinity: ListTileControlAffinity.leading,
      childPadding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Shipping method',
              style: smallTextStyle?.copyWith(color: manatee)),
          halfSpace,
          if (draftOrder.cart?.shippingMethods != null)
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: draftOrder.cart!.shippingMethods!.length,
              itemBuilder: (context, index) => Text(
                  draftOrder
                          .cart!.shippingMethods![index].shippingOption?.name ??
                      '',
                  style: mediumTextStyle),
            ),
          space,
        ],
      ),
    );
  }
}
