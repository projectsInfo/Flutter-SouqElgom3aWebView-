import 'package:flutter/material.dart';
import 'package:souqelgom3awepview/size_config.dart';
import 'package:souqelgom3awepview/slider/components/body.dart';


class SliderScreen extends StatelessWidget {
  static String routeName = "/splash";
  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }
}
