/**
 * user page
 */
import 'package:flutter/material.dart';
import 'package:flutter_cwy/utils/DbUtil.dart';
import 'package:flutter_cwy/utils/GlobalUtil.dart';
import 'package:flutter_cwy/utils/dialog_util.dart';


class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final _formKey = GlobalKey<FormState>();
  String _email, _password;
  bool _isObscure = true;
  Color _eyeColor;





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
              buildTitleLine(),
              buildUserNameText(context),
//              SizedBox(height: 70.0),
//              buildEmailTextField(), // 账号
//              SizedBox(height: 30.0),
//              buildPasswordTextField(context), // 密码
              buildForgetPasswordText(context), // 忘记密码
//              SizedBox(height: 60.0),
//              buildLoginButton(context), // 登录按钮
//              SizedBox(height: 30.0),
//              buildRegisterText(context), // 注册

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

  Padding buildUserNameText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 1.0),
      child:Text(
        "账户：",
        style: TextStyle(fontSize: 30.0),
      ),
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
            Navigator.pushNamed(context, "forget_password_pageRoute");
            //Navigator.pop(context);
          },
        ),
      ),
    );
  }

  TextFormField buildPasswordTextField(BuildContext context) {
    return TextFormField(
      onSaved: (String value) => _password = value,
      obscureText: _isObscure,
      validator: (String value) {
        if (value.isEmpty) {
          return '请输入密码';
        }
      },
      decoration: InputDecoration(
          labelText: '密码',
          suffixIcon: IconButton(
              icon: Icon(
                Icons.remove_red_eye,
                color: _eyeColor,
              ),
              onPressed: () {
                setState(() {
                  _isObscure = !_isObscure;
                  _eyeColor = _isObscure
                      ? Colors.grey
                      : Theme.of(context).iconTheme.color;
                });
              })),
    );
  }

  TextFormField buildEmailTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: '账号',
      ),
      validator: (String value) {
//        var emailReg = RegExp(
//            r"[\w!#$%&'*+/=?^_`{|}~-]+(?:\.[\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\w](?:[\w-]*[\w])?\.)+[\w](?:[\w-]*[\w])?");
//        if (!emailReg.hasMatch(value)) {
//          return '请输入正确的邮箱地址';
//        }
      },
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
          width: 160.0,
          height: 2.0,
        ),
      ),
    );
  }

  Padding buildTitle() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        '用户信息',
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
      showError(context, "账号或密码错误");
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
