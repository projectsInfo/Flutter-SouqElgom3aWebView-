import 'dart:async';
import 'dart:math';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:souqelgom3awepview/slider/sliderScreen.dart';
import 'package:souqelgom3awepview/utils.dart';
import 'package:souqelgom3awepview/wep_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  late StreamSubscription subscription;
  //late bool cool;
  //var result = ConnectivityResult.none;

  @override
  void initState() {
    super.initState();

    //read();

      subscription =
          Connectivity().onConnectivityChanged.listen(showConnectivitySnackBar);

    // controller = AnimationController(vsync:  this,
    // duration: Duration(microseconds: 0),);

    // controller.addStatusListener((status) async{
    //   if(status == AnimationStatus.completed){
    //     await Future.delayed(Duration(seconds: 0));
    //     controller.reset();
    //   }
    // });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final degrees = 90;
    // final angel = degrees * pi / 180;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: AnimatedSplashScreen(
            splashIconSize: 250,
            splash: 'assets/images/logo0000 4-Recovered-Recovered.png',
            nextScreen: FutureBuilder<bool>(
              future: read(),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (snapshot.data == false) {
                  return SliderScreen();
                } else {
                  return WebViewExample();
                }
              },
            ),
            splashTransition: SplashTransition.scaleTransition,
            duration: 5000,
            animationDuration: Duration(seconds: 2),
            //pageTransitionType: PageTransitionType.scale,
          )
        ),
        // Load an animation and its images from a zip file
      ),
    );
  }

  // void setRotation(int degrees) {
  //   //print('degree'+degrees.toString());
  //   //final angel = degrees * pi / 360;
  //   final angel = degrees * pi / 180;
  //   //print('angel'+angel.toString());
  //    animation = Tween<double>(begin: 0, end: angel).animate(controller);
  // }

  // void showConnectivitySnackBar(ConnectivityResult result) {
  //   var hasInternet = result != ConnectivityResult.none;
  //
  //   final message = hasInternet
  //   //? 'You have again ${result.toString()}'
  //       ? 'تم استعادة الاتصال بالانترنت'
  //       : 'ليس لديك اتصال بالانترنت';
  //   final color = hasInternet ? Colors.green : Colors.red;
  //   //Utils.showTopSnackBar(context, message, color);
  //   if (result == ConnectivityResult.none){
  //     Utils.NoInterNet(context, message, color);
  //   }
  // }


  void showConnectivitySnackBar(ConnectivityResult result) {
    var hasInternet = result != ConnectivityResult.none;

    final message = hasInternet
    //? 'You have again ${result.toString()}'
        ? 'تم استعادة الاتصال بالانترنت'
        : 'ليس لديك اتصال بالانترنت';
    final color = hasInternet ? Colors.green : Colors.red;
    //Utils.showTopSnackBar(context, message, color);
    // if ((hasInternet == false) || (hasInternet2 == false) || (hasInternet3 == false) || (hasInternet4 == false)) {
    if (hasInternet == false) {
      Utils.NoInterNet(context, message, color);
    } else {
      Utils.NoInterNetSplash(context, message, color);
    }
  }


  Future<bool>read() async{
    final prefs = await SharedPreferences.getInstance();
    final key = 'login';
    final value = prefs.get(key) ?? 0;
    //print('reaaaaaaaad '+value.toString());
    return value == true ? true : false;
  }

}



//Lottie.network(
//'https://raw.githubusercontent.com/xvrh/lottie-flutter/master/example/assets/Mobilo/A.json'),
