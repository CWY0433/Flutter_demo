import 'package:flutter/material.dart';

class Detail extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Center(
          child: Container(
            width: 234.0,
            height: 234.0,
            child:Card(
              clipBehavior: Clip.antiAlias, // 根据设置裁剪内容
              color: Colors.green, //  卡片背景颜色
              elevation: 20.0, // 卡片的z坐标,控制卡片下面的阴影大小
              margin: EdgeInsets.all(50.0),
              //margin: EdgeInsetsDirectional.only(bottom: 30.0, top: 30.0, start: 30.0),// 边距
              semanticContainer:
              true, // 表示单个语义容器，还是false表示单个语义节点的集合，接受单个child，但该child可以是Row，Column或其他包含子级列表的widget
//      shape: Border.all(
//          color: Colors.indigo, width: 1.0, style: BorderStyle.solid), // 卡片材质的形状，以及边框
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)), // 圆角
              //borderRadius: BorderRadius.all(Radius.circular(8.0)),
              child: Column(
                //card里面的子控件
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image.asset('assets/images/pie_chart.png'),
                ],
              ),
            ),
          ),
        ),


        Container(
          width: 234.0,
          height: 234.0,
          child:Card(
            clipBehavior: Clip.antiAlias, // 根据设置裁剪内容
            color: Colors.green, //  卡片背景颜色
            elevation: 20.0, // 卡片的z坐标,控制卡片下面的阴影大小
            margin: EdgeInsets.all(50.0),
            //  margin: EdgeInsetsDirectional.only(bottom: 30.0, top: 30.0, start: 30.0),// 边距
            semanticContainer:
            true, // 表示单个语义容器，还是false表示单个语义节点的集合，接受单个child，但该child可以是Row，Column或其他包含子级列表的widget
//      shape: Border.all(
//          color: Colors.indigo, width: 1.0, style: BorderStyle.solid), // 卡片材质的形状，以及边框
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), // 圆角
            //borderRadius: BorderRadius.all(Radius.circular(8.0)),
            child: Column(
              //card里面的子控件
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset('assets/images/bar_chart.png'),
              ],
            ),
          ),
        ),

      ],
    );

  }
}