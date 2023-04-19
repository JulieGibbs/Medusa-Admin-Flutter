import 'dart:io';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_popup/info_popup.dart';
import 'package:medusa_admin/app/data/models/store/index.dart';
import 'package:medusa_admin/app/modules/components/adaptive_back_button.dart';
import 'package:medusa_admin/app/modules/components/adaptive_button.dart';
import 'package:medusa_admin/app/modules/components/adaptive_icon.dart';
import 'package:medusa_admin/app/routes/app_pages.dart';
import '../../../../../../../core/utils/colors.dart';
import '../../add_update_shipping_option/controllers/add_update_shipping_option_controller.dart';
import '../components/index.dart';
import '../controllers/region_details_controller.dart';

class RegionDetailsView extends GetView<RegionDetailsController> {
  const RegionDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lightWhite = Get.isDarkMode ? Colors.white54 : Colors.black54;
    final smallTextStyle = Theme.of(context).textTheme.titleSmall;
    final mediumTextStyle = Theme.of(context).textTheme.titleMedium;
    final largeTextStyle = Theme.of(context).textTheme.titleLarge;
    const space = SizedBox(height: 12.0);
    const halfSpace = SizedBox(height: 6.0);
    String getCountriesText(Region region) {
      if (region.countries == null || region.countries!.isEmpty) {
        return 'No countries configured';
      }
      if (region.countries!.length > 4) {
        String result = '';
        region.countries!.take(4).forEach((element) {
          if (result.isEmpty) {
            result = element.name ?? '';
          } else {
            result = '$result, ${element.name ?? ''}';
          }
        });
        result = '$result +${region.countries!.length - 4}';
        return result;
      } else {
        String result = '';
        for (var element in region.countries!) {
          if (result.isEmpty) {
            result = element.name ?? '';
          } else {
            result = '$result, ${element.name ?? ''}';
          }
        }
        return result;
      }
    }

    String getAllCountriesText(Region region) {
      if (region.countries == null || region.countries!.isEmpty) {
        return 'No countries configured';
      }

      String result = '';
      for (var element in region.countries!) {
        if (result.isEmpty) {
          result = element.name ?? '';
        } else {
          result = '$result, ${element.name ?? ''}';
        }
      }
      return result;
    }

    String getPaymentProviders(Region region) {
      String paymentProviders = '';
      if (region.paymentProviders != null) {
        for (PaymentProvider payment in region.paymentProviders!) {
          if (paymentProviders.isNotEmpty) {
            paymentProviders = '$paymentProviders, ${payment.id!}';
          } else {
            paymentProviders = payment.id!;
          }
        }
      }
      return paymentProviders.capitalize ?? paymentProviders;
    }

    String getFulfilmentProviders(Region region) {
      String fulfilmentProviders = '';
      if (region.fulfillmentProviders != null) {
        for (FulfillmentProvider fulfillment in region.fulfillmentProviders!) {
          if (fulfilmentProviders.isNotEmpty) {
            fulfilmentProviders = '$fulfilmentProviders, ${fulfillment.id!}';
          } else {
            fulfilmentProviders = fulfillment.id!;
          }
        }
      }
      return fulfilmentProviders.capitalize ?? fulfilmentProviders;
    }

