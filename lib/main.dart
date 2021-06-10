import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'pages/main.dart';
import 'routers/router.dart';
import 'package:common/generated/l10n.dart';
import 'package:provider/provider.dart';
import 'package:common/provider/cart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    }
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => Cart())],
      child: ScreenUtilInit(
        //屏幕适配设计稿尺寸
        designSize: Size(360, 720),
        builder: () => MaterialApp(
          title: 'JdShop',
          //国际化
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            S.delegate
          ],
          supportedLocales:
              S.delegate.supportedLocales, //如果不支持本地化就会按照S.load加载的语言去显示
          debugShowCheckedModeBanner: false,
          theme:
              ThemeData(primarySwatch: Colors.red, primaryColor: Colors.white),
          home: MainPage(),
          //路由
          initialRoute: '/', //不要和MainPage路由配置成一样不然会加载2次
          onGenerateRoute: RouteGenerator.generateRoute,
        ),
      ),
    );
  }
}
