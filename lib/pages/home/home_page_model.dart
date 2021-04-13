import 'package:btix/models/film.dart';

enum TabView { comming, hot }

class HomePageModel {
  List<Film> listFilm;
  TabView current;
  HomePageModel({this.listFilm, this.current: TabView.hot});

  HomePageModel copyWith({List<Film> listFilm, TabView current}) {
    return HomePageModel(
        listFilm: listFilm ?? this.listFilm, current: current ?? this.current);
  }
}
