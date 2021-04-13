import 'package:btix/models/film.dart';
import 'package:btix/models/theatre.dart';
import 'package:btix/models/theatre_brand.dart';

class TheatreModel {
  List<TheatreBrand> list;
  Film currentFilm;
  TheatreBrand currentTheatreBrand;
  List<Theatre> listTheatre;
  TheatreModel(
      {this.listTheatre,
      this.list,
      this.currentFilm,
      this.currentTheatreBrand});

  TheatreModel copyWith(
      {List<TheatreBrand> list,
      Film currentFilm,
      List<Theatre> listTheatre,
      TheatreBrand currentTheatreBrand}) {
    return TheatreModel(
        listTheatre: listTheatre ?? this.listTheatre,
        list: list ?? this.list,
        currentFilm: currentFilm ?? this.currentFilm,
        currentTheatreBrand: currentTheatreBrand ?? this.currentTheatreBrand);
  }
}
