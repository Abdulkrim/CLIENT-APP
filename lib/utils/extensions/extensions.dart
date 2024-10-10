import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
// import 'package:pushy_flutter/web/js_fallback.js';

import '../../core/client/response/server_error_response.dart';
import '../../theme/theme_data.dart';

extension ContextExtension on BuildContext {
  double dynamicHeight(double value) => MediaQuery.of(this).size.height * value;

  double dynamicWidth(double value) => MediaQuery.of(this).size.width * value;

  ThemeData get colorScheme => Theme.of(this);
}

// 1 500
// x 300
extension RatioExtension on num {
  double get dh => (this / Get.height) * Get.height;

  double get dw => (this / Get.width) * Get.width;
}

extension PaddingValues on BuildContext {
  /// Width
  double get paddingUltraSmallWidth => dynamicWidth(0.01);

  double get paddingExtraSmallWidth => dynamicWidth(0.02);

  double get paddingSmallWidth => dynamicWidth(0.04);

  double get paddingDefaultWidth => dynamicWidth(0.06);

  double get paddingLargeWidth => dynamicWidth(0.08);

  double get paddingExtraLargeWidth => dynamicWidth(0.1);

  /// Height
  double get paddingUltraSmallHeight => dynamicHeight(0.005);

  double get paddingExtraSmallHeight => dynamicHeight(0.01);

  double get paddingSmallHeight => dynamicHeight(0.02);

  double get paddingDefaultHeight => dynamicHeight(0.04);

  double get paddingLargeHeight => dynamicHeight(0.08);

  double get paddingExtraLargeHeight => dynamicHeight(0.08);
}

extension EmptyWidget on BuildContext {
  Widget get sizedBoxHeightMicro => SizedBox(
        height: dynamicHeight(0.005),
      );

  Widget get sizedBoxHeightUltraSmall => SizedBox(
        height: dynamicHeight(0.01),
      );

  Widget get sizedBoxHeightExtraSmall => SizedBox(
        height: dynamicHeight(0.02),
      );

  Widget get sizedBoxHeightSmall => SizedBox(
        height: dynamicHeight(0.04),
      );

  Widget get sizedBoxHeightDefault => SizedBox(
        height: dynamicHeight(0.06),
      );

  Widget get sizedBoxHeightLarge => SizedBox(
        height: dynamicHeight(0.08),
      );

  Widget get sizedBoxHeightExtraLarge => SizedBox(
        height: dynamicHeight(0.1),
      );

  Widget get sizedBoxWidthExtraSmall => SizedBox(
        width: dynamicWidth(0.02),
      );

  Widget get sizedBoxWidthMicro => SizedBox(
        width: dynamicWidth(0.01),
      );

  Widget get sizedBoxWidthSmall => SizedBox(
        width: dynamicWidth(0.04),
      );

  Widget get sizedBoxWidthDefault => SizedBox(
        width: dynamicWidth(0.06),
      );

  Widget get sizedBoxWidthLarge => SizedBox(
        width: dynamicWidth(0.08),
      );

  Widget get sizedBoxWidthExtraLarge => SizedBox(
        width: dynamicWidth(0.1),
      );
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

extension TableWidgets on BuildContext {
  TableRow headerTableRow(List<String> items, {AlignmentGeometry alignment = Alignment.center, bool headerHasColor = true}) =>
      TableRow(
          decoration: headerHasColor
              ? BoxDecoration(
                  color: const Color(0xfff5f6fa),
                  borderRadius: BorderRadius.circular(16),
                )
              : null,
          children: items
              .map(
                (e) => TableCell(
                  child: SizedBox(
                    height: 80,
                    child: Column(
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(
                              e,
                              textAlign: TextAlign.center,
                              style: textTheme.bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.bold, color: headerHasColor ? AppColors.gray : Colors.black),
                            ),
                          ),
                        ),
                        const Divider(
                          color: Colors.grey,
                          thickness: .2,
                        )
                      ],
                    ),
                  ),

                  /*SizedBox(
                height: 60,
                child: Align(
                  alignment: alignment,
                  child: Text(
                    e,
                    style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: headerHasColor? AppColors.gray: Colors.black),
                  ),
                ),
              ),*/
                ),
              )
              .toList());
}

extension Numbers on String {
  String toDoubleFixed(int count) {
    try {
      final number = double.parse(this).toStringAsFixed(count);
      return number.toString();
    } catch (e) {
      return '-';
    }
  }

  String get getSeparatedNumber => replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
}

extension Times on String {
  /// Short time format is => 12:11
  String? get evaluateShortTimeFormat => () {
        // Regular expression to match the format hh:mm or hh:mm:ss
        RegExp regex = RegExp(r'^((0?[1-9]|1[0-2]):([0-5]?[0-9])(:([0-5]?[0-9]))?)$');

        // Check if the input time matches the regular expression
        if (regex.hasMatch(this)) {
          // Split the time into hours, minutes, and optional seconds
          List<String> parts = this.split(':');
          String hours = parts[0].padLeft(2, '0'); // Add leading zero if needed
          String minutes = parts[1].padLeft(2, '0'); // Add leading zero if needed
          String seconds = parts.length == 3 ? parts[2].padLeft(2, '0') : '00'; // Add leading zero if needed

          // Include seconds if available
          String formattedTime = parts.length == 3 ? '$hours:$minutes:$seconds' : '$hours:$minutes';

          return formattedTime;
        }
      }.call();
}

extension GlobalKeyExtension on GlobalKey {
  /// Get [Rect] object of a key which is allocated to a widget.
  Rect? get globalPaintBounds {
    final renderObject = currentContext?.findRenderObject();
    final translation = renderObject?.getTransformTo(null).getTranslation();
    if (translation != null && renderObject?.paintBounds != null) {
      final offset = Offset(translation.x, translation.y);
      return renderObject!.paintBounds.shift(offset);
    } else {
      return null;
    }
  }

  Size get widgetSize {
    final RenderBox renderBox = currentContext!.findRenderObject() as RenderBox;

    return renderBox.size;
  }
}

extension MimeType on XFile {
  String? get platformMimeType => (kIsWeb) ? mimeType : lookupMimeType(path);
}

extension DioErrorResponse on DioException {
  ServerErrorResponse getDioErrorWrapper() =>
      ServerErrorResponse.fromJson(response?.data, message ?? (response?.statusCode ?? 0).toString());
}

extension IntUtils on int? {
  bool get isIdValid => this != null && this != 0 && this != -1;
}
