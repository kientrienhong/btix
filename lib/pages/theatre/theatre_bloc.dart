import 'package:btix/apis/api.dart';
import 'package:btix/models/film.dart';
import 'package:btix/models/theatre.dart';
import 'package:btix/pages/theatre/theatre_model.dart';
import 'package:rxdart/rxdart.dart';
import '../../models/theatre_brand.dart';

class TheatreBloc {
  final _controller = PublishSubject<TheatreModel>();
  TheatreModel _model = TheatreModel();
  Stream<TheatreModel> get stream => _controller.stream;

  void dispose() {
    _controller.close();
  }

  void updateWith(
      {List<Theatre> listTheatre,
      List<TheatreBrand> list,
      TheatreBrand theatreBrand,
      Film film}) {
    _model = _model.copyWith(
        listTheatre: listTheatre,
        list: list,
        currentFilm: film,
        currentTheatreBrand: theatreBrand);
    _controller.add(_model);
  }

  void fetchAllTheatreBrand({Film currentFilm}) async {
    List<dynamic> reponse = await Api.fetchAllTheatreBrand();
    List<TheatreBrand> listBrand =
        reponse.map<TheatreBrand>((e) => TheatreBrand.fromJson(e)).toList();
    updateWith(list: listBrand, theatreBrand: listBrand[0], film: currentFilm);
    fetchAllTheatreBrandVia();
  }

  void tapTheatreBrand({TheatreBrand theatreBrand}) {
    updateWith(theatreBrand: theatreBrand);
    fetchAllTheatreBrandVia();
  }

  void fetchAllTheatreBrandVia() async {
    List<dynamic> reponse =
        await Api.fetchAllTheatreBrandVia(_model.currentTheatreBrand.id);
    List<dynamic> lstCumRap = reponse[0]['lstCumRap'];
    List<Theatre> listTheatre = <Theatre>[];
    lstCumRap.forEach((element) {
      listTheatre.add(Theatre.fromJson(
          json: element,
          brand: _model.currentTheatreBrand,
          film: _model.currentFilm));
    });
    updateWith(
        listTheatre: listTheatre.where((element) => element != null).toList());
  }
}
