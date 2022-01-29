import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:souqelgom3awepview/constants.dart';
import 'package:souqelgom3awepview/default_button.dart';
import 'package:souqelgom3awepview/size_config.dart';
import 'package:souqelgom3awepview/wep_screen.dart';

// This is the best practice
import '../components/splash_content.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

 late bool key;

 @override
 void initState() {
   super.initState();
   key = false;
   //read();
   save(key);
 }

  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "مرحبا بكم في سوق الجمعة تسوق معنا",
      "image": "assets/images/splash_1.png"
    },
    {
      "text":
          "نحن نساعد العملاء علي التواصل معنا بسهولة",
      "image": "assets/images/splash_2.png"
    },
    {
      "text": "تسوق معنا من خلال بيتك",
      "image": "assets/images/splash_3.png"
    },
  ];

 @override
 void dispose() {
   super.dispose();
 }

 @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"],
                  text: splashData[index]['text'],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (index) => buildDot(index: index),
                      ),
                    ),
                    Spacer(flex: 3),
                    DefaultButton(
                      text: "ابدأ الشراء",
                      press: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) => WebViewExample()));
                        setState(() {
                          key = true;
                          save(key);
                        });
                      },
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5.w),
      height: 6.h,
      width: currentPage == index ? 20.w : 6.w,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : Colors.amber,
        borderRadius: BorderRadius.circular(3.r),
      ),
    );
  }

  save(bool keyValue) async{
    final prefs = await SharedPreferences.getInstance();
    final key = 'login';
    final value = keyValue;
    prefs.setBool(key, value);
    //print('Saveeee '+value.toString());
  }
}
