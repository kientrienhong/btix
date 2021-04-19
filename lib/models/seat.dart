enum StatusSeat { available, sold, selected }

class Seat {
  final String id;
  final String name;
  final String idTheatre;
  final String nameTheatre;
  final String no;
  final double price;
  final bool isSold;
  final StatusSeat statusSeat;
  Seat(
      {this.statusSeat: StatusSeat.available,
      this.id,
      this.nameTheatre,
      this.name,
      this.idTheatre,
      this.no,
      this.price,
      this.isSold});

  Seat copyWith(
      {String id,
      String name,
      String idTheatre,
      String no,
      double price,
      StatusSeat statusSeat,
      String nameTheatre,
      bool isSold}) {
    return Seat(
        id: id ?? this.id,
        name: name ?? this.name,
        idTheatre: idTheatre ?? this.idTheatre,
        no: no ?? this.no,
        price: price ?? this.price,
        statusSeat: statusSeat ?? this.statusSeat,
        isSold: isSold ?? this.isSold,
        nameTheatre: nameTheatre ?? this.nameTheatre);
  }

  factory Seat.fromJson(Map<String, dynamic> json) {
    StatusSeat statusSeat =
        (json['daDat'] as bool) ? StatusSeat.sold : StatusSeat.available;

    return Seat(
        id: json['maGhe'].toString(),
        idTheatre: json['maRap'].toString(),
        isSold: json['daDat'] as bool,
        name: json['tenGhe'] as String,
        no: json['stt'] as String,
        price: json['giaVe'],
        statusSeat: statusSeat);
  }
}
