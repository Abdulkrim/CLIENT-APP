import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/utils/snack_alert/snack_alert.dart';
import 'package:merchant_dashboard/widgets/rounded_btn.dart';
import 'package:mime/mime.dart';

import '../theme/theme_data.dart';

class DropDownZoneWidget extends StatefulWidget {
  const DropDownZoneWidget({
    super.key,
    this.height = 100,
    required this.fileUploaded,
  });

  final Function(String name, String mime, String url, Uint8List? byte) fileUploaded;
  final double height;

  @override
  State<DropDownZoneWidget> createState() => _DropDownZoneWidgetState();
}

class _DropDownZoneWidgetState extends State<DropDownZoneWidget> {
  late DropzoneViewController controller;

  final uploadedFile = <String, dynamic>{
    'name': '',
    'byte': null,
    'mime': '',
    'url': '',
  };

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Stack(
        children: [
          if (kIsWeb)
            DropzoneView(
              operation: DragOperation.copy,
              cursor: CursorType.grab,
              onCreated: (DropzoneViewController ctrl) => controller = ctrl,
              onDrop: (dynamic event) async {
                if (event.name.endsWith('.xlsx') || event.name.endsWith('.xls')) {
                  uploadedFile['name'] = event.name;
                  uploadedFile['mime'] = await controller.getFileMIME(event);
                  uploadedFile['byte'] = await controller.getFileData(event);
                  uploadedFile['url'] = await controller.createFileUrl(event);
                  setState(() {});

                  widget.fileUploaded(
                      uploadedFile['name'], uploadedFile['mime'], uploadedFile['url'], uploadedFile['byte']);
                } else {
                  context.showCustomeAlert(S.current.selectValidExcelFile, SnackBarType.alert);
                }
              },
            ),
          DottedBorder(
            borderType: BorderType.RRect,
            radius: const Radius.circular(10),
            color: context.colorScheme.primaryColorDark,
            child: DecoratedBox(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.lightPrimaryColor),
              child: GestureDetector(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (uploadedFile['name'].isNotEmpty)
                        Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(uploadedFile['name']),
                            IconButton(
                                onPressed: () {
                                  uploadedFile['name'] = '';
                                  uploadedFile['mime'] = '';
                                  uploadedFile['url'] = '';
                                  uploadedFile['byte'] = null;
                                  setState(() {});

                                  widget.fileUploaded(uploadedFile['name'], uploadedFile['mime'],
                                      uploadedFile['url'], uploadedFile['byte']);
                                },
                                icon: const Icon(Icons.cancel))
                          ],
                        ),
                      kIsWeb
                          ? Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.cloud_upload_rounded,
                                  color: Colors.grey,
                                  size: 30,
                                ),
                                Text(
                                  S.current.DropExcelFile,
                                  style: context.textTheme.bodyMedium,
                                ),
                                context.sizedBoxHeightExtraSmall,
                                ElevatedButton(
                                    onPressed: () async {
                                      final event = await controller.pickFiles(multiple: false);
                                      if (event.first.name.endsWith('.xlsx') ||
                                          event.first.name.endsWith('.xls')) {
                                        uploadedFile['name'] = event.first.name;
                                        uploadedFile['mime'] = await controller.getFileMIME(event.first);
                                        uploadedFile['byte'] = await controller.getFileData(event.first);
                                        uploadedFile['url'] = await controller.createFileUrl(event.first);
                                        setState(() {});

                                        widget.fileUploaded(uploadedFile['name'], uploadedFile['mime'],
                                            uploadedFile['url'], uploadedFile['byte']);
                                      } else {
                                        context.showCustomeAlert(
                                            S.current.selectValidExcelFile, SnackBarType.alert);
                                      }
                                    },
                                    child: const Text('Browse')),
                              ],
                            )
                          : RoundedBtnWidget(
                              btnPadding: const EdgeInsets.symmetric(horizontal: 25),
                              onTap: () async {
                                FilePickerResult? result = await FilePicker.platform.pickFiles();

                                if (result != null) {
                                  if (result.files.single.extension == ('xlsx') ||
                                      result.files.single.extension == ('xls')) {
                                    uploadedFile['name'] = result.files.single.name;
                                    uploadedFile['mime'] = lookupMimeType(result.files.single.path!);
                                    uploadedFile['byte'] =
                                        await File(result.files.single.path!).readAsBytes();
                                    uploadedFile['url'] = result.files.single.path;

                                    setState(() {});

                                    widget.fileUploaded(uploadedFile['name'], uploadedFile['mime'],
                                        uploadedFile['url'], uploadedFile['byte']);
                                  } else {
                                    context.showCustomeAlert(
                                        S.current.selectValidExcelFile, SnackBarType.alert);
                                  }
                                }
                              },
                              height: 35,
                              width: 270,
                              btnText: S.current.uploadProductsList,
                              btnIcon: const Icon(
                                Icons.folder_open_rounded,
                                color: Colors.white,
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
