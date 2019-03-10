import 'dart:convert';
import 'dart:io';
import 'package:astro_weather/bean/ResData.dart';
import 'package:astro_weather/bean/UsefulWeaData.dart';
import 'package:astro_weather/ui/AstroPic.dart';
import 'package:astro_weather/ui/MapTest.dart';
import 'package:astro_weather/ui/MessierListPage.dart';
import 'package:astro_weather/ui/WeaReportPage.dart';
import 'package:dio/dio.dart';

import 'package:amap_location/amap_location.dart';
import 'package:astro_weather/ui/utils/SmartDrawer.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  String getLocationStr(AMapLocation loc) {
    if (loc == null) {
      return "正在定位";
    }

    if (loc.isSuccess()) {
      if (loc.hasAddress()) {
        return "定位成功: \n时间${loc.timestamp}\n经纬度:${loc.latitude} ${loc.longitude}\n 地址:${loc.formattedAddress} 城市:${loc.city} 省:${loc.province}";
      } else {
        return "定位成功: \n时间${loc.timestamp}\n经纬度:${loc.latitude} ${loc.longitude}\n ";
      }
    } else {
      return "定位失败: \n错误:{code=${loc.code},description=${loc.description}";
    }
  }

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  AMapLocation _loc = null;
  double lon, lat;

  Dio dio = new Dio();
  bool _loading = false;
  String _text = "";
  ResData resData = null;
  UsefulWeaData weadata;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocat();
    //_loc == null ?  null : fetchWeatherData(_loc.longitude,_loc.latitude);
  }

  @override
  void dispose() {
    //注意这里关闭
    AMapLocationClient.shutdown();
    super.dispose();
  }

  getLocat() async {
    await AMapLocationClient.startup(new AMapLocationOption(
        desiredAccuracy: CLLocationAccuracy.kCLLocationAccuracyHundredMeters));
    AMapLocation location = await AMapLocationClient.getLocation(true);
    lon = location.longitude;
    lat = location.latitude;
    setState(() {
      _loc = location;
      fetchWeatherData(_loc.longitude, _loc.latitude);
    });
  }

//product 产品，选择天文用途
// -- lon, lat – 指定地点的经纬度，必须是浮点数，比如+23.090或-23.090，精确到0.001度即可。
// -- ac – 高度改正，只对天文用途产品有效。可取0（默认）、2或7。 暂时不改
//  lang – 语言。对气象用途产品无效。
//  unit – 公制或英制。选择metric公制（kg&m）
//  output – 可设定为internal（图表输出）、xml或json。
// -- tzshift – 时区微调，可取0、1或-1。 暂时不改
  fetchWeatherData(double lon, double lat) async {
    String url =
        "http://www.7timer.info/bin/astro.php?product=astro&output=json&lang=en&unit=metric";
    url = url + "&ac=0&tzshift=0";
    url = url + "&lon=" + lon.toString() + "&lat=" + lat.toString();
    try {
      Response response;
      response = await dio.get(url);

      //读取响应内容
      _text = await response.data.toString().substring(4500);
      String jsonStr = response.data.toString();
      var data = ResData.fromJson(json.decode(jsonStr));
      print(jsonStr.substring(5100));
      resData = data;
      weadata = UsefulWeaData.origin(data.dataseries[2]);
    } catch (e) {
      _text = "请求失败：$e";
      print("请求失败：$e");
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: _drawer,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            "images/weather_bg.jpg",
            fit: BoxFit.fitHeight,
            color: Colors.black,
          ),
          Column(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Container(
                margin: EdgeInsets.only(top: 40.0),
                child: Center(
                  child: _loc == null
                      ? new Text("正在定位")
                      : new Text(
                          "${_loc.city}${_loc.district}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 28.0,
                              height: 1.2,
                              decorationStyle: TextDecorationStyle.dashed),
                        ),
                ),
              ),
              _loc == null
                  ? new Text("正在定位")
                  : new Text(
                      "经度${_loc.longitude.toString().substring(0, 6)},纬度${_loc.latitude.toString().substring(0, 6)}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13.0,
                          height: 1.2,
                          decorationStyle: TextDecorationStyle.dashed),
                    ),
              new Container(
                margin: EdgeInsets.only(top: 20.0),
                child: Center(
                  child: resData == null
                      ? new Text(
                          "正在获取晴天钟信息",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              height: 1.2,
                              decorationStyle: TextDecorationStyle.dashed),
                        )
                      : new Text(
                          weadata.backString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              height: 1.2,
                              decorationStyle: TextDecorationStyle.dashed),
                        ),
                ),
              ),
              new Container(
                margin: EdgeInsets.only(top: 20.0),
                child: FlatButton(
                  color: Colors.blue,
                  highlightColor: Colors.blue[700],
                  colorBrightness: Brightness.dark,
                  splashColor: Colors.grey,
                  child: Text("长时预报"),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  onPressed: () {
                    Navigator.push(context,
                        new MaterialPageRoute(builder: (context) {
                      return new WeaReportPage(data: resData);
                    }));
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  get _drawer => SmartDrawer(
        widthPercent: 0.6,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
              ),
              child: Center(
                child: SizedBox(
                  width: 60.0,
                  height: 60.0,
                  child: CircleAvatar(
                    child: Image(image: AssetImage("images/star.jpg")),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.brightness_4),
              title: Text("晴天钟"),
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context, new MaterialPageRoute(builder: (context){
                  return new MyHomePage(title: "晴天钟",);
                }));
              },
            ),
            ListTile(
              leading: Icon(Icons.brightness_4),
              title: Text("梅西耶天体表"),
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context, new MaterialPageRoute(builder: (context){
                  return new MessierListPage();
                }));
              },
            ),
            ListTile(
              leading: Icon(Icons.date_range),
              title: Text("APOD每日一图"),
              onTap: (){
                Navigator.push(context, new MaterialPageRoute(builder: (context){
                  return new AstroPic();
                }));
              },
            ),
            ListTile(
              leading: Icon(Icons.lightbulb_outline),
              title: Text("地图测试"),
              onTap: (){
                Navigator.push(context, new MaterialPageRoute(builder: (context){
                  return new MapTest();
                }));
              },
            ),
          ],
        ),
      );
}
