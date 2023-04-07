import 'package:flutter/material.dart';

import '../../../../../../core/utils/colors.dart';

class InviteStatusLabel extends StatelessWidget {
  const InviteStatusLabel({Key? key, required this.accepted}) : super(key: key);
  final bool? accepted;
  @override
  Widget build(BuildContext context) {
    var containerColor = ColorManager.primary.withOpacity(0.17);
    var textColor = ColorManager.primary;
    String text = 'Admin';

    if(accepted == null || accepted! == false){
      containerColor = Colors.orange.withOpacity(0.17);
      textColor = Colors.orange;
      text = 'Pending';
    } else {
      containerColor = ColorManager.primary.withOpacity(0.17);
      textColor = ColorManager.primary;
      text = 'Accepted';
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
