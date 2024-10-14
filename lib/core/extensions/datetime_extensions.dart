import 'package:intl/intl.dart';

extension Date on DateTime {
  String toReadableDate() => DateFormat.yMMMMd().format(this);

  String toReadableTime() =>
      DateFormat.jm().format(this).toLowerCase().replaceAll(' ', '');
}
