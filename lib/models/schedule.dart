import 'package:intl/intl.dart';

class Schedule {
  final String id;
  final String date;
  final String time;
  final double price;

  Schedule({this.id, this.date, this.time, this.price});

  Schedule copyWith({String id, String date, String time, double price}) {
    return Schedule(
        date: date ?? this.date,
        id: id ?? this.id,
        price: price ?? this.price,
        time: time ?? this.time);
  }

  factory Schedule.fromJson(Map<String, dynamic> json) {
    List<String> splittedTime = json['ngayChieuGioChieu'].split('T');
    DateTime tempDate = DateFormat("yyyy-MM-dd").parse(splittedTime[0]);
    String date = DateFormat("d EEE").format(tempDate);
    DateTime time = DateFormat('HH:mm:ss').parse(splittedTime[1]);
    String timeString = DateFormat('HH:mm').format(time);
    return Schedule(
        date: date,
        time: timeString,
        id: json['maLichChieu'].toString(),
        price: json['giaVe'] as double);
  }
}
