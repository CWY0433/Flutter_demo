import 'package:flutter/material.dart';

class Account extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SizedBox(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.keyboard),
              title: Text("收入"),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: ()=>Navigator.pushNamed(context, "income_pageRoute"),
            ),
            ListTile(
              leading: Icon(Icons.keyboard),
              title: Text("支出"),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
          ],
        ),
      ),
    );
  }
}