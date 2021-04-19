import 'package:btix/models/film.dart';

enum TabView { comming, hot }

class HomePageModel {
  List<Film> listFilm;
  List<Film> currentFilm;
  TabView current;
  HomePageModel({this.currentFilm, this.listFilm, this.current: TabView.hot});

  HomePageModel copyWith(
      {List<Film> listFilm, TabView current, List<Film> currentFilm}) {
    return HomePageModel(
        currentFilm: currentFilm ?? this.currentFilm,
        listFilm: listFilm ?? this.listFilm,
        current: current ?? this.current);
  }
}
