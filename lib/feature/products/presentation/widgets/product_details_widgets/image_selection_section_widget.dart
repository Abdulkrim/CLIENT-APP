import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/snack_alert/snack_alert.dart';
import 'package:merchant_dashboard/widgets/loading_widget.dart';
import 'package:merchant_dashboard/widgets/network_image_rounded_widget.dart';

import '../../../../../generated/assets.dart';
import '../../../../../theme/theme_data.dart';
import '../../../../../utils/mixins/mixins.dart';
import '../../../../../widgets/app_ink_well_widget.dart';
import '../select_image_picker_dialog.dart';

class ImageSelectionSectionWidget extends StatefulWidget {
  const ImageSelectionSectionWidget(
      {super.key,
      required this.imageUrl,
      required this.onImageChanged,
      this.showBackButton = true,
      this.width,
      this.height});

  final Function(XFile file) onImageChanged;
  final String? imageUrl;
  final bool showBackButton;

  final double? width;
  final double? height;

  @override
  State<ImageSelectionSectionWidget> createState() =>
      _ImageSelectionSectionWidgetState();
}

class _ImageSelectionSectionWidgetState
    extends State<ImageSelectionSectionWidget> with ImagesConditions {
  XFile selectedImage = XFile('');

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? Get.width,
      height: widget.height ?? Get.height,
      child: AppInkWell(
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
          child: (isLoading)
              ? const LoadingWidget()
              : switch ((selectedImage, widget.imageUrl)) {
                  (XFile sFile, _) when sFile.path.isNotEmpty =>
                    !context.isPhone
                        ? NetworkImageRounded(url: selectedImage.path)
                        : Image.file(File(selectedImage.path)),
                  (_, String url) => NetworkImageRounded(url: url),
                  (XFile sFile, String? url)
                      when sFile.path.isEmpty && url == null =>
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          Assets.iconsUploadImage,
                          width: 40,
                          color: AppColors.black,
                        ),
                        Text(
                          S.current.uploadImage,
                          style: context.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  _ => const SizedBox(),
                }),
    );
  }
}
