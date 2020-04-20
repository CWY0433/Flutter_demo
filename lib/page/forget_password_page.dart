/**
 * forget_password page
 */
import 'package:flutter/material.dart';
import 'package:flutter_cwy/utils/DbUtil.dart';
import 'package:flutter_cwy/utils/dialog_util.dart';

class ForgetPage extends StatefulWidget {
  @override
  _ForgetPageState createState() => _ForgetPageState();
}

class _ForgetPageState extends State<ForgetPage> {
  final _formKey = GlobalKey<FormState>();
  String _username, _password,_password2;
  bool _isObscure = true;
  bool _isObscure2 = true;
  Color _eyeColor;
  Color _eyeColor2;


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
                buildTitle(), // 标题
                buildTitleLine(), // 标题下的划线
                SizedBox(height: 70.0),
                buildEmailTextField(), // 账号
                SizedBox(height: 30.0),
                buildPasswordTextField(context), // 新密码
                SizedBox(height: 30.0),
                buildPasswordTextField2(context), // 确认新密码
                SizedBox(height: 60.0),
                buildRegisterButton(context), // 修改按钮
              ],
            )));
  }

  Padding buildTitle() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        '忘记密码',
        style: TextStyle(fontSize: 42.0),
      ),
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

  TextFormField buildEmailTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: '账号',
      ),
      onSaved: (String value) => _username = value,
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
          labelText: '新密码',
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

  TextFormField buildPasswordTextField2(BuildContext context) {
    return TextFormField(
      onSaved: (String value) => _password2 = value,
      obscureText: _isObscure2,
      validator: (String value) {
        if (value.isEmpty) {
          return '请输入密码';
        }
      },
      decoration: InputDecoration(
          labelText: '确认新密码',
          suffixIcon: IconButton(
              icon: Icon(
                Icons.remove_red_eye,
                color: _eyeColor2,
              ),
              onPressed: () {
                setState(() {
                  _isObscure2 = !_isObscure2;
                  _eyeColor2 = _isObscure2
                      ? Colors.grey
                      : Theme.of(context).iconTheme.color;
                });
              })),
    );
  }

  Align buildRegisterButton(BuildContext context) {
    return Align(
      child: SizedBox(
        height: 45.0,
        width: 270.0,
        child: RaisedButton(
          child: Text(
            '修改',
            style: Theme.of(context).primaryTextTheme.headline,
          ),
          color: Colors.black,
          onPressed: () {
//            if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            //TODO 执行登录方法
            print('username:$_username , password:$_password , password:$_password2');
            _forget();
//            }
          },
          shape: StadiumBorder(side: BorderSide()),
        ),
      ),
    );
  }





  ///修改密码密码
  _forget() async{
    if(_username.isEmpty || _password.isEmpty || _password2.isEmpty){
      showError(context, "账号或密码不能为空");
      return;
    }

    if(_password != _password2){
      showError(context, "两次输入密码不一致");
      return;
    }

    if( !(await DbUtil.isTabelExits("user_table"))){ // 判断用户表是否存在
      await DbUtil.create_user_table(); // 不存在则创建
    }

    if(await DbUtil.query_by_uername(_username) == ""){ //先查询账户是否存在
      showError(context, "修改失败，账户$_username不存在！");
    } else {
      if(await DbUtil.update_password_by_username(_username,_password) == 0){
        showError(context, "修改失败，请重试");
      } else {
        showSuccess(context, "账户"+_username + "密码修改成功！");
      }
    }


  }
}
