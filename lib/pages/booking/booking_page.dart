import 'package:btix/models/theatre.dart';
import 'package:btix/pages/booking/booking_bloc.dart';
import 'package:btix/pages/booking/booking_container.dart';
import 'package:btix/pages/loading/loading_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookingPage extends StatelessWidget {
  final BookingBloc bloc;

  BookingPage({this.bloc});

  static Widget create(BuildContext context, Theatre theatre) {
    var bloc = BookingBloc();
    bloc.updateTheatre(theatre: theatre);
    bloc.fetchSeat();
    return Provider<BookingBloc>(
        create: (_) => bloc,
        dispose: (_, bloc) => bloc.dispose(),
        child: Consumer<BookingBloc>(
          builder: (_, bloc, __) => BookingPage(
            bloc: bloc,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: bloc.stream,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            return BookingContainer.create(context: context);
          }

          return LoadingPage();
        });
  }
}
