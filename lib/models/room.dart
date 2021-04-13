import 'package:btix/models/seat.dart';
import 'package:intl/intl.dart';

class Room {
  final String idSchedule;
  final String theatreName;
  final String name;
  final String theatreAddress;
  final String filmName;
  final String imageUrl;
  final String date;
  final String time;
  final List<Seat> seatList;
  Room(
      {this.idSchedule,
      this.theatreAddress,
      this.name,
      this.theatreName,
      this.date,
      this.filmName,
      this.imageUrl,
      this.seatList,
      this.time});

  Room copyWith({
    List<Seat> seatList,
    String idSchedule,
    String theatreName,
    String name,
    String theatreAddress,
    String filmName,
    String imageUrl,
    String date,
    String time,
  }) {
    return Room(
      idSchedule: idSchedule ?? this.idSchedule,
      seatList: seatList ?? this.seatList,
      date: date ?? this.date,
      theatreName: theatreName ?? this.theatreName,
      name: name ?? this.name,
      theatreAddress: theatreAddress ?? this.theatreAddress,
      filmName: filmName ?? this.filmName,
      imageUrl: imageUrl ?? this.imageUrl,
      time: time ?? this.time,
    );
  }

  factory Room.fromJson(Map<String, dynamic> json, List<Seat> listSeat) {
    var date =
        DateFormat('dd/MM/yyyy').parse(json['thongTinPhim']['ngayChieu']);
    var dateString = DateFormat('d MMM').format(date);
    return Room(
        filmName: json['thongTinPhim']['tenPhim'] as String,
        idSchedule: json['thongTinPhim']['maLichChieu'].toString(),
        imageUrl: json['thongTinPhim']['hinhAnh'] as String,
        name: json['thongTinPhim']['tenRap'] as String,
        theatreAddress: json['thongTinPhim']['diaChi'] as String,
        theatreName: json['thongTinPhim']['tenCumRap'] as String,
        time: json['thongTinPhim']['gioChieu'] as String,
        seatList: listSeat,
        date: dateString);
  }
}
