import 'package:barcode_widget/barcode_widget.dart';
import 'package:btix/common/custom_color.dart';
import 'package:btix/common/custom_font.dart';
import 'package:btix/common/custom_raised_button.dart';
import 'package:btix/common/custom_sized_box.dart';
import 'package:btix/models/seat.dart';
import 'package:btix/pages/booking/booking_model.dart';
import 'package:btix/pages/home/home_page.dart';
import 'package:btix/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BillPage extends StatelessWidget {
  final BookingModel model;

  BillPage({this.model});

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

  Widget _buildRow(
      {Widget buildContentLeft,
      Widget buildContentRight,
      @required Size deviceSize}) {
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

  Widget _buildHorizontalDash(Size deviceSize) {
    return Container(
      width: deviceSize.width,
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          height: 2,
          width: deviceSize.width - 96,
          margin: const EdgeInsets.symmetric(horizontal: 24),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                return Container(
                    margin: const EdgeInsets.only(right: 8),
                    height: 1,
                    width: deviceSize.width / 30,
                    color: CustomColor.black[1]);
              }),
        ),
      ]),
    );
  }

  Widget _buildContent(
      {String title,
      String content,
      int maxLines,
      bool isLeft,
      Size deviceSize,
      BuildContext context}) {
    double width = isLeft == true ? deviceSize.width / 2 : deviceSize.width / 5;

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

  String convertDateToCode(String dateBook) {
    dateBook = dateBook.split(RegExp(r"[^\d]")).join('');
    return dateBook;
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    AuthBase auth = Provider.of<AuthBase>(context, listen: false);
    List<dynamic> listBooked = auth.user.historyBooked;
    String dateBook = listBooked[listBooked.length - 1]['ngayDat'];
    final oCcy = new NumberFormat("#,##0", "en_US");

    return Scaffold(
      body: Column(
        children: [
          CustomSizedBox(
            context: context,
            height: 56,
          ),
          Container(
            height: deviceSize.height - deviceSize.height / 5,
            child: Stack(children: [
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
                        deviceSize: deviceSize,
                        buildContentLeft: _buildContent(
                            context: context,
                            deviceSize: deviceSize,
                            content: auth.user.name,
                            title: 'Name: ',
                            maxLines: 1,
                            isLeft: true),
                        buildContentRight: _buildContent(
                            context: context,
                            deviceSize: deviceSize,
                            content: oCcy.format(model.selectedSeat
                                    .fold(
                                        0,
                                        (previousValue, element) =>
                                            previousValue + element.price)
                                    .toInt()) +
                                'đ',
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
                        deviceSize: deviceSize,
                        buildContentLeft: _buildContent(
                            context: context,
                            deviceSize: deviceSize,
                            title: 'Movie: ',
                            content: model.currentRoom.filmName,
                            maxLines: 1,
                            isLeft: true),
                        buildContentRight: _buildContent(
                            context: context,
                            deviceSize: deviceSize,
                            content: model.currentRoom.name,
                            title: 'Room: ',
                            maxLines: 2,
                            isLeft: false)),
                    _buildRow(
                        deviceSize: deviceSize,
                        buildContentLeft: _buildContent(
                            context: context,
                            deviceSize: deviceSize,
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
                        deviceSize: deviceSize,
                        buildContentLeft: _buildContent(
                            context: context,
                            deviceSize: deviceSize,
                            title: 'Date: ',
                            isLeft: true,
                            maxLines: 1,
                            content: model.currentSchedule.date),
                        buildContentRight: _buildContent(
                            context: context,
                            deviceSize: deviceSize,
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
              ),
              Positioned(
                  top: deviceSize.height * 1.8 / 3,
                  child: Container(
                    height: deviceSize.height * 1 / 6,
                    width: deviceSize.width - 48,
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
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    child: BarcodeWidget(
                      margin: const EdgeInsets.all(24),
                      barcode: Barcode.code128(),
                      width: 5,
                      color: CustomColor.black[0],
                      height: 5,
                      style: TextStyle(letterSpacing: 10),
                      data: convertDateToCode(dateBook),
                    ),
                  )),
              Positioned(
                  top: deviceSize.height * 1.8 / 3,
                  child: _buildHorizontalDash(deviceSize)),
            ]),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: deviceSize.width - 48,
              height: deviceSize.height / 12,
              color: CustomColor.yellow,
              child: Center(
                child: InkWell(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => HomePage(),
                      ),
                      (route) => false,
                    );
                  },
                  child: CustomFont(
                    text: 'Done',
                    context: context,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
