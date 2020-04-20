/**
 * login page
 */
import 'package:flutter/material.dart';
import 'package:flutter_cwy/utils/DbUtil.dart';
import 'package:flutter_cwy/utils/GlobalUtil.dart';
import 'package:flutter_cwy/utils/dialog_util.dart';
import 'package:fluttertoast/fluttertoast.dart';


class QuestionPage extends StatefulWidget {
  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  final _formKey = GlobalKey<FormState>();
  String _questionText;
  TextEditingController questionController = new TextEditingController();

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    questionController.addListener(() { });
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
              SizedBox(height: 30.0,),
              buildTextField(),
              SizedBox(height: 30.0,),
              buildLoginButton(context), // 反馈


            ],
          ),
          onWillPop:(){
            print("返回键点击了");
            Navigator.pop(context); // 返回黑屏？
            //Navigator.of(context).pop();
            //Navigator.pushNamed(context, "setting_pageRoute");
          }
      ),
    );

  }


  Padding buildTitle() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        '问题反馈',
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




  ConstrainedBox buildTextField() {
    return ConstrainedBox(
      constraints: BoxConstraints(
          maxHeight: 550,
          maxWidth: 50
      ),
      child: new TextFormField(
        maxLines: 9,
        decoration: InputDecoration(
          //contentPadding: const EdgeInsets.symmetric(vertical: 20.0),
          hintText: '请输入搜索内容',
          //prefixIcon: Icon(Icons.search),
          contentPadding: EdgeInsets.all(10),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none),
          filled: true,
          fillColor: Color(0xffaaaaaa),
        ),
        controller: questionController,
        onSaved: (String value) => _questionText = value, // 保存数据
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
            '反馈',
            style: Theme.of(context).primaryTextTheme.headline,
          ),
          color: Colors.black,
          onPressed: () {
            ///只有输入的内容符合要求通过才会到达此处
            _formKey.currentState.save();
            //TODO 执行登录方法
            print("问题反馈保存：$_questionText");
            _sentQuestion();
            questionController.clear();
          },
          shape: StadiumBorder(side: BorderSide()),
        ),
      ),
    );
  }

  void _sentQuestion() {
  if((questionController.text.length > 0) && !(questionController.text.isEmpty)){
    Fluttertoast.showToast(
        msg: "反馈成功!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0
    );
  } else{
    Fluttertoast.showToast(
        msg: "请输入反馈内容！",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  }






}
