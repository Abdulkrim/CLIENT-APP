import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:merchant_dashboard/generated/assets.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/theme/theme_data.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/utils/snack_alert/snack_alert.dart';
import 'package:merchant_dashboard/widgets/container_setting.dart';
import 'package:merchant_dashboard/widgets/network_image_rounded_widget.dart';

import '../../../../utils/mixins/mixins.dart';
import 'delete_merchant_logo_dialog.dart';

class MerchantLogoWidget extends StatefulWidget {
  final String title;
  final EdgeInsetsGeometry margin;
  final String url;
  final String? tooltipText;

  final double? height;
  final double? width;
  final Function() onDeleteTap;

  final Function(XFile image) onSaveTapped;

  const MerchantLogoWidget({
    Key? key,
    this.margin = const EdgeInsets.all(8),
    this.height = 300,
    this.width = 270,
    required this.title,
    this.tooltipText,
    required this.url,
    required this.onSaveTapped,
    required this.onDeleteTap,
  }) : super(key: key);

  @override
  State<MerchantLogoWidget> createState() => _MerchantLogoWidgetState();
}

class _MerchantLogoWidgetState extends State<MerchantLogoWidget> with ImagesConditions {
  late XFile newUploadedImage;

  @override
  Widget build(BuildContext context) {
    return ContainerSetting(
      child: SizedBox(
        width: 250,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: context.textTheme.titleSmall
                    ?.copyWith(
                    fontWeight: FontWeight.bold,color: AppColors.headerColor),
              ),
              context.sizedBoxHeightMicro,
              Text(
                widget.tooltipText ?? '',
                style: context.textTheme.titleSmall
                    ?.copyWith(color: AppColors.gray),
              ),
              context.sizedBoxHeightMicro,

              NetworkImageRounded(
                height: 145,
                width: double.infinity,
                padding: const EdgeInsets.only(
                  bottom: 8,
                ),
                radius: BorderRadius.circular(8),
                url: '${widget.url}?${DateTime.now().millisecondsSinceEpoch.toString()}',
              ),
              context.sizedBoxHeightUltraSmall,

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      final result = await pickImageFromGallery();

                      if (result.image != null) {
                        widget.onSaveTapped(result.image!);
                      } else if (result.errorMessage != null) {
                        context.showCustomeAlert(result.errorMessage!);
                      }
                    },
                    icon:SvgPicture.asset(Assets.iconsUploadImage,height: 20,width: 20,color: Colors.black,),
                    label: Text(S.current.uploadImage,style: TextStyle(color: AppColors.black),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(color: AppColors.black),),
                    ),
                  ),
                  IconButton(
                      onPressed: () => Get.dialog(DeleteMerchantLogoDialog(
                        logoName: widget.title,
                        imageUrl: widget.url,
                        onDeleteTap: widget.onDeleteTap,
                      )),
                      icon: SvgPicture.asset(
                        Assets.iconsDeleteIcon,
                        height: 25,
                        width: 25,
                        color: Colors.red,
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
