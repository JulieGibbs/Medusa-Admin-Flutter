import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medusa_admin/app/modules/components/adaptive_button.dart';
import 'package:medusa_admin/app/modules/components/adaptive_close_button.dart';
import 'package:medusa_admin/app/modules/components/search_text_field.dart';
import '../controller/country_controller.dart';

class SelectCountryView extends StatelessWidget {
  const SelectCountryView({Key? key, this.selectCountryReq}) : super(key: key);
  final SelectCountryReq? selectCountryReq;
  @override
  Widget build(BuildContext context) {
    final mediumTextStyle = Theme.of(context).textTheme.titleMedium;
    return GetBuilder<SelectCountryController>(
      init: SelectCountryController(selectCountryReq: selectCountryReq),
      builder: (controller) {
        // var selectedCountries = controller.selectedCountries;
        var disabledCountriesIso = controller.selectCountryOptions.disabledCountriesIso2;
        final multipleSelect = controller.selectCountryOptions.multipleSelect;
        return Scaffold(
          appBar: AppBar(
            leading: const AdaptiveCloseButton(),
            title: multipleSelect
                ? Text(
                    'Select Countries ${controller.selectedCountries.isNotEmpty ? '(${controller.selectedCountries.length})' : ''}')
                : const Text('Select Country'),
            actions: [
              AdaptiveButton(
                  onPressed: controller.selectedCountries.isEmpty
                      ? null
                      : () => Get.back(result: controller.selectedCountries),
                  child: const Text('Save'))
            ],
            bottom: PreferredSize(
                preferredSize: controller.selectCountryOptions.disabledCountriesIso2.isNotEmpty
                    ? const Size.fromHeight(kToolbarHeight * 2)
                    : const Size.fromHeight(kToolbarHeight),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      height: kToolbarHeight,
                      child: Row(
                        children: [
                          Expanded(
                              child: SearchTextField(
                            hintText: 'Search for country name, code, iso2, and iso3',
                            focusNode: controller.searchFocusNode,
                            controller: controller.searchCtrl,
                          )),
                          AnimatedCrossFade(
                              firstChild: AdaptiveButton(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  onPressed: () {
                                    controller.searchFocusNode.unfocus();
                                    controller.searchCtrl.clear();
                                    controller.update();
                                  },
                                  child: const Text('Cancel')),
                              secondChild: const SizedBox(),
                              crossFadeState: controller.searchFocusNode.hasFocus
                                  ? CrossFadeState.showFirst
                                  : CrossFadeState.showSecond,
                              duration: const Duration(milliseconds: 200))
                        ],
                      ),
                    ),
                    if (controller.selectCountryOptions.disabledCountriesIso2.isNotEmpty)
                      Container(
                        height: kToolbarHeight,
                        color: Theme.of(context).appBarTheme.backgroundColor,
                        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.warning_rounded, color: Colors.amber),
                            const SizedBox(width: 6.0),
                            Flexible(
                                child: Text(
                              'Greyed out countries are selected in other regions',
                              style: mediumTextStyle,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )),
                          ],
                        ),
                      ),
                  ],
                )),
          ),
          body: SafeArea(
            bottom: false,
            child: ListView.separated(
              separatorBuilder: (_, __) => const Divider(height: 0, indent: 16.0),
              itemCount: controller.countriesList.length,
              itemBuilder: (context, index) {
                final country = controller.countriesList[index];
                return CheckboxListTile(
                  value: controller.selectedCountries.map((e) => e.name!).toList().contains(country.name),
                  enabled: !disabledCountriesIso.contains(country.iso2),
                  onChanged: (val) {
                    if (multipleSelect) {
                      if (val != null && val) {
                        controller.selectedCountries.add(country);
                      } else if (val != null && !val) {
                        controller.selectedCountries.remove(country);
                      }
                    } else {
                      if (val != null && val) {
                        controller.selectedCountries = [country];
                      } else if (val != null && !val) {
                        controller.selectedCountries.remove(country);
                      }
                    }
                    controller.update();
                  },
                  title: Text(country.displayName!),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
