import 'dart:ui';

import 'package:btix/common/custom_color.dart';
import 'package:btix/common/custom_font.dart';
import 'package:btix/common/custom_sized_box.dart';
import 'package:btix/models/film.dart';
import 'package:btix/pages/theatre/theatre_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:intl/intl.dart';

class DetailFilmPage extends StatelessWidget {
  final Film film;

  DetailFilmPage({this.film});

  @override
  Widget build(BuildContext context) {
    Widget _buildFormat({String format, BuildContext context}) {
      Color color = format == 'IMAX' ? CustomColor.yellow : CustomColor.green;

      return Container(
        width: 40,
        height: 20,
        decoration: BoxDecoration(
            border: Border.all(color: color),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
                bottomLeft: Radius.circular(4),
                bottomRight: Radius.circular(4))),
        child: Center(
          child: CustomFont(
            text: format,
            context: context,
            fontSize: 10,
            color: color,
          ),
        ),
      );
    }

    final deviceSize = MediaQuery.of(context).size;
    final imageUrl = film.image.replaceAll('http', 'https');
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: deviceSize.width,
          height: deviceSize.height * 1.1,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    decoration:
                        new BoxDecoration(color: Colors.white.withOpacity(0.0)),
                  ),
                ),
              ),
              Positioned(
                  top: deviceSize.height / 15,
                  left: deviceSize.width / 15,
                  child: GestureDetector(
                      onTap: () => {Navigator.of(context).pop()},
                      child: Image.asset('assets/images/backbutton.png'))),
              Positioned(
                left: 0,
                top: deviceSize.height * 1.1 / 5,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32)),
                  child: Container(
                    width: deviceSize.width,
                    height: deviceSize.height * 6.9 / 7,
                    color: CustomColor.white,
                  ),
                ),
              ),
              Positioned(
                top: deviceSize.height / 7,
                left: deviceSize.width / 15,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    width: deviceSize.width / 3,
                    height: deviceSize.height / 3.35,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 16,
                          offset: Offset(0, 5), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                  top: deviceSize.height / 4.25,
                  left: deviceSize.width / 2.3,
                  child: Container(
                    height: 28,
                    width: deviceSize.width / 2.1,
                    child: CustomFont(
                      text: film.name,
                      color: CustomColor.black[4],
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      context: context,
                    ),
                  )),
              Positioned(
                  top: deviceSize.height / 3.55,
                  left: deviceSize.width / 2.3,
                  child: _buildFormat(context: context, format: 'IMAX')),
              Positioned(
                  top: deviceSize.height / 3.1,
                  left: deviceSize.width / 2.3,
                  child: CustomFont(
                    text: 'Duration:   ${film.duration}',
                    color: CustomColor.black[2],
                    context: context,
                    fontSize: 12,
                  )),
              Positioned(
                  top: deviceSize.height / 2.85,
                  left: deviceSize.width / 2.3,
                  child: CustomFont(
                    text: 'Category:  ${film.category}',
                    color: CustomColor.black[2],
                    context: context,
                    fontSize: 12,
                  )),
              Positioned(
                  top: deviceSize.height / 2.44,
                  left: deviceSize.width / 2.3,
                  child: Row(
                    children: [
                      RatingBarIndicator(
                        rating: film.ratingAverage / 2,
                        itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: 18,
                        direction: Axis.horizontal,
                      ),
                      CustomSizedBox(
                        context: context,
                        width: 8,
                      ),
                      CustomFont(
                        text: film.ratingAverage.toString() + '.0',
                        color: CustomColor.yellow,
                        context: context,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      )
                    ],
                  )),
              Positioned(
                  top: deviceSize.height / 2.63,
                  left: deviceSize.width / 2.3,
                  child: CustomFont(
                    text:
                        'Release Date:  ${DateFormat('dd/MM/yyyy').format(film.date)}',
                    color: CustomColor.black[2],
                    context: context,
                    fontSize: 12,
                  )),
              Positioned(
                top: deviceSize.height / 2.1,
                left: deviceSize.width / 15,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomFont(
                        text: 'Introdution',
                        color: CustomColor.black[4],
                        fontWeight: FontWeight.bold,
                        context: context,
                        fontSize: 20,
                      ),
                      CustomSizedBox(
                        context: context,
                        height: 16,
                      ),
                      Container(
                        width: deviceSize.width * 5 / 6,
                        height: deviceSize.height * 1 / 4,
                        child: Text(
                          film.description,
                          maxLines: 5,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              height: deviceSize.width / 225,
                              letterSpacing: deviceSize.width / 250,
                              color: Color(0xFF130F26),
                              fontWeight: FontWeight.w300,
                              fontSize: deviceSize.width / 31.25),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          width: deviceSize.width * 5 / 6,
                          height: deviceSize.height * 1 / 5,
                          color: CustomColor.black[2],
                          child: Stack(
                            children: [
                              Positioned(
                                top: deviceSize.height * 1 / 18,
                                left: deviceSize.width * 1 / 3,
                                child: GestureDetector(
                                  onTap: () {
                                    FlutterYoutube.playYoutubeVideoByUrl(
                                        apiKey:
                                            "AIzaSyCNgLFZaHoTlV8vZmXNyjxmD3EsMT0-V78",
                                        videoUrl: film.trailer,
                                        autoPlay: true, //default falase
                                        fullScreen: true
                                        //default false
                                        );
                                  },
                                  child: Container(
                                    width: deviceSize.width * 1 / 5,
                                    height: deviceSize.width * 1 / 5,
                                    child: Image.asset(
                                      'assets/images/playbutton.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      CustomSizedBox(
                        context: context,
                        height: 16,
                      ),
                      Container(
                        width: deviceSize.width * 5 / 6,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                  width: deviceSize.width / 2.1,
                                  height: deviceSize.height / 14,
                                  color: CustomColor.yellow,
                                  child: Center(
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(PageRouteBuilder(
                                          pageBuilder: (context, animation,
                                                  secondaryAnimation) =>
                                              TheatrePage.create(film: film),
                                          transitionDuration:
                                              Duration(milliseconds: 750),
                                        ));
                                      },
                                      child: Text(
                                        'Buy Ticket',
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.bold,
                                            fontSize: deviceSize.height / 34),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
