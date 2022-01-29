import 'package:flutter/material.dart';
import 'package:souqelgom3awepview/nointernetpage.dart';
import 'package:souqelgom3awepview/splash_screen.dart';
import 'package:souqelgom3awepview/wep_screen.dart';

class Utils {

  static void NoInterNet(
      BuildContext context,
      String message,
      Color color,
      ) =>
  Navigator.of(context).pushReplacement(MaterialPageRoute(
  builder: (BuildContext context) => NoInterNetPage()));

  static void NoInterNet2(
      BuildContext context,
      String message,
      Color color,
      ) =>
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => WebViewExample()));

  static void NoInterNetSplash(
      BuildContext context,
      String message,
      Color color,
      ) =>
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => SplashScreen()));


}