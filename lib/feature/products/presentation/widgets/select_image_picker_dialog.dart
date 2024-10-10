import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/generated/assets.dart';
import 'package:merchant_dashboard/generated/l10n.dart';

class SelectImagePickerDialog extends StatelessWidget {
  const SelectImagePickerDialog({super.key, required this.onCameraTap, required this.onGalleryTap});

  final Function onCameraTap;
  final Function onGalleryTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 300,
        height: 120,
        child: DecoratedBox(
          decoration:
              const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                label: Text(S.current.camera, style: context.textTheme.titleMedium,),
                onPressed: () {
                  onCameraTap();
                },
                icon: Image.asset(Assets.iconsCamera, width: 40,),
              ),
              TextButton.icon(
                label: Text(S.current.gallery, style: context.textTheme.titleMedium,),
                onPressed: () async {
                  onGalleryTap();
                },
                icon: Image.asset(Assets.iconsGallery, width: 40,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
