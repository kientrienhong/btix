import 'package:btix/common/custom_color.dart';
import 'package:btix/common/custom_font.dart';
import 'package:btix/common/custom_sized_box.dart';
import 'package:btix/models/seat.dart';
import 'package:btix/pages/booking/booking_model.dart';
import 'package:flutter/material.dart';

class BillPage extends StatelessWidget {
  final BookingModel model;

  BillPage({this.model});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    Widget _buildSelectedSeat(
        {List<Seat> selectedSeat, Size deviceSize, BuildContext context}) {
      String name = '';
      selectedSeat.forEach((element) {
        name += element.name + ',';
      });
      if (name.length != 0) name = name.substring(0, name.length - 1);
      return Container(
        width: deviceSize.width / 5,
        child: CustomFont(
          text: name,
          maxLines: 2,
          color: Colors.black,
          fontSize: 14,
          context: context,
          textOverflow: TextOverflow.ellipsis,
        ),
      );
    }

    Widget _buildRow({Widget buildContentLeft, Widget buildContentRight}) {
      return SizedBox(
        height: deviceSize.height / 9.666666666666667,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [buildContentLeft, buildContentRight],
          ),
        ),
      );
    }

    Widget _buildContent(
        {String title, String content, int maxLines, bool isLeft}) {
      double width =
          isLeft == true ? deviceSize.width / 2 : deviceSize.width / 5;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: width,
            child: CustomFont(
              text: title,
              maxLines: 2,
              color: CustomColor.black[2],
              context: context,
              fontSize: 14,
            ),
          ),
          CustomSizedBox(
            context: context,
            height: 8,
          ),
          Container(
            width: width,
            child: CustomFont(
              text: content,
              maxLines: maxLines,
              color: Colors.black,
              context: context,
              fontSize: 14,
            ),
          )
        ],
      );
    }

    return Scaffold(
      body: Column(
        children: [
          CustomSizedBox(
            context: context,
            height: 64,
          ),
          Container(
            height: deviceSize.height * 1.8 / 3,
            margin: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: CustomColor.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 16,
                    offset: Offset(0, 5), // changes position of shadow
                  ),
                ]),
            child: Column(
              children: [
                CustomSizedBox(
                  context: context,
                  height: 24,
                ),
                _buildRow(
                    buildContentLeft: _buildContent(
                        content: 'Kien Tran',
                        title: 'Name: ',
                        maxLines: 1,
                        isLeft: true),
                    buildContentRight: _buildContent(
                        content: '2.000.000Đ',
                        title: 'Price: ',
                        maxLines: 2,
                        isLeft: false)),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: CustomColor.black[3],
                ),
                CustomSizedBox(
                  context: context,
                  height: 24,
                ),
                _buildRow(
                    buildContentLeft: _buildContent(
                        title: 'Movie: ',
                        content: model.currentRoom.filmName,
                        maxLines: 1,
                        isLeft: true),
                    buildContentRight: _buildContent(
                        content: model.currentRoom.name,
                        title: 'Room: ',
                        maxLines: 2,
                        isLeft: false)),
                _buildRow(
                    buildContentLeft: _buildContent(
                        title: 'Cinema: ',
                        content: model.currentRoom.theatreName,
                        maxLines: 1,
                        isLeft: true),
                    buildContentRight: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomFont(
                          text: 'Seats',
                          color: CustomColor.black[2],
                          context: context,
                          fontSize: 14,
                        ),
                        CustomSizedBox(
                          context: context,
                          height: 8,
                        ),
                        _buildSelectedSeat(
                            context: context,
                            deviceSize: deviceSize,
                            selectedSeat: model.selectedSeat)
                      ],
                    )),
                _buildRow(
                    buildContentLeft: _buildContent(
                        title: 'Date: ',
                        isLeft: true,
                        maxLines: 1,
                        content: model.currentSchedule.date),
                    buildContentRight: _buildContent(
                        title: 'Time: ',
                        content: model.currentSchedule.time,
                        isLeft: false,
                        maxLines: 1)),
                CustomSizedBox(
                  context: context,
                  height: 16,
                ),
                CustomFont(
                  text: 'Thank you!',
                  color: CustomColor.yellow,
                  context: context,
                  fontSize: 14,
                  textAlign: TextAlign.center,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
