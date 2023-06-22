import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:medusa_admin/app/data/models/store/return_reason.dart';
import 'package:medusa_admin/app/modules/settings_module/store_settings/return_reasons_module/return_reasons/controllers/return_reasons_controller.dart';

import '../../../../../../routes/app_pages.dart';
import '../../../../../components/adaptive_icon.dart';

class ReturnReasonCard extends GetView<ReturnReasonsController> {
  const ReturnReasonCard(this.returnReason, {super.key, this.onPressed, this.listTiltStyle = false});

  final ReturnReason returnReason;
  final void Function()? onPressed;
  final bool listTiltStyle;

  @override
  Widget build(BuildContext context) {
    Color lightWhite = Get.isDarkMode ? Colors.white54 : Colors.black54;
    final mediumTextStyle = Theme.of(context).textTheme.titleMedium;
    final largeTextStyle = Theme.of(context).textTheme.titleLarge;

    if (listTiltStyle) {
      return Slidable(
        groupTag: const Key('return_reason'),
        key: ValueKey(returnReason.id!),
        endActionPane: ActionPane(
          extentRatio: 0.25,
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (_) async {
                await showOkCancelAlertDialog(
                  context: context,
                  title: 'Delete Return Reason',
                  message: 'Are you sure you want to delete this return reason?',
                  isDestructiveAction: true,
                  okLabel: 'Yes, Delete',
                ).then((value) async {
                  if (value == OkCancelResult.ok) {
                    await controller.deleteReturnReason(returnReason.id!);
                  }
                });
              },
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              icon: Icons.delete_forever,
              // label: 'Delete',
            ),
          ],
        ),
        child: ListTile(
          onTap: onPressed ??
              () => Get.toNamed(Routes.CREATE_UPDATE_RETURN_REASON, arguments: returnReason)?.then((value) {
                    if (value != null && value == true) {
                      controller.pagingController.refresh();
                    }
                  }),
          title: Text(
            returnReason.label!,
            style: largeTextStyle,
          ),
          subtitle: returnReason.description != null
              ? Text(returnReason.description!, style: mediumTextStyle!.copyWith(color: lightWhite))
              : null,
        ),
      );
    }

    return GestureDetector(
      onTap: onPressed ??
          () => Get.toNamed(Routes.CREATE_UPDATE_RETURN_REASON, arguments: returnReason)?.then((value) {
                if (value != null && value == true) {
                  controller.pagingController.refresh();
                }
              }),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
        decoration: BoxDecoration(
            color: Theme.of(context).appBarTheme.backgroundColor,
            borderRadius: const BorderRadius.all(Radius.circular(12))),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    returnReason.label!,
                    style: largeTextStyle,
                  ),
                  if (returnReason.description != null)
                    Text(returnReason.description!, style: mediumTextStyle!.copyWith(color: lightWhite))
                ],
              ),
            ),
            AdaptiveIcon(
              onPressed: () async {
                await showOkCancelAlertDialog(
                  context: context,
                  title: 'Delete Return Reason',
                  message: 'Are you sure you want to delete this return reason?',
                  isDestructiveAction: true,
                  okLabel: 'Yes, Delete',
                ).then((value) async {
                  if (value == OkCancelResult.ok) {
                    await controller.deleteReturnReason(returnReason.id!);
                  }
                });
              },
              icon: const Icon(Icons.delete_forever, color: Colors.redAccent),
            ),
          ],
        ),
      ),
    );
  }
}
