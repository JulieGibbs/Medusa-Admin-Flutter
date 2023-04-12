import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:medusa_admin/app/data/models/req/user_shipping_option_req.dart';
import 'package:medusa_admin/app/data/models/store/index.dart';
import 'package:medusa_admin/app/data/repository/regions/regions_repo.dart';
import 'package:medusa_admin/app/data/repository/shipping_options/shipping_options_repo.dart';
import 'package:medusa_admin/app/data/repository/shipping_profile/shipping_profile_repo.dart';
import 'package:medusa_admin/app/modules/components/easy_loading.dart';
import 'package:medusa_admin/app/modules/settings_module/store_settings/regions_module/region_details/controllers/region_details_controller.dart';
import '../../../../../../data/models/store/fulfillment_option.dart';

class AddUpdateShippingOptionController extends GetxController {
  AddUpdateShippingOptionController(
      {required this.shippingProfileRepo, required this.regionsRepo, required this.shippingOptionsRepo});

  final ShippingProfileRepo shippingProfileRepo;
  final ShippingOptionsRepo shippingOptionsRepo;
  final RegionsRepo regionsRepo;
  List<FulfillmentOption>? fulfillmentOptions;
  List<ShippingProfile>? shippingProfiles;
  AddUpdateShippingOptionReq addUpdateShippingOptionReq = Get.arguments;
  bool get updateMode => addUpdateShippingOptionReq.shippingOption != null;
  bool visibleInStore = false;
  final titleCtrl = TextEditingController();
  ShippingOptionPriceType? selectedPriceType;
  ShippingProfile? selectedShippingProfile;
  FulfillmentOption? selectedFulfillmentOption;
  final formKey = GlobalKey<FormState>();
  @override
  Future<void> onInit() async {
    if (!updateMode) {
      await loadFulfillmentOptions();
      await loadShippingProfile();
    }
    if (updateMode) {
      loadShippingOption();
    }
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    titleCtrl.dispose();
    super.onClose();
  }

  Future<void> createShippingOption(BuildContext context) async {
    if (fulfillmentOptions == null ||
        shippingProfiles == null ||
        !formKey.currentState!.validate() ||
        selectedFulfillmentOption == null) {
      return;
    }
    if (!formKey.currentState!.validate()) {
      return;
    }
    loading();
    FocusScope.of(context).unfocus();
    final result = await shippingOptionsRepo.create(
      userCreateShippingOptionReq: UserCreateShippingOptionReq(
        shippingOption: ShippingOption(
          name: titleCtrl.text,
          regionId: addUpdateShippingOptionReq.regionId,
          profileId: '',
          providerId: selectedFulfillmentOption!.providerId,
          priceType: selectedPriceType,
        ),
      ),
    );

    result.when((success) async {
      Get.back();
      if (addUpdateShippingOptionReq.returnShippingOption) {
        await RegionDetailsController.instance.loadReturnShippingOptions();
      } else {
        await RegionDetailsController.instance.loadShippingOptions();
      }
    }, (error) {
      Get.snackbar('Error creating shipping option ${error.code ?? ''}', error.message,
          snackPosition: SnackPosition.BOTTOM);
      dismissLoading();
    });
  }

  Future<void> updateShippingOption(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    FocusScope.of(context).unfocus();
    final shippingOption = addUpdateShippingOptionReq.shippingOption!;
    final result = await shippingOptionsRepo.update(
      id: shippingOption.id!,
      userUpdateReturnReasonReq: UserUpdateShippingOptionReq(
        shippingOption: ShippingOption(
          name: shippingOption.name == titleCtrl.text ? null : titleCtrl.text,
          regionId: addUpdateShippingOptionReq.regionId,
          profileId: shippingOption.profileId,
          providerId: shippingOption.providerId,
          priceType: selectedPriceType,
        ),
      ),
    );
    result.when((success) async {
      Get.back();
      if (addUpdateShippingOptionReq.returnShippingOption) {
        await RegionDetailsController.instance.loadReturnShippingOptions();
      } else {
        await RegionDetailsController.instance.loadShippingOptions();
      }
    }, (error) {
      Get.snackbar('Error updating shipping option ${error.code ?? ''}', error.message,
          snackPosition: SnackPosition.BOTTOM);
      dismissLoading();
    });
  }

  Future<void> loadFulfillmentOptions() async {
    final result = await regionsRepo.retrieveFulfillmentOptions(id: addUpdateShippingOptionReq.regionId);
    result.when(
      (success) {
        fulfillmentOptions = success.fulfillmentOptions;
        update();
      },
      (error) {
        debugPrint(error.toString());
        EasyLoading.showError('Error loading fulfillment options');
        Get.back();
      },
    );
  }

  Future<void> loadShippingProfile() async {
    final result = await shippingProfileRepo.retrieveAll();
    result.when((success) {
      shippingProfiles = success.shippingProfiles;
      update();
    }, (error) {
      debugPrint(error.toString());
      EasyLoading.showError('Error loading shipping option');
      Get.back();
    });
  }

  void loadShippingOption() {
    final shippingOption = addUpdateShippingOptionReq.shippingOption!;
    visibleInStore = !shippingOption.adminOnly;
    titleCtrl.text = shippingOption.name ?? '';
    selectedPriceType = shippingOption.priceType;
    update();
  }
}

class AddUpdateShippingOptionReq {
  AddUpdateShippingOptionReq({
    required this.regionId,
    this.shippingOption,
    this.returnShippingOption = false,
  });
  final String regionId;
  final ShippingOption? shippingOption;
  final bool returnShippingOption;
}
