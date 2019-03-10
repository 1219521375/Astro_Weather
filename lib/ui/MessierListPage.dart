import 'dart:convert';

import 'package:astro_weather/bean/MessierList.dart';
import 'package:astro_weather/bean/MessierStar.dart';
import 'package:flutter/material.dart';

class MessierListPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _MessierListPageState();

}

class _MessierListPageState extends State<MessierListPage> with WidgetsBindingObserver{

  String jsonstr;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadString();
    loadData(jsonstr);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: <Widget>[
          SingleChildScrollView(
            child: Text(jsonstr.substring(20500)),
          )

        ],
      ),
    );
  }

  loadString() {
    Future<String> loadString = DefaultAssetBundle.of(context).loadString("json/Messier.json");

    loadString.then((String value){
      // 通知框架此对象的内部状态已更改
      setState((){
        // 将参数赋予存储点击数的变量
        jsonstr = value;
        //print(jsonstr);
      });
    });

  }

  void loadData(String jsons) {

    //一个JSON格式的用户列表字符串
    String jsonStr='[{"name":"Jack"},{"name":"Rose"}]';
    //将JSON字符串转为Dart对象(此处是List)
    //List items=json.decode(jsons);
//输出第一个用户的姓名
    //print(items[0]["m_num"]);

    var data= MessierList.fromJson(json.decode(jsonStr));
    print(data.stars.length.toString());
  }

}