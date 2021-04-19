import 'package:btix/common/custom_color.dart';
import 'package:btix/common/custom_font.dart';
import 'package:btix/models/film.dart';
import 'package:btix/pages/detail/detail_film_page.dart';
import 'package:flutter/material.dart';

class FilmWidget extends StatelessWidget {
  final Film film;
  final Size deviceSize;
  FilmWidget({this.deviceSize, this.film});

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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailFilmPage(
                  film: film,
                )),
      ),
      child: Container(
        margin: EdgeInsets.only(bottom: deviceSize.height / 10),
        width: deviceSize.width / 1.1538,
        height: deviceSize.height / 5.4,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 16,
              offset: Offset(0, 5), // changes position of shadow
            ),
          ],
        ),
        child: Stack(
          overflow: Overflow.visible,
          children: [
            Positioned(
              left: 16,
              bottom: 16,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  height: deviceSize.height / 5,
                  width: deviceSize.width / 4.6,
                  child: Image.network(
                    film.image.replaceAll('http', 'https'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 24 + deviceSize.width / 4.6,
              top: deviceSize.height / 31.23076923076923,
              child: Container(
                  height: 18,
                  width: deviceSize.width / 2.19,
                  child: CustomFont(
                    text: film.name,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    context: context,
                    fontSize: 14,
                  )),
            ),
            Positioned(
                right: 24,
                top: deviceSize.height / 31.23076923076923,
                child: CustomFont(
                  text: film.ratingAverage.toString() + '.0',
                  color: CustomColor.yellow,
                  fontWeight: FontWeight.bold,
                  context: context,
                  fontSize: 14,
                )),
            Positioned(
                left: 24 + deviceSize.width / 4.6,
                top: 24 + deviceSize.height / 31.23076923076923,
                child: _buildFormat(context: context, format: 'IMAX')),
            Positioned(
                left: 24 + deviceSize.width / 4.6,
                top: 52 + deviceSize.height / 31.23076923076923,
                child: CustomFont(
                  text: 'Duration:   ${film.duration}',
                  color: CustomColor.black[2],
                  context: context,
                  fontSize: 12,
                )),
            Positioned(
                left: 24 + deviceSize.width / 4.6,
                top: 72 + deviceSize.height / 31.23076923076923,
                child: CustomFont(
                  text: 'Category:  ${film.category}',
                  color: CustomColor.black[2],
                  context: context,
                  fontSize: 12,
                )),
          ],
        ),
      ),
    );
  }
}
