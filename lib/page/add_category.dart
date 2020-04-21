/**
 * AddCategory page
 */
import 'package:flutter/material.dart';
import 'package:flutter_cwy/utils/DbUtil.dart';
import 'package:flutter_cwy/utils/GlobalUtil.dart';
import 'package:flutter_cwy/utils/dialog_util.dart';
import 'package:fluttertoast/fluttertoast.dart';


class AddCategoryPage extends StatefulWidget {
  @override
  _AddCategoryPageState createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  final _formKey = GlobalKey<FormState>();
  String _email, _password;
  TextEditingController moneyTextController = TextEditingController(); // 金额输入框控制器
  TextEditingController categoryTextController = TextEditingController(); // 账户输入框控制器

  @override
  void initState() {
    categoryTextController.text = null;
    moneyTextController.text = null;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 22.0),
            children: <Widget>[
              SizedBox(
                height: kToolbarHeight,
              ),
              buildTitle(),
              SizedBox(height: 30.0),
              buildEmailTextField(),
              SizedBox(height: 60.0),
              buildLoginButton(context), // 登录按钮

            ],
          ),
          onWillPop:(){
            print("返回键点击了");
            //Navigator.pop(context); // 返回黑屏？
            Navigator.of(context).pop();
          }
      ),
    );

  }




  RaisedButton buildLoginButton(BuildContext context) {
    return RaisedButton(
        child: Text("保存"),
        onPressed: (){
          _formKey.currentState.save(); // 保存数据
          print("进入set1");
          print("账户--添加按钮$_email $_password" );
          Fluttertoast.showToast(
              msg: "保存成功 "
                  + "类型：" + categoryTextController.text,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              backgroundColor: Colors.grey,
              textColor: Colors.white,
              fontSize: 16.0
          );
          moneyTextController.clear();
          categoryTextController.clear();
        }
    );
  }

  Row buildRegisterText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
            "没有账号？"
        ),
        FlatButton(
          child: Text(
            '点击注册',
            style: TextStyle(fontSize: 14.0, color: Colors.green),
          ),
          onPressed: () {
            print("点击注册");
            //Navigator.pop(context);
            Navigator.pushNamed(context, "register_pageRoute");
          },
        ),
      ],
    );
  }

  Padding buildForgetPasswordText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: FlatButton(
          child: Text(
            '忘记密码？',
            style: TextStyle(fontSize: 14.0, color: Colors.grey),
          ),
          onPressed: () {
            print("忘记密码");
            //Navigator.pop(context);
          },
        ),
      ),
    );
  }

  TextFormField buildPasswordTextField(BuildContext context) {
    return TextFormField(
      controller: moneyTextController,
      keyboardType: TextInputType.number, // 九宫格数字键盘
      decoration: InputDecoration(
        labelText: '金额',
      ),
      onSaved: (String value) => _password = value,
    );
  }

  TextFormField buildEmailTextField() {
    return TextFormField(
      controller: categoryTextController,
      decoration: InputDecoration(
        labelText: '类型',
      ),
      onSaved: (String value) => _email = value,
    );
  }

  Padding buildTitleLine() {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, top: 4.0),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          color: Colors.black,
          width: 40.0,
          height: 2.0,
        ),
      ),
    );
  }

  Padding buildTitle() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        '添加类型',
        style: TextStyle(fontSize: 42.0),
      ),
    );
  }

  ///用户名和密码登录
  _login(BuildContext context) async {
    print("登录按钮");
    Future<bool> b = _CheckData(_email,_password);
    if(await b){
      showSuccess(context, _email + " 您好！");
    } else {
      showError(context, "手机号或密码错误");
    }
  }

  ///用户名和密码登录
  Future<bool> _CheckData(String usr,String pass) async{
    //await DbUtil.create();
    //DbUtil().query();
    //DbUtil().dbclose();

    if(await DbUtil.isTabelExits("user_table") != null){
      String pas = await DbUtil.query_by_uername(usr);
      if(pas == pass){
        return true;
      } else {
        return false;
      }
    } else {
      await DbUtil.create_user_table();
      return false;
    }
  }



}
