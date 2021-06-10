import 'package:common/constants/config.dart';
import 'package:common/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:user/pages/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AppHelper.isModuleRun = true;
    return ScreenUtilInit(
        designSize: Size(360, 720),
        builder: () => MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                // This is the theme of your application.
                //
                // Try running your application with "flutter run". You'll see the
                // application has a blue toolbar. Then, without quitting the app, try
                // changing the primarySwatch below to Colors.green and then invoke
                // "hot reload" (press "r" in the console where you ran "flutter run",
                // or press Run > Flutter Hot Reload in a Flutter IDE). Notice that the
                // counter didn't reset back to zero; the application is not restarted.
                primaryColor: Colors.white,
              ),
              debugShowCheckedModeBanner: false,
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                S.delegate
              ],
              supportedLocales: S.delegate.supportedLocales,
              home: Scaffold(
                body: LoginPage(),
              ),
            ));
  }
}
