import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:medusa_admin/app/data/repository/auth/auth_repo.dart';
import 'package:medusa_admin/app/routes/app_pages.dart';

import '../../../../data/models/req/user_post_auth_req.dart';
import '../../../../data/repository/store/store_repo.dart';
import '../../../../data/service/storage_service.dart';
import '../../../../data/service/store_service.dart';
import '../../../components/easy_loading.dart';

class SignInController extends GetxController {
  SignInController({required this.authRepository});
  AuthRepo authRepository;
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  RxString errorMessage = ''.obs;
  Rx<ThemeMode> themeMode = ThemeMode.system.obs;
  RxBool animate = false.obs;
  final formKey = GlobalKey<FormState>();
  @override
  void onInit() {
    emailCtrl.text = 'admin@medusa-test.com';
    passwordCtrl.text = 'supersecret';
    themeMode.value = StorageService.instance.loadThemeMode();
    super.onInit();
  }

  @override
  void onClose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.onClose();
  }

  Future<void> changeThemeMode() async {
    switch (themeMode.value) {
      case ThemeMode.system:
        await StorageService.instance.saveThemeMode(ThemeMode.light);
        break;
      case ThemeMode.light:
        await StorageService.instance.saveThemeMode(ThemeMode.dark);
        break;
      case ThemeMode.dark:
        await StorageService.instance.saveThemeMode(ThemeMode.system);
        break;
    }
    themeMode.value = StorageService.instance.loadThemeMode();
    update();
  }

  Future<void> signIn(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    // To hide the keyboard
    FocusScope.of(context).unfocus();
    loading();
    final result =
        await authRepository.signIn(req: UserPostAuthReq(email: emailCtrl.text, password: passwordCtrl.text));

    result.when((success) async {
      await Get.putAsync(() => StoreService(storeRepo: StoreRepo()).init());
      Get.offAllNamed(Routes.DASHBOARD);
      dismissLoading();
    }, (error) {
      if (error.code == 401) {
        errorMessage.value = 'Email or password is incorrect';
      } else {
        errorMessage.value = error.message;
      }
      dismissLoading();
    });
  }
}
