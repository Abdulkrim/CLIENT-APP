import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/routes/app_routes.dart';
import 'package:merchant_dashboard/theme/theme_data.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/app_ink_well_widget.dart';

class NotFoundPageScreen extends StatelessWidget {
  const NotFoundPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.sentiment_dissatisfied_rounded,
                color: AppColors.gray,
                size: 200,
              ),
              context.sizedBoxHeightExtraSmall,
              Text(
                '404',
                textAlign: TextAlign.center,
                style: context.textTheme.displayLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.gray,
                    ),
              ),
              context.sizedBoxHeightMicro,
              Text(
                "Page Not Fount",
                textAlign: TextAlign.center,
                style: context.textTheme.headlineSmall?.copyWith(
                      color: AppColors.gray,
                    ),
              ),
              context.sizedBoxHeightMicro,
              Text(
                "The page you are looking for doesn't exist or an other error occurred.",
                textAlign: TextAlign.center,
                style: context.textTheme.headlineSmall?.copyWith(
                      color: AppColors.gray,
                    ),
              ),
              context.sizedBoxHeightMicro,
              AppInkWell(
                onTap: () => Get.offAllNamed(AppRoutes.loginRoute),
                child: Text(
                  "Go back!",
                  textAlign: TextAlign.center,
                  style: context.textTheme.headlineSmall?.copyWith(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
