/**
 *  creat by cwy on 2020/3/16
 *  工具类
 */

class GlobalUtil {
  static bool isLogin = false;
  static String Login_user_name = "";

  static bool Chart_flag = false;
  static String Chart_name = "";
  static String Chart_money = "";
  static List<Map> Chart_data = null;


  static List chart_data = [" "];
  static List chart_money = [" "];

  static List in_out_data = [
    {'title': '收入', 'value': 1},
    {'title': '支出', 'value': 2},
  ];

  static List test_data = [
    {'title': '工资', 'value': 1},
    {'title': '兼职', 'value': 2},
    {'title': '工资', 'value': 3},
    {'title': '其他', 'value': 4},
//    {'title': '工资5', 'value': 5},
//    {'title': '兼职2342342342346', 'value': 6},
//    {'title': '工资423423427', 'value': 7},
//    {'title': '兼职444444444443222222428', 'value': 8},
  ];

  static double menuHeight = 2.0;
  static double myMenuHeight = 4.0;


  static double getMyMenu_Height(){
    return myMenuHeight;
  }

  static void setMyMenu_Height(double height){
    myMenuHeight = height;
  }

  static double getMenu_Height(){
    return menuHeight;
  }

  static void setMenu_Height(double height){
    menuHeight = height;
  }
}