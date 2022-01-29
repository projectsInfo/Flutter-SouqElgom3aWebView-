import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:souqelgom3awepview/utils.dart';
import 'package:souqelgom3awepview/wep_screen.dart';


class NoInterNetPage extends StatefulWidget {
  //const NoInterNetPage({Key? key}) : super(key: key);
  @override
  _NoInterNetPageState createState() => _NoInterNetPageState();
}

class _NoInterNetPageState extends State<NoInterNetPage> {
  WebViewExample webViewExample = new WebViewExample();
  late StreamSubscription subscription;
  @override
  void initState() {
    super.initState();
    subscription =
        Connectivity().onConnectivityChanged.listen(showConnectivitySnackBar);
    // Enable virtual display.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   actions: [
      //     IconButton(
      //       onPressed: () async{
      //         await context.setLocale(Locale('ar'));
      //       },
      //       icon: Icon(Icons.arrow_back),
      //     ),
      //     IconButton(
      //       onPressed: () async{
      //         await context.setLocale(Locale('en'));
      //       },
      //       icon: Icon(Icons.favorite),
      //     )
      //   ],
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Container(
              alignment: Alignment.center,
              height: 100.h,
              width: 300.w,
              //child: Text('لايوجد اتصال بالانترنت', style: TextStyle(color: Colors.white),),
              child: Text('لايوجد اتصال بالانترنت', style: TextStyle(color: Colors.amber,fontSize: 20.sp),),
              //child: Text(LocaleKeys.netConnection.tr(), style: TextStyle(color: Colors.amber,fontSize: 20),),
              decoration: BoxDecoration(
                color: Color(0xff063999),
                borderRadius: BorderRadius.circular(15.r),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20.h)),
            Image(image: AssetImage('assets/images/logo0000 4-Recovered-Recovered.png',),width: 150.w,height: 150.h,),
          ]
        ),
      ),
    );
  }

  void showConnectivitySnackBar(ConnectivityResult result) {
    var hasInternet = result != ConnectivityResult.none;

    final message = hasInternet
    //? 'You have again ${result.toString()}'
        ? 'تم استعادة الاتصال بالانترنت'
        : 'ليس لديك اتصال بالانترنت';
    final color = hasInternet ? Colors.green : Colors.red;
    //Utils.showTopSnackBar(context, message, color);
    if (result != ConnectivityResult.none){
      Utils.NoInterNet2(context, message, color);
    }


  }
}
