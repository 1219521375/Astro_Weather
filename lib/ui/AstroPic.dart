import 'package:astro_weather/ui/WebPage.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

class AstroPic extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>  _AstroPicState();

}

class _AstroPicState extends State<AstroPic> with WidgetsBindingObserver{

  Dio dio = new Dio();
  bool _loading = false;
  String _text = "";
  String htmls;
  String imageurl;
  String title;
  String contents;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHtml();

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: Text("每日一图"),

      ),
      body: Column(
        children: <Widget>[
          Container(
            height:300.0,
            child: Center(
              child: _loading == false
                  ? new Text("正在获取图片")
                  : new Image(
                image: new NetworkImage(imageurl),
              ),
            )
          ),
         Container(
           height: 50.0,
           child: Center(
             child: _loading == false
                 ? new Text("正在获取标题")
                 : new Text(title,
               style: TextStyle(
                 color: Colors.black,
                 fontSize: 15.0,
                 height: 1.2,
                 decorationStyle: TextDecorationStyle.dashed),
             ),
           ),
         ),


          /*_loading == false
              ? new Text("正在获取")
              : new Text(contents),
*/
          Container(
            //margin: EdgeInsets.only(top: 120.0),
            child: FlatButton(
              child: Text("访问原网站以获得详细信息",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20.0,
                  height: 1.2,
                  decorationStyle: TextDecorationStyle.dashed),
              ),
                onPressed: (){
                Navigator.push(context, new MaterialPageRoute(builder: (context){
                  return new WebPage("https://apod.nasa.gov/apod/astropix.html","APOD");
                }));
            }),
          ),

        ],
      ),
    );
  }

  //爬虫test
  //获取HTML内容
  getHtml() async {
    String url =
        "https://apod.nasa.gov/apod/astropix.html";
    try {
      Response response;
      response = await dio.get(url);

      //读取响应内容
      //_text = await response.data.toString().substring(3000);
      htmls = response.data.toString();
      //print(htmls.substring(1000,1200));
      getImageUrl(htmls);
      getTitle(htmls);
      getContent(htmls);
      _loading = true;
    } catch (e) {
      //_text = "请求失败：$e";
      _loading = true;
      print("请求失败：$e");
    } finally {
      setState(() {
        _loading = true;
      });
    }
  }

  //获取ImageUrl地址
  getImageUrl(String html) async{
    try{
      String content;
      //<img src="image/1903/PIA20522enceladusC.jpg" alt="See Explanation.  Clicking on the picture will download
      Match match = new RegExp(r'image/(.*)"\salt="See\s+Explanation.\s+Clicking\s+on\s+the\s+pic').firstMatch(html);
      match.group(0).isEmpty?  content = "no content" : content = match.group(1);
      //imageurl = "https://apod.nasa.gov/apod/" + content;
      //print(content);
      imageurl = "https://apod.nasa.gov/apod/image/" + content;
    }catch(e){
      print(e.toString());

    }
  }

  getTitle(String html) {
    try{
      Match match = new RegExp(r'<center>\n<b>(.*)</b>').firstMatch(html);
      match.group(0).isEmpty?  title = "no content" : title = match.group(1);
      
      print(title);

    }catch(e){
      print(e.toString());
    }
  }

  getContent(String html) {
    try{
    /*<p>

    <b> Explanation: </b>(.*)<i>through</i>(.*)
    <a href=".*">(.*)</a>(.*)
    <a href=".*">(.*)</a>(.*)
    <a href=".*">(.*)</a>(.*)
    <a href=".*">(.*)</a>.

    The volcano is <a href="http://en.wikipedia.org/wiki/Mauna_Kea">Mauna Kea</a>,
    <a href="http://www.state.hi.us/">Hawai'i</a>,
    <a href="https://www.cia.gov/library/publications/the-world-factbook/geos/us.html">USA</a>,
    a frequent spot for
    <a href="ap031201.html">spectacular</a>
    <a href="ap030524.html">photographs</a>
    <a href="ap030909.html">since</a>
    <a href="ap011231.html">it</a>
    <a href="ap031123.html">is</a>
    <a href="ap031007.html">one of</a>
    <a href="ap051220.html">the</a>
    <a href="ap010603.html">premier</a>
    <a href="ap031125.html">observing</a>
    <a href="ap001101.html">locations</a>
    <a href="ap000905.html">on</a>
    <a href="ap090219.html">planet</a>
    <a href="http://antwrp.gsfc.nasa.gov/apod/image/0011/earthlights2_dmsp_big.jpg">Earth</a>.

    The Sun has just set in the
    <a href="ap101128.html">opposite direction</a>,
    behind the camera.

    Additionally, the
    <a href="https://solarsystem.nasa.gov/moons/earths-moon/overview/">Moon</a> has just passed full
    <a href="ap030810.html">phase</a> -- were it precisely at
    <a href="ap990419.html">full</a> phase it would rise, possibly
    <a href="ap001013.html">eclipsed</a>, at the very peak of the shadow.

    The Moon is actually rising in the
    <a href="ap110705.html">triangular</a>
    <a href="ap030106.html">shadow cone</a> of the volcano,
    a <a href="http://www.atoptics.co.uk/atoptics/mtshad.htm">corridor of darkness</a>
    that tapers off in the distance like
    <a href="http://www.thenakedscientists.com/HTML/questions/question/2180/">converging</a> train tracks.

    The Moon is too large and too far away to be affected
    by the
    <a href="https://worldwideinterweb.com/wp-content/uploads/2017/10/funny-cat-shadow.jpg">shadow</a> of the volcano.

    <a href="https://www.youtube.com/watch?v=Aggi0g67uXM">Refraction</a>
    of moonlight through the
    <a href="https://espo.nasa.gov/sites/default/files/images/Atmosphere36small.jpg">Earth's atmosphere</a> makes the
    <a href="ap180912.html">Moon</a> appear slightly oval.

    <a href="https://volcanoes.usgs.gov/vsc/glossary/cinder_cone.html">Cinder cone</a>s from old volcanic eruptions are visible
    in the foreground.


    </p>*/

     /* Match match = new RegExp(r'<p\sstyle="white-space:\snormal;"><strong>(.*)</strong>(.*)<span\sstyle="font-family:;"><a\shref="http://www-ssg').firstMatch(html);
      print(match.group(1) + match.group(2));*/


      print("begin");
      //   "<a\s+href=".*">(.*)</a>(.*)<a\s+href=
      RegExp reg = new RegExp(r'<a\s+href=".*">(.*)</a>\n<a\s+href="');
      /*Iterable<Match> matches = reg.allMatches(html);
      for (Match m in matches) {
        print(m.group(0));
      }*/
      Match match = reg.firstMatch(html);
      print(match.group(1));

    }catch(e){
      print(e.toString());
    }

  }

}