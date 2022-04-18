part of 'utils.dart';

String millisToMinutes(int millis) {
  int minute = (millis / 60000).floor();
  int second = int.tryParse(((millis % 60000) / 1000).toStringAsFixed(0)) ?? 0;
  return "$minute.${(second < 10 ? "0" : "")}$second";
}
