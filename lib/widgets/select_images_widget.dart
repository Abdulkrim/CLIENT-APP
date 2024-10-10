import 'dart:io';

import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:merchant_dashboard/feature/products/presentation/widgets/select_image_picker_dialog.dart';
import 'package:merchant_dashboard/generated/assets.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/theme/theme_data.dart';
import 'package:merchant_dashboard/utils/mixins/mixins.dart';
import 'package:merchant_dashboard/utils/snack_alert/snack_alert.dart';
import 'package:merchant_dashboard/widgets/app_ink_well_widget.dart';
import 'package:merchant_dashboard/widgets/network_image_rounded_widget.dart';

class SelectImagesWidget extends StatefulWidget {
  const SelectImagesWidget(
      {super.key, required this.onImageChanged, this.imageUrl});

  final Function(XFile file) onImageChanged;
  final String? imageUrl;

  @override
  State<SelectImagesWidget> createState() => _SelectImagesWidgetState();
}

class _SelectImagesWidgetState extends State<SelectImagesWidget>
    with ImagesConditions {
  XFile selectedImage = XFile('');

  @override
  Widget build(BuildContext context) {
    return AppInkWell(
        onTap: () async {
          if (!kIsWeb) {
            Get.dialog(SelectImagePickerDialog(onCameraTap: () async {
              final result = await takeCameraImage();

              if (result.image != null) {
                setState(() => selectedImage = (result.image!));
                widget.onImageChanged(result.image!);
              } else if (result.errorMessage != null) {
                context.showCustomeAlert(result.errorMessage!);
              }
              Get.back();
            }, onGalleryTap: () async {
              final result = await pickImageFromGallery();

              if (result.image != null) {
                setState(() => selectedImage = (result.image!));
                widget.onImageChanged(result.image!);
              } else if (result.errorMessage != null) {
                context.showCustomeAlert(result.errorMessage!);
              }
              Get.back();
            }));
          } else {
            final result = await pickImageFromGallery();

            if (result.image != null) {
              setState(() => selectedImage = (result.image!));
              widget.onImageChanged(result.image!);
            } else if (result.errorMessage != null) {
              context.showCustomeAlert(result.errorMessage!);
            }
          }
        },
        hoverColor: Colors.transparent,
        child: Center(
          child: Container(
            height: 170,
            width: double.infinity,
            child: switch ((selectedImage, widget.imageUrl)) {
              (XFile sFile, _) when sFile.path.isNotEmpty => kIsWeb
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(25.0),
                      child: Image.network(
                        selectedImage.path,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ))
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(25.0),
                      child: Image.file(File(selectedImage.path))),
              (_, String url) => ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: FastCachedImage(
                    url: url,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.info),
                  ),
                ),
              (XFile sFile, String? url)
                  when sFile.path.isEmpty && url == null =>
                ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: Image.asset(
                    Assets.bgPlaceholderImage,
                    fit: BoxFit.cover,
                  ),
                ),
              _ => const SizedBox(),
            },
          ),
        ));
  }
}
