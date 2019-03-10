import 'package:astro_weather/bean/ResData.dart';
import 'package:astro_weather/bean/UsefulWeaData.dart';
import 'package:astro_weather/bean/WeatherData.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class WeaReportPage extends StatelessWidget{

  final ResData data;

  const WeaReportPage({
    Key key,
    @required this.data,
  }):super(key:key);


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        Container(
          color: Colors.black,
        ),
        Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 45.0,bottom: 20.0),
              height: 45.0,
              child: Center(
                child: Text("72小时内天气预报",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28.0,
                      height: 1.2,
                      decoration:TextDecoration.none
                  ),
                ),
              ),
            ),
            Container(
              height: 400,
              child:Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                      child:Container(
                        height: 400.0,
                        child:ListView.builder(
                            padding: EdgeInsets.all(0.0),//解决头部空缺一块的问题
                            cacheExtent: 0.0, //cacheExtent  设置预加载的区域
                            physics: NeverScrollableScrollPhysics(), //禁止滑动
                            shrinkWrap: true,//内容适配
                            primary: false,//禁止滚动,
                            itemCount: 10,
                        itemBuilder:(BuildContext context, int index) {
                            return getTypeItem(index);
                        }),
                      ),
                  ),
                  Expanded(
                      flex: 4,
                      child: Container(
                        height: 400,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: data.dataseries.length,
                            itemBuilder: (BuildContext context, int index) {
                              return getWeaItem(context,data.dataseries[index],index);
                            }
                        ),
                      )
                  )
                ],
              ),
            ),

            Container(
              height: 80.0,
              child:Center(
                child: FlatButton(
                    onPressed: (){
                      Navigator.pop(context);
                      },
                    child: Icon(Icons.close,color: Colors.white,)
                ),
              )
            ),
          ],
        ),
      ],
    );
  }


  getTypeItem(int index){
    List list = [
      "时间",
      "云量",
      "视宁度",
      "透明度",
      "不稳定度",
      "相对湿度",
      "风向",
      "风速",
      "温度",
      "降水",
    ];
    return Container(
      margin: EdgeInsets.only(left: 4.0),
      height: 40,
      child: Center(
        child: Text(list[index],style: TextStyle(color: Colors.white, fontSize: 15.0, height: 1.2, decoration:TextDecoration.none),),
      ),
    );


  }

  getHour(int hour){
    hour = (hour + 1) ~/ 3;
   hour = hour * 3 - 1 -3;
   return hour > 0 ? hour : hour + 24;
  }

  getWeaItem(BuildContext context,WeatherData weadata,int index){
    UsefulWeaData data = UsefulWeaData.origin(weadata);

    DateTime time = new DateTime.now();
    int hour = getHour(time.hour);

    String cloudUrl = "images/cloud/" + weadata.cloudcover.toString() + "cloud.png";
    String seeingUrl = "images/seeing/" + weadata.seeing.toString() + ".png";
    String transUrl = "images/transparency/" + weadata.transparency.toString() + ".png";
    int unstable;
    if(weadata.lifted_index == -1){
      unstable = 1;
    }else if(weadata.lifted_index == -4){
      unstable = 2;
    }else if(weadata.lifted_index <= -6){
      unstable = 3;
    }else{
      unstable = 0;
    }
    String unstableUrl = "images/unstable/" + unstable.toString() + ".png";
    int rh;
    if(weadata.rh2m == 12 && weadata.rh2m == 13){
      rh = 1;
    }else if(weadata.rh2m == 14){
      rh = 2;
    }else if(weadata.rh2m == 15 && weadata.rh2m == 16){
      rh = 3;
    }else {
      rh = 0;
    }
    String rhUrl = "images/rh/" + rh.toString() + ".png";
    int windsp;
    if(weadata.wind10m.speed == 4){
      windsp = 1;
    }else if(weadata.wind10m.speed == 5){
      windsp = 2;
    }else if(weadata.wind10m.speed >= 6){
      windsp = 3;
    }else{
      windsp = 0;
    }
    String windspUrl = "images/windsp/" + windsp.toString() + ".png";
    String rainsnowUrl = "images/rainsnow/" + weadata.prec_type + ".png";



    return Container(
        height: 400.0,
        width: 50,
        child: Column(
          children: <Widget>[
            Container(//时间  ok
              height: 40,
              child:Center(
                child: Text(((hour + 3 * index) % 24).toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      height: 1.2,
                      decoration:TextDecoration.none
                  ),
                ),
              ),
            ),
            Container(//云量  ok
              height: 40,
              child:Center(
                child: Image(image: AssetImage(cloudUrl)),
              ),
            ),
            Container(//视宁度  ok
              height: 40,
              child:Center(
                child: Image(image: AssetImage(seeingUrl)),
              ),
            ),
            Container(//透明度  ok
              height: 40,
              child:Center(
                child: Image(image: AssetImage(transUrl)),
              ),
            ),
            Container(//抬升指数 不稳定度 ok
              height: 40,
              child:Center(
                child: Image(image: AssetImage(unstableUrl)),
              ),
            ),
            Container(//相对湿度  ok
              height: 40,
              child:Center(
                child: Image(image: AssetImage(rhUrl)),
              ),
            ),
            Container(//风向  ok
              height: 40,
              child:Center(
                child: Text(data.wind10m_dir,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      height: 1.2,
                      decoration:TextDecoration.none
                  ),
                ),
              ),
            ),
            Container(//风速  ok
              height: 40,
              child:Center(
                child: Image(image: AssetImage(windspUrl)),
              ),
            ),
            Container(//温度  ok
              height: 40,
              child:Center(
                child: Text(weadata.temp2m.toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      height: 1.2,
                      decoration:TextDecoration.none
                  ),
                ),
              ),
            ),
            Container(//降水
              height: 40,
              child:Center(
                child: Image(image: AssetImage(rainsnowUrl)),
              ),
            ),
          ],
        )

    );
  }

}