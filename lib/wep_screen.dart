import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:souqelgom3awepview/nointernetpage.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:souqelgom3awepview/utils.dart';
import 'package:wifi_configuration_2/wifi_configuration_2.dart';
WifiConfiguration wifiConfiguration = WifiConfiguration();

class WebViewExample extends StatefulWidget {
  @override
  WebViewExampleState createState() => WebViewExampleState();
}

class WebViewExampleState extends State<WebViewExample> {
  bool injectCookies = false;
  bool _isLoadingPage = true;

  // final String url;
  // final apiProvider = ApiProvider();
  // final config = Config();

  bool testInternet = true;
  var hasInternet = true;
  var result = ConnectivityResult.none;

  late WebViewController controller;
  late StreamSubscription subscription;

  @override
  void initState() {
    super.initState();
    wifiConfiguration = WifiConfiguration();
    subscription =
        Connectivity().onConnectivityChanged.listen(showConnectivitySnackBar);
    //print('what is statussssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss' + subscription.toString());
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    //checkConnection();
    //_seCookies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime timeBackPressed = DateTime.now();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(10.0),
        child: AppBar(
          elevation: 0.0,
          // actions: [
          //   IconButton(onPressed:() async{
          //     if(await controller.canGoBack()){
          //       print('Go BAckkkkccccccccccccccccck');
          //       controller.goBack();
          //     }
          //   } , icon: Icon(Icons.arrow_back,color: Colors.black,))
          // ],
          //title:Text('سوق الجمعة',style: TextStyle(color: Colors.amber,fontSize: 30.sp),),
          //centerTitle: true,
          backgroundColor: Colors.white,
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          final diffrence = DateTime.now().difference(timeBackPressed);
          final isExitWarning = diffrence >= Duration(seconds: 2);
          timeBackPressed = DateTime.now();

          // if(await controller.canGoBack()){
          //   print('Go BAckkkkccccccccccccccccck');
          //   controller.goBack();
          // }


          if(isExitWarning){
            if(await controller.canGoBack()){
              print('Go BAckkkkccccccccccccccccck');
              controller.goBack();
            }
            //final message = 'اضغط مرة اخر لتاكيد الخروج';
            //Fluttertoast.showToast(msg: message, fontSize: 18);
            return false;
          }else{
            return true;
          }

          return true;

        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Stack(
              children:[
                _isLoadingPage ? WebView(
                  initialUrl: 'https://souqelgomaa.com/',
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (controller) {
                    this.controller = controller;
                  },
                  onPageStarted: (value){
                    _isLoadingPage = true;
                  },
                  onPageFinished: (value) async {
                    //_wvController.evaluateJavascript("document.getElementsByClassName('close')[0].style.display='none';");
                    //_wvController.evaluateJavascript("document.getElementsByTagName('header')[0].style.display='none';");
                    //_wvController.evaluateJavascript("document.getElementsByTagName('footer')[0].style.display='none';");
                    setState(() {
                      _isLoadingPage = false;
                    });
                  },
                ): Container(),
                _isLoadingPage
                    ? Container(
                  color: Colors.white,
                  alignment: FractionalOffset.center,
                  child: CircularProgressIndicator(color: Color(0xffc7903d),),
                )
                    :  WebView(
                  initialUrl: 'https://souqelgomaa.com/',
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (controller) {
                    this.controller = controller;
                  },
                ),
              ]
          ),

        ),
      ),
    );
  }

  void showConnectivitySnackBar(ConnectivityResult result) {
    var hasInternet = result != ConnectivityResult.none;
    //var hasInternet2 = result != ConnectivityResult.wifi;
    //var hasInternet3 = result != ConnectivityResult.mobile;
    //var hasInternet4 = result != ConnectivityResult.values;

    //print('internetttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt '+hasInternet.toString());
    //print('internetttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt '+hasInternet2.toString());
    //print('internetttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt '+hasInternet3.toString());
    //print('internetttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt '+hasInternet3.toString());
    //print('internetttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt '+hasInternet4.toString());
    //print('internetttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt '+result.toString());

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
      Utils.NoInterNet2(context, message, color);
    // }
    // if (hasInternet2 == false) {
    //   Utils.NoInterNet(context, message, color);
    // } else {
    //   Utils.NoInterNet2(context, message, color);
    // }
    // if (hasInternet3 == false) {
    //   Utils.NoInterNet(context, message, color);
    // } else {
    //   Utils.NoInterNet2(context, message, color);
    // }
    // if (hasInternet4 == false) {
    //   Utils.NoInterNet(context, message, color);
    // } else {
    //   Utils.NoInterNet2(context, message, color);
    // }
    // if (result != ConnectivityResult.mobile) {
    //   Utils.NoInterNet(context, message, color);
    // } else {
    //   Utils.NoInterNet2(context, message, color);
    }
  }

  // void checkConnection() async {
  //   wifiConfiguration.isWifiEnabled().then((value) {
  //     //print('Is wifi enabled: ${value.toString()}');
  //     if(value == false){
  //       Navigator.of(context).pushReplacement(MaterialPageRoute(
  //           builder: (BuildContext context) => NoInterNetPage()));
  //     }
  //   });
  //
  //   wifiConfiguration.checkConnection().then((value) {
  //     //print('Value: ${value.toString()}');
  //     if(value == false){
  //       Navigator.of(context).pushReplacement(MaterialPageRoute(
  //           builder: (BuildContext context) => NoInterNetPage()));
  //     }
  //   });
  //
  //   WifiConnectionObject wifiConnectionObject =
  //   await wifiConfiguration.connectedToWifi();
  //   if (wifiConnectionObject == null) {
  //     //print('Done List');
  //     Navigator.of(context).pushReplacement(MaterialPageRoute(
  //         builder: (BuildContext context) => NoInterNetPage()));
  //   }
  // }
}

