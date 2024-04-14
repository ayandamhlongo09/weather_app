import 'package:intl/intl.dart';

extension StringExtension on String {
  String get formatDateToWeekDay {
    try {
      return '${DateFormat.EEEE().format(DateTime.parse(this))} ';
    } catch (e) {
      return this;
    }
  }
}
