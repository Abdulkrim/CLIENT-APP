import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:merchant_dashboard/injection.dart';
import 'package:mime/mime.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../theme/theme_data.dart';

mixin ImagesConditions {
  static const List<String> imageValidTypes = ['png', 'jpeg', 'jpg'];
  static const List<String> imageXFileValidTypes = [
    'image/png',
    'image/jpeg',
    'image/jpg'
  ];
  static const List<String> fileValidTypes = ['pdf'];

  String getXFileExt(XFile? xfile) => xfile == null
      ? ''
      : (kIsWeb)
          ? xfile.mimeType!.toLowerCase()
          : lookupMimeType(xfile.path) ?? '';

  bool isFileSuffixValid(String? fileExt, List<String> validTypes) =>
      validTypes.contains(fileExt);

  Future<bool> isFileLargerThan(XFile file, double maxSizeInMB) async {
    try {
      Uint8List? fileBytes = await file.readAsBytes();
      final fileLength = fileBytes.length;

      if (fileLength <= 1) return true;

      final fileSizeInMB = fileLength / (1024 * 1024);

      return fileSizeInMB > maxSizeInMB;
    } catch (e) {
      debugPrint('Error: $e');
      return false;
    }
  }

  Future<num> getFileSize(String filePath) async {
    try {
      // Create a File instance
      final file = XFile(filePath);

      // Get the file length in bytes
      final fileLength = await file.length();

      // Convert bytes to kilobytes
      final fileSizeInKB = fileLength / 1024;

      return fileSizeInKB;
    } catch (e) {
      debugPrint('Error: $e');
      return -1; // Returning -1 to indicate an error
    }
  }

  final ImagePicker _picker = ImagePicker();

  Future<({XFile? image, String? errorMessage})> takeCameraImage() async {
    final XFile? img =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 45);

    if (img != null) {
      if (isFileSuffixValid(getXFileExt(img), imageXFileValidTypes) &&
          !await isFileLargerThan(img, 2)) {
        return (image: img, errorMessage: null);
      }
      return (
        image: null,
        errorMessage: "Please select JPG or PNG image format only."
      );
    }

    return (image: null, errorMessage: null);
  }

  Future<({XFile? image, String? errorMessage})> pickPdfAndImage() async {
    print("pickPdfAndImage");
    var file = await FilePicker.platform.pickFiles();

    if (file != null) {
      if (isFileSuffixValid(file.files.single.extension!,
          [...imageValidTypes, ...fileValidTypes])) {
        print("isFileSuffixValid: true");
        return (
          image: XFile.fromData(
            file.files.single.bytes!,
            name: file.files.single.name,
          ),
          errorMessage: null
        );
      }
      return (
        image: null,
        errorMessage:
            "Please select a valid JPG or PNG image format with less than 5M size."
      );
    }

    return (image: null, errorMessage: null);
  }

  Future<({XFile? image, String? errorMessage})> pickImageFromGallery() async {
    var img =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    if (img != null) {
      if (isFileSuffixValid(getXFileExt(img), imageXFileValidTypes) &&
          !await isFileLargerThan(img, 2)) {
        debugPrint('marjan ${await getFileSize(img.path)}');
        return (image: img, errorMessage: null);
      }
      return (
        image: null,
        errorMessage:
            "Please select a valid JPG or PNG image format with less than 2M size."
      );
    }

    return (image: null, errorMessage: null);
  }

  String extractIdFromUrl(String url) {
    final RegExp regex =
        RegExp(r'Uploads/(\d+)\.(jpg|jpeg|png|gif|bmp|tiff|webp)');
    final Match? match = regex.firstMatch(url);
    if (match != null) {
      return match.group(1)!;
    }
    throw ArgumentError('Invalid URL format');
  }
}

mixin ProfileBGColorGenerator {
  int get randomColorPos =>
      getIt<Random>().nextInt(AppColors.profileImageBGColors.length);
}

mixin DateTimeUtils {
  int getDayNumber(String dayName) => switch (dayName.toLowerCase()) {
        'monday' => 0,
        'tuesday' => 1,
        'wednesday' => 2,
        'thursday' => 3,
        'friday' => 4,
        'saturday' => 5,
        'sunday' => 6,
        _ => -1
      };

  String getShortDayName(int dayNum) => switch (dayNum) {
        0 => 'Mo',
        1 => 'Tu',
        2 => 'We',
        3 => 'Th',
        4 => 'Fr',
        5 => 'Sa',
        6 => 'Su',
        _ => '-'
      };

  String get fullTimeZoneCurrentDateTime =>
      DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ").format(DateTime.now());
}

mixin DownloadUtils {
  Future<void> openWhatsAppLink(
      {String phoneNumber = '+9718009922',
      String defaultText = '',
      bool openInNewTab = true}) async {
    (kIsWeb)
        ? await launchUrl(
            Uri.parse('https://wa.me/$phoneNumber?text=$defaultText'),
            webOnlyWindowName: openInNewTab ? "_blank" : "_self",
          )
        : await launchUrl(Uri.parse('https://wa.me/$phoneNumber'),
            mode: LaunchMode.externalApplication);
  }

  Future<void> openLink({required String url, bool openInNewTab = true}) async {
    (kIsWeb)
        ? await launchUrl(
            Uri.parse(url),
            webOnlyWindowName: openInNewTab ? "_blank" : "_self",
          )
        : await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }
}
