import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:medusa_admin/app/data/models/store/customer.dart';
import 'package:medusa_admin/app/modules/components/date_time_card.dart';

import '../../../../../core/utils/colors.dart';
import '../../../../../core/utils/medusa_icons_icons.dart';
import '../../../../routes/app_pages.dart';

class CustomerListTile extends StatelessWidget {
  const CustomerListTile(this.customer, {Key? key, required this.index, this.onEditTap, this.onDeleteTap})
      : super(key: key);
  final Customer customer;
  final int index;
  final void Function(BuildContext)? onEditTap;
  final void Function(BuildContext)? onDeleteTap;
  @override
  Widget build(BuildContext context) {
    final smallTextStyle = Theme.of(context).textTheme.titleSmall;
    final mediumTextStyle = Theme.of(context).textTheme.titleMedium;
    final largeTextStyle = Theme.of(context).textTheme.titleLarge;
    return Slidable(
      groupTag: const Key('customers'),
      key: ValueKey(customer.id!),
      endActionPane: ActionPane(
        extentRatio: 0.4,
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: onEditTap,
            backgroundColor: const Color(0xFF7BC043),
            foregroundColor: Colors.white,
            icon: MedusaIcons.pencil_square_solid,
          ),
          SlidableAction(
            onPressed: onDeleteTap,
            backgroundColor: Colors.redAccent,
            foregroundColor: Colors.white,
            icon: Icons.delete_forever,
          ),
        ],
      ),
      child: ListTile(
        horizontalTitleGap: 8,
        tileColor: index.isOdd ? Theme.of(context).appBarTheme.backgroundColor : null,
        leading: CircleAvatar(
          backgroundColor: ColorManager.getAvatarColor(customer.email),
          maxRadius: 18,
          child: Text(
              customer.firstName == null ? customer.email[0].capitalize ?? customer.email[0] : customer.firstName![0],
              style: largeTextStyle!.copyWith(color: Colors.white)),
        ),
        title: customer.firstName != null
            ? Text('${customer.firstName ?? ''} ${customer.lastName ?? ''}', style: mediumTextStyle)
            : Text(customer.email, style: mediumTextStyle),
        subtitle: customer.firstName != null ? Text(customer.email, style: mediumTextStyle) : null,
        trailing: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (customer.createdAt != null)
              Text(
                formatDate(customer.createdAt),
                style: smallTextStyle,
              ),
            if (customer.orders != null) Text('Orders: ${customer.orders!.length}', style: smallTextStyle),
          ],
        ),
        onTap: () => Get.toNamed(Routes.CUSTOMER_DETAILS, arguments: customer.id!),
      ),
    );
  }
}
