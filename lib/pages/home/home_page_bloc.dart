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
    updateWith(listFilm: listFilm);
  }

  void updateWith({TabView current, List<Film> listFilm}) {
    _model = _model.copyWith(current: current, listFilm: listFilm);

    _controller.add(_model);
  }

  void switchTab(TabView current) {
    if (current == _model.current) {
      return;
    }

    TabView newTabView =
        _model.current == TabView.hot ? TabView.comming : TabView.hot;

    updateWith(current: newTabView);
  }
}
