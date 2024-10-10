import 'package:flutter/material.dart';

import '../theme/theme_data.dart';

Widget appVerticalDivider({double dividerWidth = .2}) => VerticalDivider(
      width: dividerWidth,
      color: AppColors.gray2,
    );

Widget appHorizontalDivider({double dividerWidth = .2, Color? color}) => Divider(
      height: dividerWidth,
      color: color ?? AppColors.gray2,
    );
