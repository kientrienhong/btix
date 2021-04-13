import 'package:btix/models/film.dart';
import 'package:btix/pages/loading/loading_page.dart';
import 'package:btix/pages/theatre/theatre_bloc.dart';
import 'package:btix/pages/theatre/theatre_container.dart';
import 'package:btix/pages/theatre/theatre_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TheatrePage extends StatelessWidget {
  final TheatreBloc bloc;
  final Film film;
  TheatrePage({this.bloc, this.film});

  static Widget create({Film film}) {
    var bloc = TheatreBloc();
    bloc.fetchAllTheatreBrand(currentFilm: film);
    return Provider<TheatreBloc>(
      create: (_) => bloc,
      dispose: (_, bloc) => bloc.dispose(),
      child: Consumer<TheatreBloc>(
          builder: (_, bloc, __) => TheatrePage(
                bloc: bloc,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc.stream,
      initialData: TheatreModel(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          return TheatreContainer();
        }

        return LoadingPage();
      },
    );
  }
}
