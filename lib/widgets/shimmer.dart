import 'package:flutter/cupertino.dart';
import 'package:merchant_dashboard/theme/theme_data.dart';

class ShimmerWidget extends StatelessWidget {
  final double width, height;
  final EdgeInsetsGeometry? shaderMargin;

  const ShimmerWidget(
      {Key? key,
      required this.width,
      required this.height,
      this.shaderMargin = const EdgeInsets.all(0)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        color: AppColors.white,
        child: const Center(child: CupertinoActivityIndicator()));
  }
}