    return Scaffold(
      appBar: AppBar(
        leading: const AdaptiveBackButton(),
        title: Obx(() {
          return Text(controller.regionName.value);
        }),
        actions: [
          AdaptiveIcon(
              icon: const Icon(Icons.more_horiz_outlined),
              onPressed: () async {
                await showModalActionSheet<int>(
                    title: 'Manage ${controller.regionName.value} region',
                    context: context,
                    actions: <SheetAction<int>>[
                      const SheetAction(label: 'Edit', key: 0),
                      const SheetAction(label: 'Delete', isDestructiveAction: true, key: 1),
                    ]).then((result) async {
                  switch (result) {
                    case 0:
                      if (controller.state == null) {
                        return;
                      }
                      Get.toNamed(Routes.ADD_REGION, arguments: controller.state!);
                      break;
                    case 1:
                      if (controller.state == null) {
                        return;
                      }
                      await showTextAnswerDialog(
                        keyword: controller.state!.name!,
                        hintText: controller.state!.name!,
                        context: context,
                        title: 'Delete region?',
                        message:
                            'Are you sure you want to delete this region?\n Type the name "${controller.state!.name!}" to confirm ',
                        okLabel: 'Yes, confirm',
                        retryTitle: 'Wrong name',
                        retryMessage:
                            'Make sure to type the region name "${controller.state!.name!}" to confirm deletion',
                        isDestructiveAction: true,
                      ).then((value) async {
                        if (value) {
                          await controller.deleteRegion();
                        }
                      });
                      break;
                  }
                });
              })
        ],
      ),
      body: SafeArea(
          child: controller.obx(
        (region) => ListView(
          children: [
            const SizedBox(height: 6.0),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(16.0)), color: Theme.of(context).cardColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Details', style: Theme.of(context).textTheme.bodyLarge),
                  halfSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Currency', style: mediumTextStyle!.copyWith(color: lightWhite)),
                      Text(region?.currencyCode?.toUpperCase() ?? '-', style: mediumTextStyle),
                    ],
                  ),
                  halfSpace,
                  InfoPopupWidget(
                    arrowTheme: InfoPopupArrowTheme(
                      arrowDirection: ArrowDirection.up,
                      color: ColorManager.primary,
                    ),
                    contentTheme: InfoPopupContentTheme(
                      infoContainerBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      infoTextStyle: smallTextStyle!,
                      contentPadding: const EdgeInsets.all(8),
                      contentBorderRadius: const BorderRadius.all(Radius.circular(4)),
                      infoTextAlign: TextAlign.start,
                    ),
                    contentTitle: getAllCountriesText(region!),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(child: Text('Countries', style: mediumTextStyle.copyWith(color: lightWhite))),
                        Expanded(
                          flex: 2,
                            child: Text(getCountriesText(region), style: mediumTextStyle, textAlign: TextAlign.right)),
                      ],
                    ),
                  ),
                  halfSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Payment providers', style: mediumTextStyle.copyWith(color: lightWhite)),
                      Text(getPaymentProviders(region), style: mediumTextStyle),
                    ],
                  ),
                  halfSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Fulfillment providers', style: mediumTextStyle.copyWith(color: lightWhite)),
                      Text(getFulfilmentProviders(region), style: mediumTextStyle),
                    ],
                  ),
                  halfSpace,
                ],
              ),
            ),
            GetBuilder<RegionDetailsController>(
              builder: (controller) {
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                          color: Theme.of(context).cardColor),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Shipping Options', style: Theme.of(context).textTheme.bodyLarge),
                          halfSpace,
                          Text('Enter specifics about available regional shipment methods.',
                              style: mediumTextStyle.copyWith(color: lightWhite)),
                          space,
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: controller.shippingOptions == null
                                ? const Center(child: CircularProgressIndicator.adaptive())
                                : ListView.separated(
                                    separatorBuilder: (_, __) => const SizedBox(height: 6.0),
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: controller.shippingOptions!.length,
                                    itemBuilder: (context, index) => ShippingOptionCard(
                                      shippingOption: controller.shippingOptions![index],
                                      onDeleteTap: () async =>
                                          await controller.deleteShippingOption(controller.shippingOptions![index].id!),
                                      onEditTap: () => Get.toNamed(
                                        Routes.ADD_UPDATE_SHIPPING_OPTION,
                                        arguments: AddUpdateShippingOptionReq(
                                          region: region,
                                          shippingOption: controller.shippingOptions![index],
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                          Center(
                            child: AdaptiveButton(
                              onPressed: () => Get.toNamed(Routes.ADD_UPDATE_SHIPPING_OPTION,
                                  arguments: AddUpdateShippingOptionReq(
                                    region: region,
                                  )),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Platform.isIOS ? const Icon(CupertinoIcons.add) : const Icon(Icons.add),
                                  const Text('Add Option'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                          color: Theme.of(context).cardColor),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Return Shipping Options', style: Theme.of(context).textTheme.bodyLarge),
                          halfSpace,
                          Text('Enter specifics about available regional shipment methods.',
                              style: mediumTextStyle.copyWith(color: lightWhite)),
                          space,
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: controller.returnShippingOptions == null
                                ? const Center(child: CircularProgressIndicator.adaptive())
                                : ListView.separated(
                                    separatorBuilder: (_, __) => const SizedBox(height: 6.0),
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: controller.returnShippingOptions!.length,
                                    itemBuilder: (context, index) => ShippingOptionCard(
                                      shippingOption: controller.returnShippingOptions![index],
                                      onDeleteTap: () async => await controller.deleteShippingOption(
                                          controller.returnShippingOptions![index].id!,
                                          returnShippingOption: true),
                                      onEditTap: () => Get.toNamed(
                                        Routes.ADD_UPDATE_SHIPPING_OPTION,
                                        arguments: AddUpdateShippingOptionReq(
                                          region: region,
                                          shippingOption: controller.returnShippingOptions![index],
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                          Center(
                            child: AdaptiveButton(
                              onPressed: () => Get.toNamed(Routes.ADD_UPDATE_SHIPPING_OPTION,
                                  arguments: AddUpdateShippingOptionReq(
                                    region: region,
                                    returnShippingOption: true,
                                  )),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Platform.isIOS ? const Icon(CupertinoIcons.add) : const Icon(Icons.add),
                                  const Text('Add Option'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: MediaQuery.of(context).padding.bottom)
          ],
        ),
        onLoading: const Center(child: CircularProgressIndicator.adaptive()),
        onError: (e) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(e ?? 'Error loading users', style: largeTextStyle),
              AdaptiveButton(onPressed: () async => controller.loadRegion(), child: const Text('Retry'))
            ],
          ),
        ),
      )),
    );
  }
}
