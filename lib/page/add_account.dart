/**
 * AddAccount page
 */
import 'package:flutter/material.dart';
import 'package:flutter_cwy/utils/DbUtil.dart';
import 'package:flutter_cwy/utils/GlobalUtil.dart';
import 'package:flutter_cwy/utils/dialog_util.dart';
import 'package:fluttertoast/fluttertoast.dart';


class AddAccountPage extends StatefulWidget {
  @override
  _AddAccountPageState createState() => _AddAccountPageState();
}

class _AddAccountPageState extends State<AddAccountPage> {
  final _formKey = GlobalKey<FormState>();
  String _email, _password,_title;
  TextEditingController moneyTextController = TextEditingController(); // 金额输入框控制器
  TextEditingController accountTextController = TextEditingController(); // 账户输入框控制器

  @override
  void initState() {
    accountTextController.text = null;
    moneyTextController.text = null;
    _title = "添加账户";
    if(GlobalUtil.Chart_flag){
      accountTextController.text = GlobalUtil.Chart_name;
      moneyTextController.text = GlobalUtil.Chart_money;
      _title = "修改账户";
    }
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
              buildTitleLine(),
              SizedBox(height: 30.0),
              buildEmailTextField(),
              SizedBox(height: 30.0),
              buildPasswordTextField(context),
              SizedBox(height: 60.0),
              buildLoginButton(context), // 保存按钮

            ],
          ),
          onWillPop:(){
            print("返回键点击了");
            //Navigator.pop(context); // 返回黑屏？
            Navigator.of(context).pop();
            GlobalUtil.Chart_flag = false;
            GlobalUtil.Chart_name = "";
            GlobalUtil.Chart_money = "";
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
//          Fluttertoast.showToast(
//              msg: "保存成功 "
//                  + "账户：" + accountTextController.text
//                  +"金额: " + moneyTextController.text,
//              toastLength: Toast.LENGTH_SHORT,
//              gravity: ToastGravity.BOTTOM,
//              timeInSecForIos: 1,
//              backgroundColor: Colors.grey,
//              textColor: Colors.white,
//              fontSize: 16.0
//          );
          GlobalUtil.chart_data.add(accountTextController.text);
          if(GlobalUtil.Chart_flag){
            _amendccount(context);
          } else {
            _saveaccount(context);
          }
        }
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
      controller: accountTextController,
      decoration: InputDecoration(
        labelText: '账户',
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
        '$_title',
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

  void _saveaccount(BuildContext context) async {
    if(!(await DbUtil.isTabelExits("account_table"))){
      print("account_table表不存在！！");
      await DbUtil.create_account_table();
    }

    if(await DbUtil.isTabelExits("account_table")){
      if(_email.isNotEmpty && _password.isNotEmpty){
        if(await DbUtil.query_by_account_name(_email) == ""){
          showSuccess(context, _email + " 保存成功！");
          await DbUtil.add_account_data(_email,_password);
          clearData();
          return;
        } else {
          showError(context, "保存失败，$_email 已存在！");
        }

      } else {
        showError(context, "账户或金额不能为空");
      }
    } else {
      showError(context, "保存失败，请重试！");
      await DbUtil.create_account_table();
    }
  }

  void _amendccount(BuildContext context) async {
    if(!(await DbUtil.isTabelExits("account_table"))){
      print("account_table表不存在！！");
      await DbUtil.create_account_table();
    }

    if(await DbUtil.isTabelExits("account_table")){
      if(_email.isNotEmpty && _password.isNotEmpty){
        if(await DbUtil.query_by_account_name(GlobalUtil.Chart_name) != ""){
          if((await DbUtil.update_account_by_id(await DbUtil.query_by_account_name(GlobalUtil.Chart_name),_email,_password))== 0 ){
            showError(context, "修改失败，请重试！");
          } else {
            showSuccess(context, _email + " 修改成功！");
            clearData();
            return;
          }
        } else {
          showError(context, "修改失败，请重试！");
        }
      } else {
        showError(context, "账户或金额不能为空");
      }
    } else {
      showError(context, "修改失败，请重试！");
      await DbUtil.create_account_table();
    }
  }

  void clearData(){
    moneyTextController.clear();
    accountTextController.clear();
  }



}
