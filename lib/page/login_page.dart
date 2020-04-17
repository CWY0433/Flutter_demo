/**
 * login page
 */
import 'package:flutter/material.dart';
import 'package:flutter_cwy/utils/DbUtil.dart';
import 'package:flutter_cwy/utils/GlobalUtil.dart';
import 'package:flutter_cwy/utils/dialog_util.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                    SizedBox(height: 70.0),
                    buildEmailTextField(),
                    SizedBox(height: 30.0),
                    buildPasswordTextField(context),
                    buildForgetPasswordText(context),
                    SizedBox(height: 60.0),
                    buildLoginButton(context), // 登录按钮
                    SizedBox(height: 30.0),
                    buildRegisterText(context),

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




  Align buildLoginButton(BuildContext context) {
    return Align(
      child: SizedBox(
        height: 45.0,
        width: 270.0,
        child: RaisedButton(
          child: Text(
            '登录',
            style: Theme.of(context).primaryTextTheme.headline,
          ),
          color: Colors.black,
          onPressed: () {
//            if (_formKey.currentState.validate()) {
            ///只有输入的内容符合要求通过才会到达此处
            _formKey.currentState.save();
            //TODO 执行登录方法
            print('email:$_email , assword:$_password');
            _login(context);
//            }
          },
          shape: StadiumBorder(side: BorderSide()),
        ),
      ),
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
//      Align(
//        alignment: Alignment.center,
//        child: FlatButton(
//          child: Text(
//            '注册',
//            style: TextStyle(fontSize: 14.0, color: Colors.green),
//
//          ),
//          onPressed: () {
//            print("忘记密码");
//            //Navigator.pop(context);
//          },
//        ),
//      ),
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
        labelText: '手机号',
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
        '登录',
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
      await DbUtil.create_table();
      return false;
    }
  }



}
