// @dart=2.9
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:souqelgom3awepview/splash_screen.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:souqelgom3awepview/translations/codegen_loader.g.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();


  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(EasyLocalization(
    path: 'assets/translations',
      supportedLocales: [
        Locale('en'),
        Locale('ar'),
      ],
      fallbackLocale: Locale('en'),
      assetLoader: CodegenLoader(),
      child: MyApp())
  );
}
class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder:() => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'سوق الجمعة',
        theme: ThemeData(
          //fontFamily: 'Signatra',
          primarySwatch: Colors.blue,
        ),
        //home:  SplashScreen(),

        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        locale: context.locale,
        localeResolutionCallback: (local,supportedLocales){
      for(var supportedLocale in supportedLocales){
              if (supportedLocale.languageCode == local?.languageCode &&
              supportedLocale.countryCode == local?.countryCode) {
                //mySharedPreferences.setString("lang",currentLang.languageCode) ;
                return supportedLocale;
              }
            }
      return supportedLocales.first;
        },
        home: SplashScreen(),
      ),
      designSize: const Size(360, 640),
    );
  }
}

