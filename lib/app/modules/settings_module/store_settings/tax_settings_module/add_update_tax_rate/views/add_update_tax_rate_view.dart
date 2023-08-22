import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:medusa_admin/app/modules/components/adaptive_close_button.dart';
import 'package:medusa_admin/app/modules/components/custom_text_field.dart';
import '../../../../../components/adaptive_button.dart';
import '../../../../../components/labeled_numeric_text_field.dart';
import '../controllers/add_update_tax_rate_controller.dart';

class AddUpdateTaxRateView extends GetView<AddUpdateTaxRateController> {
  const AddUpdateTaxRateView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          leading: const AdaptiveCloseButton(),
          title: controller.updateMode ? const Text('Update Tax Rate') : const Text('Add Tax Rate'),
          actions: [
            AdaptiveButton(
              onPressed: () async =>
                  controller.updateMode ? await controller.updateTaxRate() : await controller.create(),
              child: controller.updateMode ? const Text('Update') : const Text('Create'),
            ),
          ],
        ),
        body: SafeArea(
          child: Form(
            key: controller.formKey,
            child: ListView(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  decoration: BoxDecoration(
                      color: Theme.of(context).appBarTheme.backgroundColor,
                      borderRadius: const BorderRadius.all(Radius.circular(12.0))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Text('Details'),
                      ),
                      LabeledTextField(
                        label: 'Name',
                        controller: controller.nameCtrl,
                        required: true,
                        hintText: 'Rate name',
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Field is required';
                          }
                          return null;
                        },
                      ),
                      LabeledNumericTextField(
                        label: 'Tax Rate',
                        controller: controller.taxRateCtrl,
                        prefixText: '  %  ',
                        required: true,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Field is required';
                          }

                          if (double.tryParse(val) == null) {
                            return 'Invalid tax rate';
                          }

                          if (double.parse(val).isGreaterThan(100)) {
                            return 'Invalid tax rate';
                          }

                          return null;
                        },
                        onPlusPressed: () {
                          var val = double.tryParse(controller.taxRateCtrl.text.removeAllWhitespace);
                          if (val != null) {
                            val = val + 0.01;
                            controller.taxRateCtrl.text = val.toStringAsFixed(2);
                          } else {
                            controller.taxRateCtrl.text = '0.01';
                          }
                        },
                        onMinusPressed: () {
                          var val = double.tryParse(controller.taxRateCtrl.text.removeAllWhitespace);
                          if (val != null && val.isGreaterThan(0.01)) {
                            val = val - 0.01;
                            controller.taxRateCtrl.text = val.toStringAsFixed(2);
                          }
                        },
                      ),
                      LabeledTextField(
                        label: 'Tax Code',
                        controller: controller.taxCodeCtrl,
                        keyboardType: TextInputType.number,
                        required: true,
                        hintText: '1000',
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Field is required';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  decoration: BoxDecoration(
                      color: Theme.of(context).appBarTheme.backgroundColor,
                      borderRadius: const BorderRadius.all(Radius.circular(12.0))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Text('Override'),
                      ),
                      Center(
                        child: AdaptiveButton(
                            onPressed: () {},
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Platform.isIOS ? CupertinoIcons.add : Icons.add),
                                const Text(' Add Overrides')
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
