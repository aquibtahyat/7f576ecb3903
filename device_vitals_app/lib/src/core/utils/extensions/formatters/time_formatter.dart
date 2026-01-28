import 'package:intl/intl.dart';

class TimeFormatter {
  static String formatDateTime(DateTime dateTime) {
    final formatter = DateFormat('d MMMM, hh:mm a');
    return formatter.format(dateTime);
  }
}
