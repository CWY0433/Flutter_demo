import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cwy/utils/DbUtil.dart';
import 'package:flutter_cwy/utils/GlobalUtil.dart';
import 'package:flutter_cwy/utils/dialog_util.dart';

class Chart extends StatefulWidget {
  @override
  createState() => new ChartState();

}


enum Action {
  Ok,
  Cancel
}

class ChartState extends State<Chart> {

  // 数据源
  List<String> titleItems = <String>[
    '支付宝', '微信',
    '信用卡', '银行卡',
    'zoom_out_map', 'zoom_out',
    'youtube_searched_for', 'wifi_tethering',
    'wifi_lock', 'widgets',
    'weekend', 'web',
    '图accessible', 'ac_unit',
  ];

  List<String> subTitleItems = <String>[
    '1000', '55',
    '66', '88888',
    'subTitle: zoom_out_map', 'subTitle: zoom_out',
    'subTitle: youtube_searched_for', 'subTitle: wifi_tethering',
    'subTitle: wifi_lock', 'subTitle: widgets',
    'subTitle: weekend', 'subTitle: web',
    'subTitle: accessible', 'subTitle: ac_unit',
  ];
  List items = GlobalUtil.chart_data;
  List itemsmoney = GlobalUtil.chart_money;
  int delindex = 0;
  String delinfo = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> _list = new List();
    for (int i = 0; i < titleItems.length; i++) {
      _list.add(buildListData(context, titleItems[i], subTitleItems[i]));
    }
    // 分割线
    var divideTiles = ListTile.divideTiles(context: context, tiles: _list).toList();

    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: 30.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center, // 中间留空 两边占满
            children: <Widget>[
              RaisedButton(
                child: Text("添加+"),
                onPressed: (){
                  setState(() {
                    print("进入set1");
                    Navigator.pushNamed(context, "add_account_pageRoute");
                  });
                  print("账户--添加按钮");
                },
              ),
              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: (){
                  _getDBaccountData();
                  setState(() {
                    print("刷新");
                  });
                },
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                var item = items[index];
                return GestureDetector(
                    onTap: () {
                      setState(() {
                        print("进入set2");
                        GlobalUtil.Chart_flag = true;
                        GlobalUtil.Chart_name = items[index];
                        GlobalUtil.Chart_money = itemsmoney[index];
                        Navigator.pushNamed(context, "add_account_pageRoute");
                      });
                      print("点击了$index 列表长度");
                      print(item.length);
                      print(items.length);
                    },
                    onLongPress: (){
                      print("长按了$index");
                      delindex = index;
                      delinfo = items[index];
                      _openAlertDialog();
                    },
                    child: ListTile(
                      title: Text(items[index]),
                      subtitle: Text(itemsmoney[index]),
                    )
                );
              },
            ),
          ),
        ],
      ),
    );
  }

/*



*/


  String _choice = 'Nothing';
  Future _openAlertDialog() async {
    final action = await showDialog(
      context: context,
      barrierDismissible: false,//// user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('提示'),
          content: Text('是否删除 $delinfo ?'),
          actions: <Widget>[
            FlatButton(
              child: Text('取消'),
              onPressed: () {
                Navigator.pop(context, Action.Cancel);
              },
            ),
            FlatButton(
              child: Text('确认'),
              onPressed: () {
                _deleteData();
                Navigator.pop(context, Action.Ok);

              },
            ),
          ],
        );
      },
    );

    switch (action) {
      case Action.Ok:
        setState(() {
          items.removeAt(delindex);
          itemsmoney.removeAt(delindex);
          _choice = 'Ok';
        });
        break;
      case Action.Cancel:
        setState(() {
          _choice = 'Cancel';
        });
        break;
      default:
    }
  }

  void _deleteData() async{
    await DbUtil.delete_user_by_account_name(items[delindex]);
  }

  void _getDBaccountData() async{
    if(!(await DbUtil.isTabelExits("account_table"))){
      print("account_table表不存在！！");
      await DbUtil.create_account_table();
    }
    int count = await DbUtil.queryNumByName("account_table");
    print("数据总数是：$count");
    if(count != 0){
      items.clear();
      GlobalUtil.chart_data.clear();
      GlobalUtil.chart_money.clear();
      for(int i = 1;i <= count;i++){
        String _data = await DbUtil.query_by_id_name(i);
        GlobalUtil.chart_data.add(_data);
        String _money = await DbUtil.query_by_id_accountmoney(i);
        GlobalUtil.chart_money.add(_money);
      }
    }
  }



  Widget buildListData(BuildContext context, String titleItem, String subTitleItem) {
    return new ListTile(
      //leading: iconItem,
      title: new Text(
        titleItem,
        style: TextStyle(fontSize: 18),
      ),
      subtitle: new Text(
        "金额:" + subTitleItem,
      ),
      trailing: new Icon(Icons.keyboard_arrow_right),
      onTap: () {
        buildDialog(context);
      },

    );
  }

  void buildDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text(
            'ListViewAlert',
            style: new TextStyle(
              color: Colors.black54,
              fontSize: 18.0,
            ),
          ),
          content: new Text("您选择的item内容为:"),
          //content: new Text('您选择的item内容为:$titleItem'),
        );
      },
    );
  }


}



/*

class Chart extends StatelessWidget{




  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body:Form(
        child: ListView(
          children: <Widget>[
            myAppBar(context), // tjia按钮


          ],
        ),
      ),
    );
  }
}



Row myAppBar(BuildContext context) { // 返回按钮
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RaisedButton(
          child: Text("添加账户"),
          onPressed: (){
            print("添加账户按钮被按下了");
          },
        ),
      ],
    );

}




SizedBox(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.account_balance_wallet),
              title: Text("支付宝"),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
            ListTile(
              leading: Icon(Icons.account_balance_wallet),
              title: Text("微信"),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
            ListTile(
              leading: Icon(Icons.credit_card),
              title: Text("信用卡"),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
            ListTile(
              leading: Icon(Icons.credit_card),
              title: Text("银行卡"),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
          ],
        ),
      ),

*/