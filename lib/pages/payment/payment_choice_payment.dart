import 'package:btix/common/custom_sized_box.dart';
import 'package:btix/pages/booking/booking_model.dart';
import 'package:flutter/material.dart';
import '../../common/custom_app_bar.dart';
import '../../common/custom_font.dart';
import '../../common/custom_color.dart';
import '../bill/bill_page.dart';

class PaymentChoicePayment extends StatelessWidget {
  final BookingModel model;
  PaymentChoicePayment({this.model});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(false),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CustomFont(
            text: 'Payment method',
            color: Colors.black,
            context: context,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          CustomSizedBox(
            context: context,
            height: 24,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        BillPage(
                      model: model,
                    ),
                    transitionDuration: Duration(milliseconds: 750),
                  ));
                },
                child: Container(
                  width: deviceSize.width / 2.5,
                  height: deviceSize.height / 12,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: CustomColor.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 16,
                          offset: Offset(0, 5), // changes position of shadow
                        ),
                      ]),
                  child: Center(
                      child: CustomFont(
                    text: 'E-Bank',
                    color: Colors.black,
                    context: context,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  )),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        BillPage(
                      model: model,
                    ),
                    transitionDuration: Duration(milliseconds: 750),
                  ));
                },
                child: Container(
                  width: deviceSize.width / 2.5,
                  height: deviceSize.height / 12,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: CustomColor.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 16,
                          offset: Offset(0, 5), // changes position of shadow
                        ),
                      ]),
                  child: Center(child: Image.asset('assets/images/paypal.png')),
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }
}
