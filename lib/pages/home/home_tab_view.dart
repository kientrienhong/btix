import 'package:btix/common/custom_app_bar.dart';
import 'package:btix/common/custom_bottom_navigation.dart';
import 'package:btix/common/custom_color.dart';
import 'package:btix/common/custom_font.dart';
import 'package:btix/common/custom_sized_box.dart';
import 'package:btix/models/film.dart';
import 'package:btix/pages/home/film_widget.dart';
import 'package:btix/pages/home/home_page_bloc.dart';
import 'package:btix/pages/home/home_page_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTabView extends StatefulWidget {
  final HomePageModel model;
  HomeTabView({this.model});

  @override
  _HomeTabViewState createState() => _HomeTabViewState();
}

class _HomeTabViewState extends State<HomeTabView> {
  Widget _buildAnimationHorizontalSize(
      {Size deviceSize, HomePageModel model, BuildContext context}) {
    return AnimatedPositioned(
      child: Row(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
              height: 6,
              width: deviceSize.width / 12,
              color: CustomColor.yellow),
        ),
        CustomSizedBox(
          context: context,
          width: 2,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
              height: 6,
              width: deviceSize.width / 32,
              color: CustomColor.yellow),
        ),
      ]),
      duration: Duration(milliseconds: 300),
      bottom: 0,
      left: model.current == TabView.hot
          ? deviceSize.width / 6
          : deviceSize.width / 1.5,
    );
  }

  Widget _buildTabText(
      {String text,
      BuildContext context,
      HomePageModel model,
      TabView current}) {
    HomePageBloc bloc = Provider.of<HomePageBloc>(context, listen: false);
    Color color =
        model.current == current ? Colors.black : CustomColor.black[1];

    FontWeight fontWeight =
        model.current == current ? FontWeight.bold : FontWeight.normal;
    return Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      GestureDetector(
          onTap: () => bloc.switchTab(current),
          child: CustomFont(
            text: text,
            fontWeight: fontWeight,
            color: color,
            context: context,
            fontSize: 20,
          )),
      SizedBox(
        height: 8,
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    HomePageBloc bloc = Provider.of<HomePageBloc>(context, listen: false);
    return StreamBuilder(
        stream: bloc.stream,
        builder: (ctx, snapshot) {
          return Stack(children: [
            CustomSizedBox(
              context: context,
              height: 24,
            ),
            Positioned(
              top: deviceSize.height / 33.833,
              child: Container(
                width: deviceSize.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildTabText(
                        context: context,
                        model: widget.model,
                        text: 'Hot Movies',
                        current: TabView.hot),
                    _buildTabText(
                        context: context,
                        model: widget.model,
                        text: 'Comming soon',
                        current: TabView.comming),
                  ],
                ),
              ),
            ),
            Positioned(
              top: deviceSize.height / 13,
              child: Container(
                width: deviceSize.width,
                height: 6,
                child: Stack(children: [
                  _buildAnimationHorizontalSize(
                      context: context,
                      deviceSize: deviceSize,
                      model: widget.model),
                ]),
              ),
            ),
            Positioned(
              child: Container(
                margin: EdgeInsets.only(top: deviceSize.height / 9),
                height: deviceSize.height / 1.2,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: widget.model.currentFilm.length,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 40),
                    itemBuilder: (context, index) {
                      Film film = widget.model.currentFilm[index];
                      film.copyWith(format: 'IMAX');
                      return FilmWidget(
                        film: film,
                        deviceSize: deviceSize,
                      );
                    }),
              ),
            ),
          ]);
        });
  }
}
