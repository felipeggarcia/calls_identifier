import 'package:intl/intl.dart';

class CallModel {
  final String phoneNumber;
  final DateTime date;

  CallModel({required this.date, required this.phoneNumber});

  String dateToString() {
    final formattedDate = DateFormat('dd/MM/yyyy – kk:mm').format(date);
    return formattedDate.toString();
  }
}
