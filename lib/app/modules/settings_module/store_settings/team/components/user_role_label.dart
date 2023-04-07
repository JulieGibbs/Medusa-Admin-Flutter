import 'package:flutter/material.dart';
import 'package:medusa_admin/core/utils/colors.dart';
import 'package:medusa_admin/core/utils/enums.dart';

class UserRoleLabel extends StatelessWidget {
  const UserRoleLabel({Key? key, required this.userRole}) : super(key: key);
  final UserRole userRole;
  @override
  Widget build(BuildContext context) {
    var containerColor = ColorManager.primary.withOpacity(0.17);
    var textColor = ColorManager.primary;
    String text = 'Admin';
    switch (userRole) {
      case UserRole.admin:
        containerColor = Colors.redAccent.withOpacity(0.17);
        textColor = Colors.redAccent;
        text = 'Admin';
        break;
      case UserRole.developer:
        containerColor = Colors.orange.withOpacity(0.17);
        textColor = Colors.orange;
        text = 'Developer';
        break;
      case UserRole.member:
        containerColor = ColorManager.primary.withOpacity(0.17);
        textColor = ColorManager.primary;
        text = 'Member';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(color: textColor),
      ),
    );
  }
}
