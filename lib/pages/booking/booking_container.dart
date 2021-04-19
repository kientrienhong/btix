import 'package:btix/common/custom_app_bar.dart';
import 'package:btix/common/custom_color.dart';
import 'package:btix/common/custom_font.dart';
import 'package:btix/common/custom_sized_box.dart';
import 'package:btix/models/seat.dart';
import 'package:btix/models/user.dart';
import 'package:btix/pages/bill/bill_page.dart';
import 'package:btix/pages/booking/booking_bloc.dart';
import 'package:btix/pages/booking/booking_model.dart';
import 'package:btix/pages/loading/loading_page.dart';
import 'package:btix/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BookingContainer extends StatelessWidget {
  static BookingBloc bloc;
  static Widget create({BuildContext context}) {
    bloc = Provider.of<BookingBloc>(context, listen: false);
    bloc.updateWith();

    return BookingContainer();
  }

  Widget _buidGridView(BookingModel _model) {
    return GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 10, crossAxisSpacing: 2, mainAxisSpacing: 4),
        itemCount: _model.currentRoom.seatList.length - 80,
        itemBuilder: (context, index) {
          Color color;
          Color colorBorder;
          Seat e = _model.currentRoom.seatList[index];
          if (e.statusSeat == StatusSeat.available) {
            color = Colors.transparent;
          } else if (e.statusSeat == StatusSeat.selected) {
            color = CustomColor.yellow;
          } else {
            color = CustomColor.black[2];
          }

          colorBorder = color;

          if (color == Colors.transparent) {
            colorBorder = CustomColor.black[2];
          }

          return GestureDetector(
            onTap: () =>
                bloc.selectedSeat(seatId: e.id, statusSeat: e.statusSeat),
            child: Container(
              decoration: BoxDecoration(
                  color: color,
                  border: Border.all(color: colorBorder),
                  borderRadius: BorderRadius.circular(4)),
            ),
          );
        });
  }

  Widget _buildDate(BookingModel _model, Size deviceSize) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      primary: false,
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(vertical: 8),
      scrollDirection: Axis.horizontal,
      itemCount: _model.listDate.length,
      itemBuilder: (context, index) {
        Color colorBackGround;
        Color colorWeekDay;
        Color colorDay;
        if (_model.currentSchedule.date == _model.listDate[index]) {
          colorBackGround = CustomColor.yellow;
          colorWeekDay = CustomColor.white;
          colorDay = CustomColor.white;
        } else {
          colorBackGround = CustomColor.white;
          colorWeekDay = CustomColor.black[1];
          colorDay = Colors.black;
        }
        List<String> splitedDate = _model.listDate[index].split(' ');
        return GestureDetector(
          onTap: () => bloc.changeDate(index),
          child: Container(
              height: deviceSize.height / 12,
              width: deviceSize.height / 10,
              margin: const EdgeInsets.only(left: 12, right: 12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: colorBackGround),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomFont(
                      text: splitedDate[1].toUpperCase(),
                      color: colorWeekDay,
                      context: context,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                  CustomSizedBox(
                    context: context,
                    height: 7,
                  ),
                  CustomFont(
                    fontWeight: FontWeight.bold,
                    text: splitedDate[0],
                    color: colorDay,
                    context: context,
                    fontSize: 20,
                  )
                ],
              )),
        );
      },
    );
  }

  Widget _buildTime(
      BookingModel _model, Size deviceSize, BuildContext context) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        primary: false,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: _model.listTime.length,
        itemBuilder: (ctx, index) {
          Color colorBackGround;
          Color colorTime;
          if (_model.currentSchedule.time == _model.listTime[index]['time']) {
            colorBackGround = CustomColor.yellow;
            colorTime = CustomColor.white;
          } else {
            colorBackGround = Colors.transparent;
            colorTime = Colors.black;
          }
          return GestureDetector(
            onTap: () => bloc.changeTime(_model.listTime[index]['scheduleId']),
            child: Container(
              margin: const EdgeInsets.only(right: 24),
              width: deviceSize.width / 6,
              height: deviceSize.height / 6,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: colorBackGround),
              child: Center(
                child: CustomFont(
                  context: context,
                  fontSize: 14,
                  text: _model.listTime[index]['time'],
                  color: colorTime,
                ),
              ),
            ),
          );
        });
  }

  Widget _buildExplan(BuildContext context, Color color, String text) {
    return Row(
      children: [
        Container(
          height: 16,
          width: 16,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(8)),
        ),
        CustomSizedBox(
          context: context,
          width: 8,
        ),
        CustomFont(
          text: text,
          color: Colors.black,
          context: context,
          fontSize: 14,
        ),
      ],
    );
  }

  Widget _buildSelectedSeat(
      List<Seat> selectedSeat, Size deviceSize, BuildContext context) {
    String name = '';
    selectedSeat.forEach((element) {
      name += element.name + ',';
    });
    if (name.length != 0) name = name.substring(0, name.length - 1);
    return Container(
      width: deviceSize.width / 5,
      child: CustomFont(
        text: name,
        color: Colors.black,
        fontSize: 20,
        context: context,
        textOverflow: TextOverflow.ellipsis,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final oCcy = new NumberFormat("#,##0", "en_US");
    AuthBase auth = Provider.of<AuthBase>(context, listen: false);
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: CustomColor.white,
      body: StreamBuilder(
        stream: bloc.stream,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            BookingModel _model = snapshot.data;
            return SingleChildScrollView(
              child: Container(
                height: deviceSize.height * 1.25,
                child: Stack(children: [
                  Column(
                    children: [
                      CustomAppBar(false),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Row(children: [
                            CustomSizedBox(
                              context: context,
                              width: 24,
                            ),
                            Container(
                                decoration: BoxDecoration(
                                    color: CustomColor.white,
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.1),
                                        spreadRadius: 1,
                                        blurRadius: 8,
                                        offset: Offset(
                                            0, 5), // changes position of shadow
                                      ),
                                    ]),
                                height: deviceSize.height / 8,
                                child: _buildDate(_model, deviceSize)),
                            CustomSizedBox(
                              context: context,
                              width: 24,
                            ),
                          ]),
                        ),
                      ),
                      CustomSizedBox(
                        context: context,
                        height: 29,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(children: [
                          CustomSizedBox(
                            context: context,
                            width: 40,
                          ),
                          Container(
                              height: deviceSize.height / 25,
                              child: _buildTime(_model, deviceSize, context)),
                          CustomSizedBox(
                            context: context,
                            width: 24,
                          ),
                        ]),
                      ),
                      CustomSizedBox(
                        context: context,
                        height: 29,
                      ),
                      Container(
                        height: deviceSize.height / 1.95,
                        child: Stack(
                          children: [
                            Positioned(
                                top: 0,
                                left: 0,
                                child: Container(
                                  height: deviceSize.height / 5,
                                  width: deviceSize.width,
                                  child: Image.asset(
                                    'assets/images/screen.png',
                                    fit: BoxFit.cover,
                                  ),
                                )),
                            _model.isLoading == true
                                ? Positioned(
                                    top: deviceSize.height / 5,
                                    left: deviceSize.width / 2.5,
                                    child: SizedBox(
                                      width: deviceSize.width / 4,
                                      height: deviceSize.width / 4,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            new AlwaysStoppedAnimation<Color>(
                                                CustomColor.yellow),
                                      ),
                                    ),
                                  )
                                : Positioned(
                                    child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24),
                                    child: _buidGridView(_model),
                                  )),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildExplan(
                              context, CustomColor.black[2], 'Reversed'),
                          _buildExplan(context, CustomColor.yellow, 'Selected'),
                          Row(children: [
                            Container(
                              height: 16,
                              width: 16,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: CustomColor.black[2]),
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            CustomSizedBox(
                              context: context,
                              width: 8,
                            ),
                            CustomFont(
                              text: 'Available',
                              color: Colors.black,
                              context: context,
                              fontSize: 14,
                            ),
                          ]),
                        ],
                      ),
                    ],
                  ),
                  Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Container(
                        width: deviceSize.width,
                        height: deviceSize.height / 4.5,
                        decoration: BoxDecoration(
                            color: CustomColor.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 15,
                                color: Colors.grey,
                                offset: Offset(0, 5),
                              ),
                            ],
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(24),
                                topRight: Radius.circular(24))),
                        child: Container(
                          width: deviceSize.width,
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            children: [
                              CustomSizedBox(
                                context: context,
                                height: 16,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CustomFont(
                                      text: 'Date',
                                      color: CustomColor.black[0],
                                      context: context,
                                      fontSize: 14),
                                  CustomSizedBox(
                                    context: context,
                                    width: 120,
                                  ),
                                  CustomFont(
                                      text: 'Time',
                                      color: CustomColor.black[0],
                                      context: context,
                                      fontSize: 14),
                                  CustomSizedBox(
                                    context: context,
                                    width: 88,
                                  ),
                                  CustomFont(
                                      text: 'Seat',
                                      color: CustomColor.black[0],
                                      context: context,
                                      fontSize: 14),
                                ],
                              ),
                              CustomSizedBox(
                                context: context,
                                height: 16,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: deviceSize.width / 3.5,
                                    child: CustomFont(
                                        text: _model.currentSchedule.date,
                                        color: Colors.black,
                                        context: context,
                                        fontSize: 20),
                                  ),
                                  CustomSizedBox(
                                    context: context,
                                    width: 32,
                                  ),
                                  Container(
                                    width: deviceSize.width / 3.5,
                                    child: CustomFont(
                                        text: _model.currentSchedule.time,
                                        color: Colors.black,
                                        context: context,
                                        fontSize: 20),
                                  ),
                                  CustomSizedBox(
                                    context: context,
                                    width: 8,
                                  ),
                                  _buildSelectedSeat(
                                      _model.selectedSeat, deviceSize, context)
                                ],
                              ),
                              CustomSizedBox(
                                context: context,
                                height: 14,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomFont(
                                    text: oCcy.format(_model.selectedSeat
                                            .fold(
                                                0,
                                                (previousValue, element) =>
                                                    previousValue +
                                                    element.price)
                                            .toInt()) +
                                        'đ',
                                    color: Colors.black,
                                    context: context,
                                    fontSize: 30,
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      width:
                                          deviceSize.width / 3.409090909090909,
                                      height: deviceSize.height / 17,
                                      color: CustomColor.yellow,
                                      child: Center(
                                        child: InkWell(
                                          onTap: _model.selectedSeat.length > 0
                                              ? () async {
                                                  await bloc.checkOut(
                                                      auth.user.username,
                                                      auth.user.accessToken);
                                                  await auth
                                                      .updateBillForAccount();
                                                  Navigator.of(context)
                                                      .pushReplacement(
                                                          PageRouteBuilder(
                                                    pageBuilder: (context,
                                                            animation,
                                                            secondaryAnimation) =>
                                                        BillPage(
                                                      model: _model,
                                                    ),
                                                    transitionDuration:
                                                        Duration(
                                                            milliseconds: 750),
                                                  ));
                                                }
                                              : null,
                                          child: CustomFont(
                                            text: 'book now',
                                            context: context,
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )),
                ]),
              ),
            );
          }
          return LoadingPage();
        },
      ),
    );
  }
}
