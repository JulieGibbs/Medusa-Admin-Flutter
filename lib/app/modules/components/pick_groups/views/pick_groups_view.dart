import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:medusa_admin/app/data/models/store/customer_group.dart';
import 'package:medusa_admin/app/data/repository/customer_group/customer_group_repo.dart';
import 'package:medusa_admin/app/modules/components/adaptive_button.dart';

import '../controllers/pick_groups_controller.dart';

class PickGroupsView extends StatelessWidget {
  const PickGroupsView({Key? key, this.pickGroupsReq}) : super(key: key);
  final PickGroupsReq? pickGroupsReq;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PickGroupsController>(
      init: PickGroupsController(groupRepo: CustomerGroupRepo(), pickGroupsReq: pickGroupsReq),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: controller.groupsReq.multipleSelect
                ? const Text('Pick Customer Groups')
                : const Text('Pick Customer Group'),
            actions: [
              AdaptiveButton(
                  onPressed: () {
                    Get.back(result: controller.selectedGroups);
                  },
                  child: const Text('Save'))
            ],
          ),
          body: SafeArea(
            child: PagedListView.separated(
              separatorBuilder: (_, __) => const Divider(height: 0, indent: 16),
              pagingController: controller.pagingController,
              builderDelegate: PagedChildBuilderDelegate<CustomerGroup>(
                itemBuilder: (context, group, index) => CheckboxListTile(
                  title: Text(group.name ?? ''),
                  value: controller.selectedGroups.map((e) => e.id).toList().contains(group.id),
                  onChanged: (val) {
                    if (!controller.groupsReq.multipleSelect) {
                      controller.selectedGroups = [group];
                      controller.update();
                      return;
                    }
                    if (val != null && val) {
                      controller.selectedGroups.add(group);
                    } else {
                      controller.selectedGroups.removeWhere((element) => element.id == group.id);
                    }
                    controller.update();
                  },
                ),
                firstPageProgressIndicatorBuilder: (context) =>
                    const Center(child: CircularProgressIndicator.adaptive()),
              ),
            ),
          ),
        );
      },
    );
  }
}
