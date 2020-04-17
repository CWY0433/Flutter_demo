import 'package:flutter/material.dart';
import 'package:flutter_cwy/utils/DbUtil.dart';
import 'package:flutter_cwy/utils/dialog_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Setting extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SizedBox(
        child: ListView(

          scrollDirection: Axis.vertical,
          children: <Widget>[
            Container(
              child: ListTile(
                //leading: Icon(Icons.access_time),
                title: Text("登录设置"),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: ()=>click(1,context),
              ),
            ),

            Divider(height: 1.0,color: Colors.blue,),

            Container(
              child: ListTile(
                //leading: Icon(Icons.account_balance_wallet),
                title: Text("备份与还原"),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: ()=>click(2,context),
              ),
            ),

            Divider(height: 1.0,color: Colors.blue,),

            Container(
              child: ListTile(
                //leading: Icon(Icons.blur_circular),
                title: Text("检查更新"),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: ()=>click(3,context),
              ),
            ),

            Divider(height: 1.0,color: Colors.blue,),

            Container(
              child: ListTile(
                //leading: Icon(Icons.blur_circular),
                title: Text("问题反馈"),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: ()=>click(4,context),
              ),
            ),
            Divider(height: 1.0,color: Colors.blue,),
          ],
        ),
      ),
    );
  }

  click(int num,BuildContext context) async {
    switch(num){
      case 1:
        print("登录设置");
        //Navigator.pop(context);
        Navigator.pushNamed(context, "loginRoute");
        break;
      case 2:
        print("备份与还原");
        break;
      case 3:
        print("检查更新");
        break;
      case 4:
        print("问题反馈");
        break;
    }
  }
}