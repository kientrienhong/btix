import 'dart:async';
import 'package:btix/apis/api.dart';
import 'package:btix/models/film.dart';
import 'package:btix/pages/home/home_page_model.dart';
import 'package:rxdart/subjects.dart';

class HomePageBloc {
  final _controller = PublishSubject<HomePageModel>();
  HomePageModel _model = HomePageModel();

  Stream<HomePageModel> get stream => _controller.stream;

  void dispose() {
    _controller.close();
  }

  void fetchListFilm() async {
    List<dynamic> response = await Api.fetchAllFilm();
    List<Film> listFilm =
        response.map<Film>((json) => Film.fromJson(json)).toList();
    DateTime now = DateTime.now();

    List<Film> currentFilm =
        listFilm.where((element) => now.isAfter(element.date)).toList();
    updateWith(listFilm: listFilm, currentFilm: currentFilm);
  }

  void updateWith(
      {TabView current, List<Film> listFilm, List<Film> currentFilm}) {
    _model = _model.copyWith(
        current: current, listFilm: listFilm, currentFilm: currentFilm);

    _controller.add(_model);
  }

  void switchTab(TabView current) {
    if (current == _model.current) {
      return;
    }

    TabView newTabView =
        _model.current == TabView.hot ? TabView.comming : TabView.hot;

    DateTime now = DateTime.now();
    List<Film> currentFilm;
    if (newTabView == TabView.hot) {
      currentFilm = _model.listFilm
          .where((element) => now.isAfter(element.date))
          .toList();
    } else {
      currentFilm = _model.listFilm
          .where((element) => element.date.isAfter(now))
          .toList();
    }

    updateWith(current: newTabView, currentFilm: currentFilm);
  }
}
