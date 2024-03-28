import 'package:intl/intl.dart';

class DateTimeUtil {
  static String dateAndTimeString({required DateTime dateTime}) {
    return DateFormat('yyyy-MM-dd hh:mm').format(dateTime);
  }
}
