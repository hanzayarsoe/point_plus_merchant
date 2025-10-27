import 'package:intl/intl.dart';

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

  static String formatNumber(double number) {
    return NumberFormat('#,###').format(number);
  }

  static String formatAsCardNumber(String number) {
    final RegExp regex = RegExp(r'.{1,4}');
    final Iterable<Match> matches = regex.allMatches(number);
    return matches.map((match) => match.group(0)!).join(' ');
  }
}
