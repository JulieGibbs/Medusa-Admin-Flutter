import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medusa_admin/app/modules/draft_orders_module/create_draft_order/components/pick_customer/controllers/pick_customer_controller.dart';

import '../../../../data/models/store/address.dart';
import '../../../../data/models/store/country.dart';
import '../../../../data/models/store/customer.dart';
import '../../../../routes/app_pages.dart';
import '../../../components/adaptive_icon.dart';
import '../../../components/custom_expansion_tile.dart';
import '../../../components/custom_text_field.dart';
import '../controllers/create_draft_order_controller.dart';

class AddressView extends StatefulWidget {
  const AddressView(this.controller, {super.key, this.context});
  final CreateDraftOrderController controller;
  final BuildContext? context;
  @override
  State<AddressView> createState() => _AddressViewState();
}

class _AddressViewState extends State<AddressView>
    with AutomaticKeepAliveClientMixin<AddressView> {
  final customerCtrl = TextEditingController();
  final emailCtrl = TextEditingController();

  final firstNameCtrl = TextEditingController();
  final lastNameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final companyCtrl = TextEditingController();

  final address1Ctrl = TextEditingController();
  final address2Ctrl = TextEditingController();
  final postalCodeCtrl = TextEditingController();
  final cityCtrl = TextEditingController();
  final provinceCtrl = TextEditingController();
  final scrollController = ScrollController();
  final shippingGeneralKey = GlobalKey();
  final billingGeneralKey = GlobalKey();
  final shippingAddressKey = GlobalKey();
  final billingAddressKey = GlobalKey();

  final billingFirstNameCtrl = TextEditingController();
  final billingLastNameCtrl = TextEditingController();
  final billingPhoneCtrl = TextEditingController();
  final billingCompanyCtrl = TextEditingController();

  final billingAddress1Ctrl = TextEditingController();
  final billingAddress2Ctrl = TextEditingController();
  final billingPostalCodeCtrl = TextEditingController();
  final billingCityCtrl = TextEditingController();
  final billingProvinceCtrl = TextEditingController();

  @override
  void dispose() {
    scrollController.dispose();
    customerCtrl.dispose();
    emailCtrl.dispose();
    firstNameCtrl.dispose();
    lastNameCtrl.dispose();
    phoneCtrl.dispose();
    companyCtrl.dispose();
    address1Ctrl.dispose();
    address2Ctrl.dispose();
    postalCodeCtrl.dispose();
    cityCtrl.dispose();
    provinceCtrl.dispose();
    billingFirstNameCtrl.dispose();
    billingLastNameCtrl.dispose();
    billingPhoneCtrl.dispose();
    billingCompanyCtrl.dispose();
    billingAddress1Ctrl.dispose();
    billingAddress2Ctrl.dispose();
    billingPostalCodeCtrl.dispose();
    billingCityCtrl.dispose();
    billingProvinceCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final controller = widget.controller;
    const space = SizedBox(height: 12.0);
    const halfSpace = SizedBox(height: 6.0);
    final lightWhite = Get.isDarkMode ? Colors.white54 : Colors.black54;
    final smallTextStyle = Theme.of(context).textTheme.titleSmall;
    final countries = controller.selectedRegion?.countries;
    final mediumTextStyle = Theme.of(context).textTheme.titleMedium;

    Future<void> scrollToSelectedContent(
        {required GlobalKey globalKey, Duration? delay}) async {
      await Future.delayed(delay ?? const Duration(milliseconds: 240))
          .then((value) async {
        final yPosition =
            (globalKey.currentContext?.findRenderObject() as RenderBox?)
                    ?.localToGlobal(Offset.zero)
                    .dy ??
                0.0;
        var topPadding =
            (widget.context?.mediaQueryPadding.top ?? 0) + kToolbarHeight;
        final scrollPoint = scrollController.offset + yPosition - topPadding;
        if (scrollPoint <= scrollController.position.maxScrollExtent) {
          await scrollController.animateTo(scrollPoint - 10,
              duration: const Duration(milliseconds: 300),
              curve: Curves.fastOutSlowIn);
        } else {
          await scrollController.animateTo(
              scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.fastOutSlowIn);
        }
      });
    }

    return SafeArea(
        child: Form(
      key: controller.formKey2,
      child: SingleChildScrollView(
        controller: scrollController,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Column(
            children: [
              LabeledTextField(
                label: 'Customer',
                controller: customerCtrl,
                readOnly: true,
                onTap: () async {
                  final result = await Get.toNamed(Routes.PICK_CUSTOMER,
                      arguments: PickCustomerReq(
                          selectedCustomers: controller.selectedCustomer != null
                              ? [controller.selectedCustomer!]
                              : null));
                  if (result is PickCustomerRes) {
                    final customer = result.selectedCustomers.first;
                    controller.selectedCustomer = customer;
                    controller.customCustomer = false;
                    customerCtrl.text = customer.firstName != null
                        ? '${customer.firstName ?? ''} ${customer.lastName ?? ''} (${customer.email})'
                        : customer.email;
                    emailCtrl.text = customer.email;
                    firstNameCtrl.text = customer.firstName ?? '';
                    lastNameCtrl.text = customer.lastName ?? '';
                    phoneCtrl.text = customer.phone ?? '';
                    setState(() {});
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Choose customer',
                  suffixIcon: controller.selectedCustomer != null &&
                          !controller.customCustomer
                      ? AdaptiveIcon(
                          onPressed: () {
                            controller.selectedCustomer = null;
                            controller.customCustomer = true;
                            customerCtrl.clear();
                            firstNameCtrl.clear();
                            lastNameCtrl.clear();
                            phoneCtrl.clear();
                            emailCtrl.clear();
                            setState(() {});
                          },
                          icon: const Icon(CupertinoIcons.clear_circled))
                      : const Icon(Icons.arrow_drop_down),
                ),
                validator: (val) {
                  if (emailCtrl.text.removeAllWhitespace.isNotEmpty &&
                      (val?.isEmpty ?? true)) {
                    return null;
                  }

                  if (emailCtrl.text.removeAllWhitespace.isEmpty &&
                      (val?.isEmpty ?? true)) {
                    return 'Field is required';
                  }

                  return null;
                },
              ),
              LabeledTextField(
                label: 'Email',
                style: controller.customCustomer
                    ? null
                    : smallTextStyle?.copyWith(color: lightWhite),
                onChanged: (val) {
                  if (!controller.customCustomer &&
                      controller.selectedCustomer == null) {
                    controller.customCustomer = true;
                  }
                  if(val.removeAllWhitespace.isNotEmpty) {
                    controller.selectedCustomer = Customer(email: val);
                  }
                },
                validator: (val) {
                  if (customerCtrl.text.isNotEmpty && (val?.isEmpty ?? true)) {
                    return null;
                  }

                  if (customerCtrl.text.isEmpty && (val?.isEmpty ?? true)) {
                    return 'Field is required';
                  }

                  return null;
                },
                required: true,
                controller: emailCtrl,
                readOnly: !controller.customCustomer,
                hintText: 'lebron@james.com',
                decoration: InputDecoration(
                    prefixIcon: controller.customCustomer
                        ? null
                        : Icon(CupertinoIcons.lock_fill, color: lightWhite)),
              ),
              space,
              const Text('Shipping Details'),
              space,
              CustomExpansionTile(
                key: shippingGeneralKey,
                // label: 'General',
                title: Text('General', style: smallTextStyle),
                onExpansionChanged: (expanded) async {
                  if (expanded) {
                    await scrollToSelectedContent(
                        globalKey: shippingGeneralKey);
                  }
                },
                children: [
                  LabeledTextField(
                    label: 'First Name',
                    controller: firstNameCtrl,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Field is required';
                      }
                      return null;
                    },
                    onChanged: (val) {
                      controller.shippingAddress.firstName = val;
                    },
                    required: true,
                  ),
                  LabeledTextField(
                    label: 'Last Name',
                    controller: lastNameCtrl,
                    onChanged: (val) {
                      controller.shippingAddress.lastName = val;
                    },
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Field is required';
                      }
                      return null;
                    },
                    required: true,
                  ),
                  LabeledTextField(
                    label: 'Company',
                    controller: companyCtrl,
                    onChanged: (val) {
                      controller.shippingAddress.company = val;
                    },
                  ),
                  LabeledTextField(
                    label: 'Phone Number',
                    controller: phoneCtrl,
                    onChanged: (val) {
                      controller.shippingAddress.phone = int.tryParse(val);
                    },
                  ),
                ],
              ),
              space,
              CustomExpansionTile(
                key: shippingAddressKey,
                // label: 'Shipping Address',
                title: Text('Shipping Address', style: smallTextStyle),
                onExpansionChanged: (expanded) async {
                  if (expanded) {
                    await scrollToSelectedContent(
                        globalKey: shippingAddressKey);
                  }
                },
                children: [
                  LabeledTextField(
                    label: 'Address 1',
                    controller: address1Ctrl,
                    onChanged: (val) {
                      controller.shippingAddress.address1 = val;
                    },
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Field is required';
                      }
                      return null;
                    },
                    required: true,
                  ),
                  LabeledTextField(
                    label: 'Address 2',
                    controller: address2Ctrl,
                    onChanged: (val) {
                      controller.shippingAddress.address2 = val;
                    },
                  ),
                  LabeledTextField(
                    label: 'Postal Code',
                    controller: postalCodeCtrl,
                    onChanged: (val) {
                      controller.shippingAddress.postalCode = val;
                    },
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Field is required';
                      }
                      return null;
                    },
                    required: true,
                  ),
                  LabeledTextField(
                    label: 'City',
                    controller: cityCtrl,
                    onChanged: (val) {
                      controller.shippingAddress.city = val;
                    },
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Field is required';
                      }
                      return null;
                    },
                    required: true,
                  ),
                  LabeledTextField(
                    label: 'Province',
                    controller: provinceCtrl,
                    onChanged: (val) {
                      controller.shippingAddress.province = val;
                    },
                  ),
                  if (countries?.isNotEmpty ?? false)
                    Column(
                      children: [
                        Row(
                          children: [
                            Text('Country', style: mediumTextStyle),
                            Text('*',
                                style: mediumTextStyle?.copyWith(
                                    color: Colors.red))
                          ],
                        ),
                        halfSpace,
                        DropdownButtonFormField<Country>(
                          value: countries?.first,
                          items: countries
                              ?.map((e) => DropdownMenuItem<Country>(
                                    value: e,
                                    child: Text(e.name?.capitalize ?? ''),
                                  ))
                              .toList(),
                          onChanged: (Country? country) {
                            controller.shippingAddress.country = country;
                          },
                          validator: (val) {
                            if (val == null) {
                              return 'Country is required';
                            }
                            return null;
                          },
                        ),
                        space,
                      ],
                    ),
                ],
              ),
              halfSpace,
              const Divider(),
              const Text('Billing Details'),
              space,
              CheckboxListTile(
                value: controller.sameAddress,
                onChanged: (val) {
                  if (val == null) return;
                  if (val) {
                    controller.sameAddress = true;
                    billingFirstNameCtrl.clear();
                    billingLastNameCtrl.clear();
                    billingCompanyCtrl.clear();
                    billingPhoneCtrl.clear();
                    billingAddress1Ctrl.clear();
                    billingAddress2Ctrl.clear();
                    billingPostalCodeCtrl.clear();
                    billingCityCtrl.clear();
                    billingProvinceCtrl.clear();
                  } else {
                    controller.billingAddress = Address();
                    controller.sameAddress = false;
                  }
                  controller.update();
                },
                title: Text('Use same as shipping', style: smallTextStyle),
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
              ),
              space,
              CustomExpansionTile(
                key: billingGeneralKey,
                // label: 'General',
                title: Text('General', style: smallTextStyle),
                onExpansionChanged: (expanded) async {
                  if (expanded) {
                    await scrollToSelectedContent(globalKey: billingGeneralKey);
                  }
                },
                children: [
                  LabeledTextField(
                    label: 'First Name',
                    lightLabelColor: controller.sameAddress,
                    readOnly: controller.sameAddress,
                    controller: billingFirstNameCtrl,
                    onChanged: (val) {
                      controller.billingAddress.firstName = val;
                    },
                    validator: (val) {
                      if (controller.sameAddress) {
                        return null;
                      }
                      if (val == null || val.isEmpty) {
                        return 'Field is required';
                      }
                      return null;
                    },
                    required: true,
                  ),
                  LabeledTextField(
                    label: 'Last Name',
                    lightLabelColor: controller.sameAddress,
                    readOnly: controller.sameAddress,
                    controller: billingLastNameCtrl,
                    onChanged: (val) {
                      controller.billingAddress.lastName = val;
                    },
                    validator: (val) {
                      if (controller.sameAddress) {
                        return null;
                      }
                      if (val == null || val.isEmpty) {
                        return 'Field is required';
                      }
                      return null;
                    },
                    required: true,
                  ),
                  LabeledTextField(
                    label: 'Company',
                    lightLabelColor: controller.sameAddress,
                    readOnly: controller.sameAddress,
                    controller: billingCompanyCtrl,
                    onChanged: (val) {
                      controller.billingAddress.company = val;
                    },
                  ),
                  LabeledTextField(
                    label: 'Phone Number',
                    lightLabelColor: controller.sameAddress,
                    readOnly: controller.sameAddress,
                    controller: billingPhoneCtrl,
                    onChanged: (val) {
                      controller.billingAddress.phone = int.tryParse(val);
                    },
                  ),
                ],
              ),
              space,
              CustomExpansionTile(
                key: billingAddressKey,
                // label: 'Billing Address',
                title: Text('Billing Address', style: smallTextStyle),
                onExpansionChanged: (expanded) async {
                  if (expanded) {
                    await scrollToSelectedContent(globalKey: billingAddressKey);
                  }
                },
                children: [
                  LabeledTextField(
                    label: 'Address 1',
                    lightLabelColor: controller.sameAddress,
                    readOnly: controller.sameAddress,
                    controller: billingAddress1Ctrl,
                    onChanged: (val) {
                      controller.billingAddress.address1 = val;
                    },
                    validator: (val) {
                      if (controller.sameAddress) {
                        return null;
                      }
                      if (val == null || val.isEmpty) {
                        return 'Field is required';
                      }
                      return null;
                    },
                    required: true,
                  ),
                  LabeledTextField(
                    label: 'Address 2',
                    lightLabelColor: controller.sameAddress,
                    readOnly: controller.sameAddress,
                    controller: billingAddress2Ctrl,
                    onChanged: (val) {
                      controller.billingAddress.address2 = val;
                    },
                  ),
                  LabeledTextField(
                    label: 'Postal Code',
                    lightLabelColor: controller.sameAddress,
                    readOnly: controller.sameAddress,
                    controller: billingPostalCodeCtrl,
                    onChanged: (val) {
                      controller.billingAddress.postalCode = val;
                    },
                    validator: (val) {
                      if (controller.sameAddress) {
                        return null;
                      }
                      if (val == null || val.isEmpty) {
                        return 'Field is required';
                      }
                      return null;
                    },
                    required: true,
                  ),
                  LabeledTextField(
                    label: 'City',
                    lightLabelColor: controller.sameAddress,
                    readOnly: controller.sameAddress,
                    controller: billingCityCtrl,
                    onChanged: (val) {
                      controller.billingAddress.city = val;
                    },
                    validator: (val) {
                      if (controller.sameAddress) {
                        return null;
                      }
                      if (val == null || val.isEmpty) {
                        return 'Field is required';
                      }
                      return null;
                    },
                    required: true,
                  ),
                  LabeledTextField(
                    label: 'Province',
                    lightLabelColor: controller.sameAddress,
                    readOnly: controller.sameAddress,
                    controller: billingProvinceCtrl,
                    onChanged: (val) {
                      controller.billingAddress.province = val;
                    },
                  ),
                  if (countries?.isNotEmpty ?? false)
                    Column(
                      children: [
                        Row(
                          children: [
                            Text('Country', style: mediumTextStyle),
                            Text('*',
                                style: mediumTextStyle?.copyWith(
                                    color: Colors.red))
                          ],
                        ),
                        halfSpace,
                        DropdownButtonFormField<Country>(
                          value: countries?.first,
                          items: countries
                              ?.map((e) => DropdownMenuItem<Country>(
                                    value: e,
                                    child: Text(e.name?.capitalize ?? ''),
                                  ))
                              .toList(),
                          onChanged: (Country? country) {
                            controller.billingAddress.country = country;
                          },
                          validator: (val) {
                            if (controller.sameAddress) {
                              return null;
                            }
                            if (val == null) {
                              return 'Country is required';
                            }
                            return null;
                          },
                        ),
                        space,
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }

  @override
  bool get wantKeepAlive => true;
}
