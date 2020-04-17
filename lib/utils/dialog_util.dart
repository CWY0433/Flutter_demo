/**
 * dialog 工具类
 */
import 'package:flutter/material.dart';


///显示操作结果的提示框
void showResult(BuildContext context, String title, String message) {
  showDialog<Null>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return new AlertDialog(
        title: new Text(title),
        content: new SingleChildScrollView(
          child: new ListBody(
            children: <Widget>[
              new Text(message),
            ],
          ),
        ),
        actions: <Widget>[
          new FlatButton(
            child: new Text('确定'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

///显示操作成功的提示框
void showSuccess(BuildContext context,String message){
  showResult(context, "成功", message);
}

///显示操作失败的提示框
void showError(BuildContext context,String message){
  showResult(context, "失败", message);
}

///显示已经是最新版本的提示框
void showIsNew(BuildContext context,String message){
  showResult(context, "检查更新", message);
}