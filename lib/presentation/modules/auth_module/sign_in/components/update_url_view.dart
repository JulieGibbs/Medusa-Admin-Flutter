import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:medusa_admin/core/constant/colors.dart';
import 'package:medusa_admin/core/constant/strings.dart';
import 'package:medusa_admin/core/di/di.dart';
import 'package:medusa_admin/core/di/medusa_admin_di.dart';
import 'package:medusa_admin/data/service/auth_preference_service.dart';
import 'package:medusa_admin/core/extension/text_style_extension.dart';
import 'package:medusa_admin/core/extension/snack_bar_extension.dart';
import 'package:medusa_admin_flutter/medusa_admin.dart';
import 'package:medusa_admin/core/extension/context_extension.dart';

class UrlUpdateView extends StatefulWidget {
  const UrlUpdateView({super.key});

  @override
  State<UrlUpdateView> createState() => _UrlUpdateViewState();
}

class _UrlUpdateViewState extends State<UrlUpdateView> {
  final formKey = GlobalKey<FormState>();
  final tokenFormKey = GlobalKey<FormState>();
  final textCtrl = TextEditingController();
  final tokenTextCtrl = TextEditingController();
  late bool setupUrl;
  bool advancedOption = false;
  late AuthenticationType authType;
  @override
  void initState() {
    _loadInit();
    super.initState();
  }

  @override
  void dispose() {
    textCtrl.dispose();
    tokenTextCtrl.dispose();
    super.dispose();
  }

  void _loadInit() async {
    authType = AuthPreferenceService.authType;
    if (authType != AuthenticationType.jwt) {
      advancedOption = true;
    }

    if (AuthPreferenceService.baseUrl == null) {
      setupUrl = true;
    } else {
      setupUrl = false;
    }
    if (authType != AuthenticationType.token) {
      tokenTextCtrl.text = await getIt<FlutterSecureStorage>()
              .read(key: AppConstants.tokenKey) ??
          '';
    }
  }

  Future<void> _handleMedusaSingleton() async {
    if (setupUrl) {
      await MedusaAdminDi.registerMedusaAdminSingleton();
    } else {
      await MedusaAdminDi.resetMedusaAdminSingleton();
    }
  }

  Future<void> _save({bool skipValidation = false}) async {
    if (!formKey.currentState!.validate() && !skipValidation) {
      return;
    }
    if (!await _advancedOptionSettings()) {
      return;
    }

    //  in case theres '/' in the end remove it
    final url = textCtrl.text.endsWith('/')
        ? textCtrl.text.substring(0, textCtrl.text.length - 1)
        : textCtrl.text;

    await AuthPreferenceService.instance.updateUrl(url).then(
      (result) async {
        if (result) {
          await AuthPreferenceService.instance.clearLoginData();
          await AuthPreferenceService.instance.clearEmail();
          await _handleMedusaSingleton().then((_) {
            context.popRoute(true);
            context.showSnackBar(setupUrl ? 'URL set' : 'URL updated');
          });
        } else {
          context.popRoute(false);
          context.showSnackBar(setupUrl
              ? 'Could not set URL, try again'
              : 'Could not update URL, try again');
        }
      },
    );
  }

  Future<bool> _advancedOptionSettings() async {
    if (!advancedOption) return true;

    if (authType == AuthenticationType.token) {
      if (!tokenFormKey.currentState!.validate()) {
        return false;
      }
      await getIt<FlutterSecureStorage>()
          .write(key: AppConstants.tokenKey, value: tokenTextCtrl.text);
    }
    try {
      await AuthPreferenceService.instance.updateAuthPreference(
          AuthPreferenceService.authPreference.copyWith(authType: authType));
      switch (authType) {
        case AuthenticationType.cookie:
          await getIt<FlutterSecureStorage>()
              .delete(key: AppConstants.tokenKey);
          await getIt<FlutterSecureStorage>().delete(key: AppConstants.jwtKey);
          break;
        case AuthenticationType.token:
          await getIt<FlutterSecureStorage>().delete(key: AppConstants.jwtKey);
          await getIt<FlutterSecureStorage>()
              .delete(key: AppConstants.cookieKey);
          break;

        case AuthenticationType.jwt:
          await getIt<FlutterSecureStorage>()
              .delete(key: AppConstants.tokenKey);
          await getIt<FlutterSecureStorage>()
              .delete(key: AppConstants.cookieKey);
          break;
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final smallTextStyle = context.bodySmall;
    final baseUrl = AuthPreferenceService.baseUrl;
    String infoText = switch (authType) {
      AuthenticationType.cookie =>
        'Use a cookie session to send authenticated requests.',
      AuthenticationType.token =>
        'Use a user\'s API Token to send authenticated requests.',
      AuthenticationType.jwt =>
        'Use a JWT token to send authenticated requests. (Default)',
    };
    return GestureDetector(
      onTap: () => context.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: setupUrl ? const Text('Set URL') : const Text('Update URL'),
          actions: [
            TextButton(
                onPressed: () async => await _save(),
                onLongPress: () async => await _save(skipValidation: true),
                child: const Text('Save'))
          ],
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(
              12.0, 8.0, 12.0, context.bottomViewInsetPadding + 8.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              if (!setupUrl)
                InkWell(
                  onTap: () async {
                    textCtrl.text = baseUrl ?? '';
                  },
                  child: Text('Current URL : $baseUrl', style: smallTextStyle),
                ),
              const SizedBox(height: 20),
              Form(
                key: formKey,
                child: TextFormField(
                  controller: textCtrl,
                  style: smallTextStyle,
                  decoration:
                      const InputDecoration(hintText: 'https://medusajs.com'),
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Field is required';
                    }

                    if (!val.isURL) {
                      return 'Invalid url';
                    }

                    if (val.endsWith('/store')) {
                      return 'Please remove /store from the end of the url';
                    }
                    return null;
                  },
                ),
              ),
              if (!advancedOption)
                Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      onPressed: () =>
                          setState(() => advancedOption = !advancedOption),
                      label: const Text('Advanced Options'),
                      icon: const Icon(Icons.add_link),
                    )),
              const Gap(12.0),
              if (advancedOption)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(),
                    Text('Authentication Method', style: context.bodyMedium),
                    const Gap(12.0),
                    SizedBox(
                      width: double.maxFinite,
                      child: SegmentedButton<AuthenticationType>(
                          showSelectedIcon: false,
                          onSelectionChanged: (value) =>
                              setState(() => authType = value.first),
                          segments: AuthenticationType.values
                              .map((e) => ButtonSegment<AuthenticationType>(
                                  value: e, label: Text(e.toString())))
                              .toList()
                              .reversed
                              .toList(),
                          selected: {authType}),
                    ),
                    const Gap(12.0),
                    Container(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          const Icon(Icons.info_outline,
                              color: ColorManager.manatee),
                          const Gap(12.0),
                          Flexible(
                              child: Text(
                            infoText,
                            style: context.bodySmall
                                ?.copyWith(color: ColorManager.manatee),
                          )),
                        ],
                      ),
                    ),
                    const Gap(12.0),
                    if (authType == AuthenticationType.token)
                      Form(
                        key: tokenFormKey,
                        child: TextFormField(
                          controller: tokenTextCtrl,
                          style: smallTextStyle,
                          decoration:
                              const InputDecoration(hintText: 'Api token'),
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'Field is required';
                            }
                            return null;
                          },
                        ),
                      ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
