import 'package:btix/models/schedule.dart';
import 'package:intl/intl.dart';

class Film {
  final String id;
  final String name;
  final String description;
  final String image;
  final String category;
  final String format;
  final String duration;
  final int ratingAverage;
  final double imbd;
  final DateTime date;
  final String trailer;
  final List<Schedule> listSchedule;
  Film(
      {this.trailer,
      this.listSchedule,
      this.name,
      this.id,
      this.description,
      this.image,
      this.category,
      this.duration,
      this.format,
      this.imbd,
      this.ratingAverage,
      this.date});

  Film copyWith(
      {String name,
      String image,
      String description,
      List<Schedule> listSchedule,
      String country,
      String duration,
      String category,
      String format,
      String trailer,
      int ratingAverage,
      double imbd}) {
    return Film(
        trailer: trailer ?? this.trailer,
        date: date ?? this.date,
        category: category ?? this.category,
        description: description ?? this.description,
        duration: duration ?? this.duration,
        format: format ?? this.format,
        image: image ?? this.image,
        imbd: imbd ?? this.imbd,
        name: name ?? this.name,
        listSchedule: listSchedule ?? this.listSchedule,
        ratingAverage: ratingAverage ?? this.ratingAverage);
  }

  factory Film.fromJson(Map<String, dynamic> json) {
    String date = json['ngayKhoiChieu'];
    final splittedDate = date.split('T');
    DateTime tempDate = DateFormat("yyyy-MM-dd").parse(splittedDate[0]);
    return Film(
        trailer: json['trailer'] as String,
        category: json['maNhom'] as String,
        // country: json['data']['data']['country'] as String,
        description: json['moTa'] as String,
        // duration: json['data']['data']['duration'] as String,
        // format: json['data']['data']['format'] as String,
        ratingAverage: json['danhGia'] as int,
        id: json['maPhim'].toString(),
        name: json['tenPhim'] as String,
        image: json['hinhAnh'] as String,
        date: tempDate);
  }
}
