import 'package:flutter/material.dart';



/*
 * @Author: Olive^_^Lan
 * @Date: 2019-01-29 15:18:29
 * @Last Modified by: Olive^_^Lan
 * @Last Modified time: 2019-01-29 17:05:32
 */
import 'package:flutter/material.dart';

class Chart extends StatefulWidget {
  @override
  createState() => new ChartState();
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

  @override
  Widget build(BuildContext context) {

    List<Widget> _list = new List();
    for (int i = 0; i < titleItems.length; i++) {
      _list.add(buildListData(context, titleItems[i], subTitleItems[i]));
    }
    // 分割线
    var divideTiles = ListTile.divideTiles(context: context, tiles: _list).toList();

    return Scaffold(
      body: Scrollbar(
        child: ListView.separated(
            itemBuilder: (context, item) {
              return buildListData(context, titleItems[item], subTitleItems[item]);
            },
            separatorBuilder: (BuildContext context, int index) => new Divider(),
            itemCount: titleItems.length
        ),
      ),
    );
  }

/*



*/


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