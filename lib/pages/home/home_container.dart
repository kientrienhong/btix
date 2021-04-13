import 'package:btix/pages/home/home_page_bloc.dart';
import 'package:btix/pages/home/home_page_model.dart';
import 'package:btix/pages/home/home_tab_view.dart';
import 'package:btix/pages/loading/loading_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeContainer extends StatelessWidget {
  final HomePageBloc bloc;
  HomeContainer({this.bloc});

  static Widget create(BuildContext context) {
    var bloc = HomePageBloc();
    bloc.fetchListFilm();

    return Provider<HomePageBloc>(
        create: (_) => bloc,
        dispose: (_, bloc) => bloc.dispose(),
        child: Consumer<HomePageBloc>(
          builder: (_, bloc, __) => HomeContainer(
            bloc: bloc,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc.stream,
      initialData: HomePageModel(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }

          return HomeTabView(
            model: snapshot.data,
          );
        }

        return LoadingPage();
      },
    );
  }
}
