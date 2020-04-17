
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';

class DbUtil{
  static const String _DB_NAME = "user_info.db"; // 数据库名字
  static const int _VERSION = 1; // 数据库版本
  static String dbPath= "/data/data/com.chen.flutter_cwy/app_flutter/user.db"; // 数据库的存储路径
  static String sql_createTable = 'CREATE TABLE user_table (id INTEGER , username TEXT PRIMARY KEY,pwd Text)'; // 创建用户表
  static String sql_query_count = 'SELECT COUNT(*) FROM user_table'; // 查询表中的数据多少
  static String sql_query = 'SELECT * FROM user_table'; // 查询表内所有数据
  static Database _database_user_info; // 数据库实例
  static init() async { // 初始化数据库
    print("初始化数据库");
    var databasePath = await getDatabasesPath();
    String path = databasePath + "/" + _DB_NAME;
    _database_user_info = await openDatabase(path,version: _VERSION,
      onCreate:(Database db,int version) async {
      });
  }

  static Future<Database>getCurrentDatabase() async {
    if(_database_user_info == null){
      print("数据库不存在！");
      await init();
    }
    return _database_user_info;
  }

  static Future<bool> isTabelExits(String tableName) async{ // 判断指定表是否存在 ///已经存在的表不能再创建
    await getCurrentDatabase();
    //String sql = "select * from Sqlite_master where type = 'table' and name = '$tableName'";
    //String sql = "SELECT * FROM TABLE = ?";
    String sql = "select * from sqlite_master where type = 'table' and name = '$tableName'";
    var res = await _database_user_info.rawQuery(sql);
    print("数据表："+ tableName + "状态：");
    bool flat =res != null && res.length > 0;
    print(flat);
    return flat;

  }



  static Future<String> _createNewDbPath(String dbName) async { // 创建数据库路径
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    print(documentsDirectory);
    String path = join(documentsDirectory.path, dbName);
    if (await new Directory(dirname(path)).exists()) {
      await deleteDatabase(path);
    } else {
      try {
        await new Directory(dirname(path)).create(recursive: true);
      } catch (e) {
        print(e);
      }
    }
    return path;
  }

  static create_table() async { // 创建数据表
    await _database_user_info.execute(sql_createTable); // 创建数据库
  }

  dbclose() async { // 关闭数据库
    await _database_user_info.close();
  }

  static add(String username,String pwd) async { // 向表内插入数据
    print("存入数据"+username + "" + pwd);
    String sql = "INSERT INTO user_table(username,pwd) VALUES('$username','$pwd')";
    await _database_user_info.transaction((txn) async {
      int id = await txn.rawInsert(sql);
      print("返回数据的id：");
      print(id);
    });
  }

  delete() async { // 删除数据
    Database db = await openDatabase(dbPath);

    String sql = "DELETE FROM user_table WHERE id = ?";

    int count = await db.rawDelete(sql, ['1']); // 删除id=1的数据


      if (count == 1) {
        print("删除成功，请查看");
      } else {
        print("删除失败，请看log");
      }
  }

  update() async {
    Database db = await openDatabase(dbPath);
    String sql = "UPDATE user_table SET pwd = ? WHERE id = ?";
    int count = await db.rawUpdate(sql, ["654321", '1']);
    print(count);
    print("更新数据成功，请查看");
  }

  queryNum() async { // 查询数据的条数
    Database db = await openDatabase(dbPath);
    int count = Sqflite.firstIntValue(await db.rawQuery(sql_query_count));
    print("数据条数：$count");
  }

  query() async { // 查询所有数据
    String sql = "SELECT * FROM user_table";
    List<Map> list = await _database_user_info.rawQuery(sql);
    print("数据详情：$list");
  }

  static Future<String> query_by_uername(String username) async { // 查询数据条数

    String sql = "SELECT * FROM user_table where username = ?";
    List<Map> list = await _database_user_info.rawQuery(sql,[username]);
    print("数据详情：$list");
    if(list.length == 0){
      print("$username 不存在");
      return "";
    } else {
      print("$username 对应的密码为：");
      print(list[0]["pwd"]);
      return(list[0]["pwd"]);
    }
  }


  user_query() async { // 查询数据
    Database db = await openDatabase(dbPath);
    String sql = "SELECT * FROM user_table where ";
    List<Map> list = await db.rawQuery(sql_query);
    print("数据详情：$list");
  }



}




  
  
  
  
  
  
  