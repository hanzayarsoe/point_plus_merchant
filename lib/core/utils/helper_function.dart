import 'package:intl/intl.dart';

class HelperFunction {
  static String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) {
      return 'Good Morning';
    } else if (hour >= 12 && hour < 17) {
      return 'Good Afternoon';
    } else if (hour >= 17 && hour < 21) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }

  static bool isNotiDateHeadIsToday(String date) {
    final format = DateFormat("MMM d yyyy");

    final inputDate = format.parse(date);

    final now = DateTime.now();

    return inputDate.year == now.year &&
        inputDate.month == now.month &&
        inputDate.day == now.day;
  }
}
