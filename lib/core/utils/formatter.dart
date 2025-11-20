import 'package:intl/intl.dart';
import 'package:merchant/features/auth/domain/entities/nrc.dart';
import 'package:timeago/timeago.dart' as timeago;

class Formatter {
  Formatter._();

  static DateTime formartUtcToLocalTime(String utcString) {
    final utcDateTime = DateTime.parse(utcString);
    final localDateTime = utcDateTime.toLocal();
    return localDateTime;
  }

  static String formatHistoryDate(String utcString, String localeCode) {
    final localDateTime = formartUtcToLocalTime(utcString);
    return DateFormat.yMMMMd(localeCode).format(localDateTime);
  }

  static String formatHistoryTime(String utcString, String localeCode) {
    final localDateTime = formartUtcToLocalTime(utcString);
    return DateFormat.jm(localeCode).format(localDateTime);
  }

  static String formatSecondToMinuteAndSecond(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  static String formatNumber(int number) {
    return NumberFormat('#,###').format(number);
  }

  static String formatAsCardNumber(String number) {
    final RegExp regex = RegExp(r'.{1,4}');
    final Iterable<Match> matches = regex.allMatches(number);
    return matches.map((match) => match.group(0)!).join(' ');
  }

  static String fromNumberAsHidden(int number) {
    final hiddenText = '*' * number.toString().length;
    return hiddenText;
  }

  static String formatNrcToString(Nrc nrc) {
    return '${nrc.stateNumber}/${nrc.township}${nrc.citizenType}${nrc.code}';
  }

  static String formatDateOfBirth(DateTime dob) {
    return DateFormat('d MMMM yyyy').format(dob);
  }

  static String formatStringToDateOfBirth(String dob) {
    final parsedDate = DateTime.parse(dob);
    return DateFormat('d MMMM yyyy').format(parsedDate);
  }

  static DateTime formatAmPmToDateTime(String time) {
    return DateFormat('hh:mm a').parse(time);
  }

  static String formatDateTimeToAmPm(DateTime time) {
    return DateFormat('hh:mm a').format(time);
  }

  static DateTime parseTime(String timeString) {
    try {
      return DateFormat('hh:mm a').parse(timeString);
    } catch (e) {
      return DateTime.now();
    }
  }

  static String getOrdinalSuffix(int day) {
    if (day >= 11 && day <= 13) return 'th';
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  static String formatDateToHistoryDate(DateTime date) {
    String day = date.day.toString();
    String suffix = getOrdinalSuffix(date.day);
    String monthYear = DateFormat('MMMM, y').format(date);
    return "$day$suffix $monthYear";
  }

  static String? formatDateToStringDate(DateTime? date) {
    if (date == null) {
      return null;
    }
    return DateFormat('yyyy-MM-dd').format(date);
  }

  static String formatUtcTimeToHistoryTransactionDateTime(String utcTime) {
    final DateTime parsedTime = DateTime.parse(utcTime);
    final DateTime localTime = parsedTime.toLocal();
    final DateFormat formatter = DateFormat('MMM d, y . hh:mm a');
    final String formattedString = formatter.format(localTime);
    return formattedString;
  }

  static String formatUtcTimeToHistoryTransactionDate(String utcTime) {
    final DateTime parsedTime = DateTime.parse(utcTime);
    final DateTime localTime = parsedTime.toLocal();
    final DateFormat formatter = DateFormat('MMM d, y');
    final String formattedString = formatter.format(localTime);
    return formattedString;
  }

  static String formatUtcTimeToHistoryTransactionTime(String utcTime) {
    final DateTime parsedTime = DateTime.parse(utcTime);
    final DateTime localTime = parsedTime.toLocal();
    final DateFormat formatter = DateFormat('hh:mm a');
    final String formattedString = formatter.format(localTime);
    return formattedString;
  }

  static String maskAndChunkString(
    String text, {
    int visibleChars = 4,
    int chunkSize = 4,
    String maskChar = '*',
  }) {
    if (text.isEmpty) {
      return "";
    }

    String visible = text
        .substring(0, (text.length < visibleChars ? text.length : visibleChars))
        .padRight(visibleChars, maskChar);

    String masked;
    if (text.length <= visibleChars) {
      masked = "";
    } else {
      masked = maskChar * (text.length - visibleChars);
    }

    String combined = visible + masked;

    List<String> chunks = [];
    for (int i = 0; i < combined.length; i += chunkSize) {
      int end = (i + chunkSize < combined.length)
          ? i + chunkSize
          : combined.length;
      chunks.add(combined.substring(i, end));
    }
    return chunks.join(' ');
  }

  static String formatUtcTimeToTimeago(DateTime dateTime) {
    DateTime localTime = dateTime.toLocal();

    return timeago.format(localTime);
  }
}
