import 'package:btix/common/custom_app_bar.dart';
import 'package:btix/common/custom_color.dart';
import 'package:btix/common/custom_font.dart';
import 'package:btix/common/custom_sized_box.dart';
import 'package:btix/pages/booking/booking_page.dart';
import 'package:btix/pages/loading/loading_page.dart';
import 'package:btix/pages/theatre/theatre_bloc.dart';
import 'package:btix/pages/theatre/theatre_brand_widget.dart';
import 'package:btix/pages/theatre/theatre_model.dart';
import 'package:btix/pages/theatre/theatre_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TheatreContainer extends StatelessWidget {
  List<Widget> mapDataToWidget(
      TheatreModel model, Size deviceSize, TheatreBloc bloc) {
    return model.list
        .map((e) => GestureDetector(
              onTap: () => bloc.tapTheatreBrand(theatreBrand: e),
              child: TheatreBrandWidget(
                brand: e,
                deviceSize: deviceSize,
              ),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    TheatreBloc bloc = Provider.of<TheatreBloc>(context, listen: false);
    return Scaffold(
      appBar: CustomAppBar(isHome: false),
      body: StreamBuilder(
          stream: bloc.stream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              final model = snapshot.data;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomSizedBox(
                    context: context,
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: CustomFont(
                      text: 'Please choose theatre',
                      color: Colors.black,
                      context: context,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CustomSizedBox(
                    context: context,
                    height: 32,
                  ),
                  SizedBox(
                    height: deviceSize.height / 6.8,
                    child: ListView(
                      padding: const EdgeInsets.only(left: 16, bottom: 16),
                      scrollDirection: Axis.horizontal,
                      children: mapDataToWidget(model, deviceSize, bloc),
                    ),
                  ),
                  CustomSizedBox(
                    context: context,
                    height: 32,
                  ),
                  if (model.listTheatre.length == 0)
                    Padding(
                      padding: EdgeInsets.only(top: deviceSize.height / 10),
                      child: Center(
                        child: CustomFont(
                          text: 'Nothing to show',
                          color: CustomColor.black[1],
                          context: context,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      BookingPage.create(
                                          context, model.listTheatre[index]),
                              transitionDuration: Duration(milliseconds: 750),
                            ));
                          },
                          child: TheatreWidget(
                            deviceSize: deviceSize,
                            theatre: model.listTheatre[index],
                          ),
                        );
                      },
                      itemCount: model.listTheatre.length,
                    ),
                  ),
                ],
              );
            }
            return LoadingPage();
          }),
    );
  }
}
