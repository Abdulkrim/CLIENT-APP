import 'package:intl/intl.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

mixin DateTimeUtilities {
  String convertDateFormat(String? utcDate,
      {String utcFormat = "yyyy-MM-ddTHH:mm:ss", String requestedFormet = "M/dd/y", bool hasTime = true}) {
    try {
      if (utcDate != null && utcDate.isNotEmpty) {
        var dateTime = DateFormat(utcFormat, 'en').parse(utcDate, true);

        String formattedDate = DateFormat(!hasTime ? requestedFormet : '$requestedFormet  HH:mm', 'en').format(dateTime);

        return formattedDate;
      } else {
        return '-';
      }
    } catch (error) {
      /*   if (utcDate != null && utcDate.isNotEmpty) {
        var dateTime = DateFormat("HH:mm:ssTdd-MM-yyyy").parse(utcDate, true);

        String formattedDate = DateFormat(!hasTime ? requestedFormet : '$requestedFormet  HH:mm').format(dateTime);

        return formattedDate;
      } else {
        return '-';
      }*/
      return utcDate ?? '';
    }
  }

  String getTodayDayName() {
    final String dayName = DateFormat('EEE', 'en').format(DateTime.now());
    return dayName;
  }

  DateTime parsDate(String date, [String format = "y/M/d"]) {
    return DateFormat(format, 'en').parse(date);
  }

  // bool isSecondDateBigger(String firstDate, String secondDate) {
  //   final DateTime firstD = parsDate(firstDate);
  //   final DateTime secondD = parsDate(secondDate);
  //   return (!firstD.isAfter(secondD) || firstD.isAtSameMomentAs(secondD));
  // }

  String getDaysAhead(String date, int day) =>
      DateFormat('yyyy-MM-dd', 'en').format(DateTime.parse(date).add(Duration(days: day)));

  String get todayDate => DateFormat('yyyy-MM-dd', 'en').format(DateTime.now());

  String get weekAgoDate => DateFormat('yyyy-MM-dd', 'en').format(DateTime.now().subtract(const Duration(days: 7)));

  String get monthAgoDate => DateFormat('yyyy-MM-dd', 'en').format(DateTime.now().subtract(const Duration(days: 30)));

  String getFilterFormatDate(String date) => date.replaceAll('/', '-');

  int getDateDifferenceInDay(String? startDate, String? endDate, {String format = "yyyy-MM-ddTHH:mm:ss", bool hasTime = true}) {
    if (startDate != null && endDate != null) {
      DateTime startDateFormatted = DateFormat(format, 'en').parse(startDate, true);
      DateTime endDateFormattetd = DateFormat(format, 'en').parse(endDate, true);

      int differenceInDays = endDateFormattetd.difference(startDateFormatted).inDays;

      return differenceInDays;
    }
    return -1;
  }

  String convertTo24Hour(String time) {
    // Split the input time into hours and minutes
    List<String> parts = time.split(':');

    // Parse hours and minutes
    String hours = parts[0].padLeft(2, '0'); // Ensure hours are at least 2 digits
    String minutes = parts[1].padLeft(2, '0'); // Ensure minutes are at least 2 digits

    // Return formatted time
    return '$hours:$minutes';
  }

  int getDateDifferenceInMonth(String? startDate, String? endDate, {String format = "yyyy-MM-ddTHH:mm:ss", bool hasTime = true}) {
    if (startDate != null && endDate != null) {
      DateTime startDateFormatted = DateTime.parse(startDate);
      DateTime endDateFormattetd = DateTime.parse(endDate);

      int differenceInMonths =
          endDateFormattetd.month - startDateFormatted.month + (endDateFormattetd.year - startDateFormatted.year) * 12;

      return differenceInMonths;
    }
    return -1;
  }

  String normalizeTimeFormat(String inputTime) {
    final RegExp timeRegex = RegExp(r'^([01]?[0-9]|1[0-2]):([0-5]?[0-9])(:([0-5]?[0-9]))?$');
    final match = timeRegex.firstMatch(inputTime);

    if (match != null) {
      final String hours = match.group(1)!.padLeft(2, '0');
      final String minutes = match.group(2)!.padLeft(2, '0');
      final String seconds = match.group(4) != null ? match.group(4)!.padLeft(2, '0') : '00';

      return '$hours:$minutes:$seconds';
    }

    throw FormatException('Invalid time format');
  }

  bool is12HourFormat(String inputTime) {
    final normalized = normalizeTimeFormat(inputTime.trim());
    RegExp twelveHourRegex = RegExp(r'^([01]?[0-9]|1[0-2]):([0-5]?[0-9])(:[0-5]?[0-9])?$');
    return twelveHourRegex.hasMatch(normalized);

  }
}
