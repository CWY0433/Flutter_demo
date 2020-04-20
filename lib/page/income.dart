/**
 * login page
 */
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cwy/utils/DbUtil.dart';
import 'package:flutter_cwy/utils/GlobalUtil.dart';
import 'package:flutter_cwy/utils/GlobalUtil.dart';
import 'package:flutter_cwy/utils/dialog_util.dart';
import 'package:flutter_cwy/utils/dropdown_menu.dart';
import 'package:flutter_cwy/utils/my_dropdown_menu.dart';
import 'package:fluttertoast/fluttertoast.dart';



class InComePage extends StatefulWidget {
  @override
  _InComePageState createState() => _InComePageState();
}

class _InComePageState extends State<InComePage> {
  final _formKey = GlobalKey<FormState>();
  String _email, _password;
  bool _isObscure = true;
  Color _eyeColor;
  TextInputClient client;
  final Color _bgColor = Color.fromRGBO(83, 94, 104, 1);
  DateTime selectedDate = DateTime.now();
  TextEditingController moneyTextController = TextEditingController(); // 金额输入框控制器
  TextEditingController remarkTextController = TextEditingController(); // 备注输入框控制器
  String typeName = '收入';
  String typeCategory = "类别1";
  String typeAccount = "账户1";
  String typeDate = "2020-03-18";


  final List datas = [
    {'title': '选项一', 'value': 1},
    {'title': '选项二', 'value': 2},
    {'title': '选项三', 'value': 3},
    {'title': '选项四', 'value': 4},
    {'title': '选项五', 'value': 5},
    {'title': '选项六', 'value': 6},
    {'title': '选项七', 'value': 7},
    {'title': '选项八', 'value': 8},
    {'title': '选项九', 'value': 9},
  ];



  @override
  void initState() {
    remarkTextController.text = null;
    moneyTextController.text = null;
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar:
      body: Form(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 22.0),
            children: <Widget>[
              SizedBox(height: 30.0),
              myAppBar(context), // 收入 支出
              SizedBox(height: 30.0),
              buildMoneyTextField(), // 金额
              SizedBox(height: 30.0),
              buildDate(context),  // 时间
              SizedBox(height: 30.0),
              buildRemarkTextField(context), // 备注
              SizedBox(height: 30.0),
              categoryAndAccountRow(), //类型和账户
              SizedBox(height: 30.0),
              buildSaveButtonField(context), // 保存



            ],
          ),
          onWillPop: () {
            print("返回键点击了");
            Navigator.of(context).pop();
          }
      ),
    );
  }

  Row categoryAndAccountRow() {
    // 类型和账户
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // 中间留空 两边占满
      children: <Widget>[
        Row(
          children: <Widget>[
            Text("类别："),
            Container(
              //height: 100.0,
              //width: 100.0,
              child: buildCategory(),
            ),
            IconButton(
              icon:Icon(
                Icons.settings,
                size: 20,
              ),
              onPressed: (){
                Navigator.pushNamed(context, "chart_pageRoute");
              },
            ),
          ],
        ),

        Row(
          children: <Widget>[
            Text("账户："),
            buildAccount(), // 账户下拉框
            IconButton(
              icon:Icon(
                Icons.settings,
                size: 20,
              ),
              onPressed: (){
                Navigator.pushNamed(context, "chart_pageRoute");
              },
            ),
          ],
        ),

      ],
    );
  }



  Row myAppBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        HJDropdownMenuButton(
          top: kToolbarHeight + 15, //放在appBar固定高度下方
          initialValue: 1,
          items: GlobalUtil.in_out_data.map((e) {
            return HJPopupMenuItemData(title: e['title'], value: e['value']);
          }).toList(),
          valueChanged: (itemData) {
            setState(() {
              typeName = itemData.title;
            });
          },
        ),
      ],
    );
  }

  TextFormField buildMoneyTextField() {
    // 金额
    //金额
    return TextFormField(
      controller: moneyTextController,
      keyboardType: TextInputType.number, // 键盘类型
      decoration: InputDecoration(
        labelText: '金额',
      ),
      onSaved: (String value) => _email = value,
    );
  }

  TextFormField buildCategoryTextField(BuildContext context) {
    return TextFormField(
      onTap: () {},
      onSaved: (String value) => _password = value,
      decoration: InputDecoration(
        labelText: '类别',
      ),
    );
  }

  buildCategory() { //类别
    //GlobalUtil.setMenu_Height(4.0);
    return MyHJDropdownMenuButton(

      top: kToolbarHeight + 310.0, //放在appBar固定高度下方
      initialValue: 1,
      items: datas.map((e) {
        return MyHJPopupMenuItemData(title: e['title'], value: e['value']);
      }).toList(),
      valueChanged: (itemData) {
        setState(() {
          typeCategory = itemData.title;
        });
      },
    );
  }

  buildAccount() {
    return MyHJDropdownMenuButton(
      top: kToolbarHeight + 310.0, //放在appBar固定高度下方
      initialValue: 1,
      items: GlobalUtil.test_data.map((e) {
        return MyHJPopupMenuItemData(title: e['title'], value: e['value']);
      }).toList(),
      valueChanged: (itemData) {
        setState(() {
          print('下拉框 Height is ${context.size.height} 其他$kToolbarHeight');
          typeName = itemData.title;
        });
      },
    );
  }


  Future<void> _selectDate() async //异步
      {
    final DateTime date = await showDatePicker( //等待异步处理的结果
      //等待返回
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (date == null) return; //点击DatePicker的cancel
    setState(() {
      //点击DatePicker的OK OK
      selectedDate = date;
      typeDate = selectedDate.toIso8601String().substring(0, 10);
    });
  }




  Container buildDate(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Text("时间"),
          SizedBox(width: 15),
          InkWell(
            //包装一个相应点击的组件
            onTap: _selectDate,
            child: Row(
              children: <Widget>[
                // Text(DateFormat.yMd().format(selectedDate)),// 5/10/2019
                // Text(DateFormat.yMMM().format(selectedDate)),// May 2019
                Text(selectedDate.toIso8601String().substring(0, 10)),
                //Text(DateFormat.yMMMd().format(selectedDate)), // May 10, 2019
                // Text(DateFormat.yMMMMd().format(selectedDate)),// May 10, 2019
                Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ],
      ),
    );
  }


  TextFormField buildRemarkTextField(BuildContext context) {
    // 备注
    return TextFormField(
      controller: remarkTextController,
      onSaved: (String value) => _password = value,
      decoration: InputDecoration(
        labelText: '备注',
      ),
    );
  }

  RaisedButton buildSaveButtonField(BuildContext context) {
    // 保存
    return RaisedButton(
      child: Text("保存"),
      onPressed: () {
        Fluttertoast.showToast(
            msg: "保存成功 "
                +"类型: " + typeName
                +" 金额: " + moneyTextController.text
                + " 时间: " + typeDate
                + " 备注: " + remarkTextController.text
                + " 类别: " + typeCategory
                + " 账户: " + typeAccount,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 16.0
        );
        moneyTextController.clear();
        remarkTextController.clear();
        print("保存"+ moneyTextController.text);
      },
    );
  }

}


