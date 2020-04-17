import 'package:flutter/material.dart';
import 'package:flutter_cwy/page/chart.dart';
import 'package:flutter_cwy/page/income.dart';
import 'package:flutter_cwy/page/login_page.dart';
import 'package:flutter_cwy/page/register_page.dart';
import 'BottomNaivgationWidget.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '我的Demo',
      theme: ThemeData.light(),
      home: BottomNavigationBarWidget(),
      debugShowCheckedModeBanner: false,// 去除debug标志
      routes: {
        'loginRoute': (BuildContext context) => new LoginPage(),
        'register_pageRoute': (BuildContext context) => new RegisterPage(),
        'income_pageRoute': (BuildContext context) => new InComePage(),
        'chart_pageRoute': (BuildContext context) => new Chart(),
      },
    );
  }
}






