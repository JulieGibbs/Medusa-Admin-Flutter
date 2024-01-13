import 'dart:io';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medusa_admin/core/utils/colors.dart';
import 'package:medusa_admin/core/utils/extension.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../controllers/add_update_product_controller.dart';
import 'image_card.dart';
import 'package:flex_expansion_tile/flex_expansion_tile.dart';

class ProductMedia extends StatelessWidget {
  const ProductMedia({super.key, this.onExpansionChanged});
  final void Function(bool)? onExpansionChanged;

  @override
  Widget build(BuildContext context) {
    final lightWhite = ColorManager.manatee;
    final smallTextStyle = context.bodySmall;
    const space = Gap(12);
    return GetBuilder<AddUpdateProductController>(
      id: 5,
      builder: (controller) {
        return FlexExpansionTile(
          controller: controller.mediaTileCtrl,
          title: const Text('Media'),
          onExpansionChanged: onExpansionChanged,
          child: Column(
            children: [
              Text('Add images to your product.', style: smallTextStyle?.copyWith(color: lightWhite)),
              space,
              if (controller.updateMode && (controller.product.images?.isNotEmpty ?? false))
                Column(
                  children: [
                    ListView.separated(
                        separatorBuilder: (_, __) => space,
                        itemCount: controller.product.images!.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final image = controller.product.images![index];
                          return Opacity(
                            opacity: controller.imagesToDelete.map((e) => e.url).toList().contains(image.url) ? 0.5 : 1.0,
                            child: NetworkImageCard(
                              image.url ?? '',
                              deleteIconColor: controller.imagesToDelete.map((e) => e.url).toList().contains(image.url)
                                  ? Colors.red
                                  : null,
                              onDelete: () {
                                if (controller.imagesToDelete.map((e) => e.url).toList().contains(image.url)) {
                                  controller.imagesToDelete.removeWhere((element) => element.url == image.url);
                                } else {
                                  controller.imagesToDelete.add(image);
                                }
                                controller.update([5]);
                              },
                            ),
                          );
                        }),
                    if (controller.images.isNotEmpty) const Divider(),
                  ],
                ),
              if (controller.images.isNotEmpty)
                ListView.separated(
                    separatorBuilder: (_, __) => space,
                    itemCount: controller.images.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final image = controller.images[index];
                      return ImageCard(
                        image,
                        onRename: () async {
                          final result = await showBarModalBottomSheet(
                              context: context,
                              backgroundColor: context.theme.scaffoldBackgroundColor,
                              overlayStyle: context.theme.appBarTheme.systemOverlayStyle,
                              builder: (context) {
                                return RenameFileView(image);
                              });

                          if (result is File) {
                            controller.images[index] = result;
                            controller.update([5]);
                          }
                        },
                        onDelete: () async {
                          try {
                            controller.images[index].delete();
                            controller.images.removeAt(index);
                            controller.update([5]);
                          } catch (e) {
                            await Fluttertoast.showToast(msg: 'Error deleting image');
                          }
                        },
                        onCrop: () async {
                          final result = await controller.imagePickerHelper.cropImage(image);
                          if (result != null) {
                            try {
                              controller.images[index].delete();
                              controller.images[index] = result;
                              controller.update([5]);
                            } catch (e) {
                              await Fluttertoast.showToast(msg: 'Error cropping image');
                            }
                          }
                        },
                      );
                    }),
              Center(
                child: TextButton(
                    onPressed: () async {
                      ImageSource? imageSource = ImageSource.gallery;
                      imageSource = await showModalActionSheet<ImageSource>(
                          context: context,
                          title: 'Image Source',
                          actions: ImageSource.values
                              .map((e) => SheetAction<ImageSource>(
                            key: e,
                            label: e.name.capitalize ?? e.name,
                          ))
                              .toList());
                      if (imageSource == null) {
                        return;
                      }
                      try {
                        switch (imageSource) {
                          case ImageSource.camera:
                            await controller.imagePickerHelper.imagePicker(source: imageSource).then((result) {
                              if (result == null) {
                                return;
                              }
                              controller.images.add(result);
                              controller.update([5]);
                            });
                          case ImageSource.gallery:
                            await controller.imagePickerHelper.multipleImagePicker().then((result) {
                              if (result.isEmpty) {
                                return;
                              }
                              controller.images.addAll(result);
                              controller.update([5]);
                            });
                        }
                      } catch (e) {
                        debugPrint(e.toString());
                      }
                    },
                    child: const Text('Pick images')),
              )
            ],
          ),
        );
      },
    );
  }
}

class RenameFileView extends StatefulWidget {
  const RenameFileView(this.file, {super.key});
  final File file;

  @override
  State<RenameFileView> createState() => _RenameFileViewState();
}

class _RenameFileViewState extends State<RenameFileView> {
  final textCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final focusNode = FocusNode();
  late String fileExtension;
  @override
  void initState() {
    fileExtension = widget.file.path.split('.').last;
    textCtrl.text = widget.file.path.split(Platform.pathSeparator).last.replaceAll('.$fileExtension', '');
    Future.delayed(const Duration(milliseconds: 200)).then((value) {
      focusNode.requestFocus();
    });
    super.initState();
  }

  @override
  void dispose() {
    textCtrl.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final smallTextStyle = context.bodySmall;
    Future<void> renameFile() async {
      var path = widget.file.path;
      var lastSeparator = path.lastIndexOf(Platform.pathSeparator);
      final newName = textCtrl.text.replaceAll('/', '');
      var newPath = '${path.substring(0, lastSeparator + 1)}$newName.$fileExtension';

      if ('${path.substring(0, lastSeparator + 1)}$newName.$fileExtension' == path) {
        context.popRoute();
        return;
      }

      if (!formKey.currentState!.validate()) {
        return;
      }
      try {
        context.popRoute(widget.file.rename(newPath));
      } catch (e) {
        debugPrint(e.toString());
      }
    }

    return Container(
      padding: EdgeInsets.only(bottom: context.mediaQueryViewInsets.bottom + context.mediaQueryPadding.bottom),
      color: context.theme.scaffoldBackgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppBar(
            title: const Text('Rename File'),
            actions: [TextButton(onPressed: () async => renameFile(), child: const Text('Rename'))],
          ),
          Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
              child: TextFormField(
                controller: textCtrl,
                focusNode: focusNode,
                style: smallTextStyle,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Name cannot be empty';
                  }

                  if (File('${widget.file.parent.path}/$val.$fileExtension').existsSync()) {
                    return 'Another file with the same name exists';
                  }
                  return null;
                },
                maxLines: null,
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9]"))],
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (val) async => renameFile(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
