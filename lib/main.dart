import 'package:flutter/material.dart';
import 'package:flutter_cwy/page/chart.dart';
import 'package:flutter_cwy/page/forget_password_page.dart';
import 'package:flutter_cwy/page/income.dart';
import 'package:flutter_cwy/page/login_page.dart';
import 'package:flutter_cwy/page/question_page.dart';
import 'package:flutter_cwy/page/register_page.dart';
import 'package:flutter_cwy/page/setting.dart';
import 'package:flutter_cwy/page/user_page.dart';
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
        'loginRoute': (BuildContext context) => new LoginPage(), // 登录
        'register_pageRoute': (BuildContext context) => new RegisterPage(), // 注册
        'income_pageRoute': (BuildContext context) => new InComePage(), // 收入
        'chart_pageRoute': (BuildContext context) => new Chart(), // 类型
        'forget_password_pageRoute': (BuildContext context) => new ForgetPage(), // 忘记密码
        'user_pageRoute': (BuildContext context) => new UserPage(), // 用户
        'setting_pageRoute': (BuildContext context) => new Setting(), // 用户
        'question_pageRoute': (BuildContext context) => new QuestionPage(), // 问题反馈界面
      },
    );
  }
}






