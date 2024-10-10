import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/theme/theme_data.dart';
import 'package:merchant_dashboard/utils/snack_alert/snack_alert.dart';
import 'package:merchant_dashboard/widgets/rounded_btn.dart';

import '../../../../utils/mixins/mixins.dart';
import '../../../products/presentation/widgets/select_image_picker_dialog.dart';

enum FileType { image, pdfAndImage }

class ChooseFileWidget extends StatefulWidget {
  const ChooseFileWidget(
      {super.key,
      this.height,
      this.width,
      required this.onImageChanged,
      this.acceptableFileTypes = FileType.image});

  final Function(XFile? file) onImageChanged;
  final double? width;
  final double? height;
  final FileType acceptableFileTypes;

  @override
  State<ChooseFileWidget> createState() => _ChooseFileWidgetState();
}

class _ChooseFileWidgetState extends State<ChooseFileWidget>
    with ImagesConditions {
  XFile? _selectedFile;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0xffeeeeee),
          )),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        RoundedBtnWidget(
          onTap: () async {
            if (!kIsWeb) {
              Get.dialog(SelectImagePickerDialog(onCameraTap: () async {
                Get.back();
                final result = await takeCameraImage();

                if (result.image != null) {
                  setState(() => _selectedFile = (result.image!));
                  widget.onImageChanged(result.image!);
                } else if (result.errorMessage != null) {
                  context.showCustomeAlert(result.errorMessage!);
                }
              }, onGalleryTap: () async {
                Get.back();
                final result = await pickImageFromGallery();

                if (result.image != null) {
                  setState(() => _selectedFile = (result.image!));
                  widget.onImageChanged(result.image!);
                } else if (result.errorMessage != null) {
                  context.showCustomeAlert(result.errorMessage!);
                }
              }));
            } else {
              // todo pick for web
              final result = (widget.acceptableFileTypes == FileType.image)
                  ? await pickImageFromGallery()
                  : await pickPdfAndImage();

              if (result.image != null) {
                setState(() => _selectedFile = (result.image!));
                widget.onImageChanged(result.image!);
              } else if (result.errorMessage != null) {
                print("errorMessage: " + result.errorMessage.toString());
                context.showCustomeAlert(result.errorMessage!);
              }
            }
          },
          btnText: S.current.chooseFile,
          btnTextColor: Colors.black,
          btnTextStyle: context.textTheme.bodyMedium,
          btnPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          btnMargin: const EdgeInsets.only(right: 16),
          bgColor: AppColors.lightGray,
        ),
        Expanded(
          child: Text(
            _selectedFile?.name ?? S.current.noFileChosen,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.bodyMedium?.copyWith(
                color: _selectedFile?.name == null
                    ? AppColors.gray
                    : AppColors.black),
          ),
        )
      ]),
    );
  }
}
