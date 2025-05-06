

import 'package:intl/intl.dart';

class DateTimeFormatter{

  static String formatFull(DateTime date) => DateFormat('yyyy-MM-dd hh:mm a').format(date);
  static String dateAndTimeNowS( ) => formatFull(DateTime.now());



static String timeString(DateTime time)=>DateFormat('hh:mm a').format(time).toString();
  // static String formatTimeOnly(DateTime date) => DateFormat('hh:mm a').format(date);
  //
  // static String formatDateOnly(DateTime date) => DateFormat('yyyy-MM-dd').format(date);
  String extractDate(String dateTimeString) {
    DateTime dateTime = DateFormat('yyyy-MM-dd hh:mm a').parse(dateTimeString);
    return DateFormat('yyyy-MM-dd').format(dateTime); // الناتج: 2025-05-04
  }
  String extractTime(String dateTimeString) {
    DateTime dateTime = DateFormat('yyyy-MM-dd hh:mm a').parse(dateTimeString);
    return DateFormat('hh:mm a').format(dateTime); // الناتج: 2025-05-04
  }
}