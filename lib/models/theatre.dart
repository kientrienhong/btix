import 'package:btix/models/film.dart';
import 'package:btix/models/schedule.dart';
import 'package:btix/models/theatre_brand.dart';

class Theatre {
  final String id;
  final String name;
  final TheatreBrand theatreBrand;
  final String address;
  final Film film;
  Theatre({this.film, this.address, this.id, this.name, this.theatreBrand});

  Theatre copyWith(
      {Film film,
      String address,
      String id,
      String name,
      TheatreBrand theatreBrand}) {
    return Theatre(
        film: film ?? this.film,
        address: address ?? this.address,
        id: id ?? this.id,
        name: name ?? this.name,
        theatreBrand: theatreBrand ?? this.theatreBrand);
  }

  factory Theatre.fromJson(
      {Map<String, dynamic> json, Film film, TheatreBrand brand}) {
    var currentFilm;

    (json['danhSachPhim'] as List<dynamic>).forEach((element) {
      if (element['maPhim'].toString() == film.id) {
        currentFilm = element;
        return;
      }
    });
    if (currentFilm == null) {
      return null;
    }

    List<Schedule> listSchedule = <Schedule>[];
    (currentFilm['lstLichChieuTheoPhim'] as List<dynamic>).forEach((element) {
      listSchedule.add(Schedule.fromJson(element));
    });

    return Theatre(
        address: json['diaChi'] as String,
        id: json['maCumRap'] as String,
        name: json['tenCumRap'] as String,
        film: film.copyWith(listSchedule: listSchedule),
        theatreBrand: brand);
  }
}