//  GestureDetector buildTest(BuildContext context) {
//    return GestureDetector(
//      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
//        Text("文字"),
//        SizedBox(
//          width: 5,
//        ),
//        Icon(
//          (true ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down),
//          size: 30,
//        )
//      ]),
//      onTap: () {
//        setOpenStatus();
//        Navigator.push(
//          context,
//          HJPopupMenuRoute(
//            child: HJPopupMenu(
//              left: widget.left,
//              top: widget.top,
//              initialValue: currentSelectValue,
//              items: widget.items,
//              valueChanged: (value) {
//                setState(() {
//                  currentSelectValue = value;
//                  _valueChangedCallback(value);
//                });
//              },
//            ),
//          ),
//        ).then((value) {
//          setOpenStatus();
//        });
//      },




  /*

  TimeOfDay selectedTime = TimeOfDay(hour: 9, minute: 30);
  Future<void> _seletedTime() async {
    //异步
    final TimeOfDay time = await showTimePicker( //等待异步处理的结果
      context: context,
      initialTime: selectedTime,
    );
    if (time == null) return;

    setState(() {
      selectedTime = time;
    });
  }


    Container test(BuildContext context){
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                //包装一个相应点击的组件
                onTap: _selectDate,
                child: Row(
                  children: <Widget>[
                    // Text(DateFormat.yMd().format(selectedDate)),// 5/10/2019
                    // Text(DateFormat.yMMM().format(selectedDate)),// May 2019
                    Text(selectedDate.toIso8601String()),
                    //Text(DateFormat.yMMMd().format(selectedDate)), // May 10, 2019
                    // Text(DateFormat.yMMMMd().format(selectedDate)),// May 10, 2019
                    Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
              InkWell(
                //包装一个相应点击的组件
                onTap: _seletedTime,
                child: Row(
                  children: <Widget>[
                    Text(selectedTime.format(context)), // May 10, 2019
                    Icon(Icons.arrow_drop_down),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }


   RaisedButton buildDateTextField(BuildContext context) { // 日期
    return RaisedButton(
      child: new Text(
        "时间"
      ),
      onPressed: () {
        // 调用函数打开
        showDatePicker(
          context: context,
          initialDate: new DateTime.now(),
          firstDate: new DateTime.now().subtract(new Duration(days: 30)), // 减 30 天
          lastDate: new DateTime.now().add(new Duration(days: 30)),       // 加 30 天
        ).then((DateTime val) {
          String Ttime = val.toIso8601String().substring(0,10); // 2018-07-12 00:00:00.000
          var data = val;
          print(Ttime);

        }).catchError((err) {
          print(err);
        });
      },
    );
  }

 */
