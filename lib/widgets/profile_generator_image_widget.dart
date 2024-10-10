
import 'dart:math';

import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:merchant_dashboard/theme/theme_data.dart';

import '../injection.dart';

class ProfileGeneratorImageWidget extends StatefulWidget {
  final int? itemColorIndex;
  final String? itemLabel;

  final double height;
  final double width;

  const ProfileGeneratorImageWidget({Key? key, required this.itemLabel,   this.itemColorIndex, this.height = 70, this.width = 70})
      : super(key: key);

  @override
  State<ProfileGeneratorImageWidget> createState() => _ProfileGeneratorImageWidgetState();
}

class _ProfileGeneratorImageWidgetState extends State<ProfileGeneratorImageWidget> {
  late int _colorPos;

  @override
  void initState() {
    super.initState();
    _colorPos = widget.itemColorIndex ?? getIt<Random>().nextInt(AppColors.profileImageBGColors.length);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.profileImageBGColors.keys.elementAt(widget.itemColorIndex ?? _colorPos),
      ),
      child: Center(
          child: Text(
        widget.itemLabel?.trim().characters.firstOrNull?.toUpperCase() ?? 'A',
        style: context.textTheme.titleLarge?.copyWith(
              color: AppColors.profileImageBGColors.values.elementAt(widget.itemColorIndex ?? _colorPos),
            ),
      )),
    );
  }
}
