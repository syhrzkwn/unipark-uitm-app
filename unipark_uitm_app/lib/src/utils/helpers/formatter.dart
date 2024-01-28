import 'package:intl/intl.dart';

class Formatter {
  static String formatDate(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat('yyyy-MM-dd').format(date);
  }

  static String formatDateTime(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat('dd MMM yyyy, H:mm a').format(date);
  }

  // Format phone number, example: +6012-3456789
  static String formatPhoneNumber(String phoneNumber) {
    if(phoneNumber.length == 10) {
      return '+6${phoneNumber.substring(0, 1)} ${phoneNumber.substring(1, 3)}-${phoneNumber.substring(3, 10)}';
    } else if(phoneNumber.length == 10) {
      return '+6${phoneNumber.substring(0, 1)} ${phoneNumber.substring(1, 3)}-${phoneNumber.substring(3, 11)}';
    }
    return phoneNumber;
  }
}