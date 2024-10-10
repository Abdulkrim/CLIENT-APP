import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResponsiveDialogWidget extends StatelessWidget {
  const ResponsiveDialogWidget({
    super.key,
    this.onWillPop,
    this.title = '',
    required this.child,
    this.titleColor = Colors.white,
    this.width,
    this.height,
    this.roundedAppBar = false,
  });

  final Future<bool> Function()? onWillPop;
  final String title;
  final Widget child;
  final Color titleColor;
  final double? width;
  final double? height;
  final bool roundedAppBar;

  @override
  Widget build(BuildContext context) {
    return PopScope(
        onPopInvoked: (didPop) => onWillPop != null ? onWillPop!() : null,
        child: Scaffold(
          backgroundColor: (!kIsWeb) ? Colors.white : Colors.transparent,
          appBar: (!kIsWeb)
              ? AppBar(
                  title: Text(title, style: context.textTheme.titleMedium?.copyWith(color: titleColor)),
                  leading: IconButton(
                    onPressed: () => (onWillPop == null)
                        ? Get.back()
                        : () async {
                            if (await onWillPop!()) Get.back();
                          }.call(),
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: titleColor,
                    ),
                  ),
                  shape: roundedAppBar
                      ? const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)))
                      : null,
                )
              : null,
          body: Center(
            child: Container(
              decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(4))),
              width: width ?? (!kIsWeb ? context.mediaQuerySize.width : 550),
              height: height ?? (context.mediaQuerySize.height * (context.isPhone ? 1 : .9)),
              child: Column(children: [
                if (kIsWeb)
                  Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4))),
                    padding: const EdgeInsets.symmetric(horizontal: 10.5, vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(title, style: context.textTheme.titleMedium?.copyWith(color: titleColor)),
                        IconButton(
                          onPressed: () => (onWillPop == null)
                              ? Get.back()
                              : () async {
                                  if (await onWillPop!()) Get.back();
                                }.call(),
                          icon: const Icon(
                            Icons.close,
                            size: 18,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                Expanded(child: child),
              ]),
            ),
          ),
        ));
  }
}
