import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///K:/GithubCode/CWY_Demo/TTL/flutter_cwy/lib/page/account.dart';
import 'file:///K:/GithubCode/CWY_Demo/TTL/flutter_cwy/lib/page/chart.dart';
import 'file:///K:/GithubCode/CWY_Demo/TTL/flutter_cwy/lib/page/detail.dart';
import 'file:///K:/GithubCode/CWY_Demo/TTL/flutter_cwy/lib/page/find.dart';
import 'file:///K:/GithubCode/CWY_Demo/TTL/flutter_cwy/lib/page/setting.dart';
import 'package:flutter_cwy/page/income.dart';

class BottomNavigationBarWidget extends StatefulWidget{
  @override
  _BottomNavigationWidgetState createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationBarWidget> {
  final _bottomNaivgationColor = Colors.grey;// 组件未选中的颜色
  final _bottomNaivgationColor_press = Colors.blue;// 组件选中后的颜色
  int _currentIndex = 2; // 打开应用默认在记账页面
  List<Widget> list = List();
  @override
  void initState() {
    list
    ..add(Find())
    ..add(Detail())
    ..add(InComePage())
    ..add(Chart())
    ..add(Setting());
    // TODO: implement initState
    super.initState();
  }

  MaterialColor _choiceColor(int num){
    return _currentIndex == num ?_bottomNaivgationColor_press : _bottomNaivgationColor;
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: list[_currentIndex],// 少了这句就没有内容？
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: _choiceColor(0),

            ),
            title: Text(
              "查询",
              style: TextStyle(color: _choiceColor(0)),
            )
          ),

          BottomNavigationBarItem(
            icon: Icon(
              Icons.assessment,
              color: _choiceColor(1),
            ),
            title: Text(
              "报表",
              style: TextStyle(color: _choiceColor(1)),
            )
          ),


          BottomNavigationBarItem(
            icon: Icon(
              Icons.add,
              color: _choiceColor(2),
            ),
            title: Text(
              "记账",
              style: TextStyle(color: _choiceColor(2)),
            ),
          ),

          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_balance_wallet,
              color: _choiceColor(3),
            ),
            title: Text(
              "账户",
              style: TextStyle(color: _choiceColor(3)),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              color: _choiceColor(4),
            ),
            title: Text(
              "设置",
              style: TextStyle(color: _choiceColor(4)),
            ),
          ),
        ],
        type: BottomNavigationBarType.fixed,// 导航栏类型
        currentIndex: _currentIndex,
        onTap: (int index){
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}