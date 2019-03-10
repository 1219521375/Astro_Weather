import 'package:astro_weather/bean/WeatherData.dart';

class UsefulWeaData {

  String timepoint;
  String cloudcover;
  String seeing;
  String transparency;
  String lifted_index;
  String rh2m;
  String wind10m_dir;
  String wind10m_spd;
  String temp2m;
  String prec_type;

  UsefulWeaData(this.timepoint, this.cloudcover, this.seeing, this.transparency,
      this.lifted_index, this.rh2m, this.wind10m_dir, this.wind10m_spd,
      this.temp2m, this.prec_type);

  // Named constructor
  UsefulWeaData.origin(WeatherData data) {
    this.timepoint = data.timepoint.toString();
    switch(data.cloudcover){
      case 1: this.cloudcover = "0%-6%"; break;
      case 2: this.cloudcover = "6%-19%"; break;
      case 3: this.cloudcover = "19%-31%"; break;
      case 4: this.cloudcover = "31%-44%"; break;
      case 5: this.cloudcover = "44%-56%"; break;
      case 6: this.cloudcover = "56%-69%"; break;
      case 7: this.cloudcover = "69%-81%"; break;
      case 8: this.cloudcover = "81%-94%"; break;
      case 9: this.cloudcover = "94%-100%"; break;
    }
    switch(data.seeing){
      case 1: this.seeing = '<0.5"'; break;
      case 2: this.seeing = '0.5"-0.75"'; break;
      case 3: this.seeing = '0.75"-1"'; break;
      case 4: this.seeing = '1"-1.25"'; break;
      case 5: this.seeing = '1.25"-1.5"'; break;
      case 6: this.seeing = '1.5"-2"'; break;
      case 7: this.seeing = '2"-2.5"'; break;
      case 8: this.seeing = '>2.5"'; break;
    }
    switch(data.transparency){
      case 1: this.transparency = "<0.3"; break;
      case 2: this.transparency = "0.3-0.4"; break;
      case 3: this.transparency = "0.4-0.5"; break;
      case 4: this.transparency = "0.5-0.6"; break;
      case 5: this.transparency = "0.6-0.7"; break;
      case 6: this.transparency = "0.7-0.85"; break;
      case 7: this.transparency = "0.85-1"; break;
      case 8: this.transparency = ">1"; break;
    }
    switch(data.lifted_index){
      case -10: this.lifted_index = "小于-7"; break;
      case -6: this.lifted_index = "-7至-5"; break;
      case -4: this.lifted_index = "-5至-3"; break;
      case -1: this.lifted_index = "-3至0"; break;
      case 2: this.lifted_index = "0至4"; break;
      case 6: this.lifted_index = "4至8"; break;
      case 10: this.lifted_index = "8至11"; break;
      case 15: this.lifted_index = "大于11"; break;
    }
    switch(data.rh2m){
      case -4: this.rh2m = "0%-5%"; break;
      case -3: this.rh2m = "5%-10%"; break;
      case -2: this.rh2m = "10%-15%"; break;
      case -1: this.rh2m = "15%-20%"; break;
      case 0: this.rh2m = "20%-25%"; break;
      case 1: this.rh2m = "25%-30%"; break;
      case 2: this.rh2m = "30%-35%"; break;
      case 3: this.rh2m = "35%-40%"; break;
      case 4: this.rh2m = "40%-45%"; break;
      case 5: this.rh2m = "45%-50%"; break;
      case 6: this.rh2m = "50%-55%"; break;
      case 7: this.rh2m = "55%-60%"; break;
      case 8: this.rh2m = "60%-65%"; break;
      case 9: this.rh2m = "65%-70%"; break;
      case 10: this.rh2m = "70%-75%"; break;
      case 11: this.rh2m = "75%-80%"; break;
      case 12: this.rh2m = "80%-85%"; break;
      case 13: this.rh2m = "85%-90%"; break;
      case 14: this.rh2m = "90%-95%"; break;
      case 15: this.rh2m = "95%-99%"; break;
      case 16: this.rh2m = "100%"; break;
    }
    this.wind10m_dir = data.wind10m.direction;
    switch(data.wind10m.speed){
      case 1: this.wind10m_spd = "无风"; break;
      case 2: this.wind10m_spd = "1-2级"; break;
      case 3: this.wind10m_spd = "3-4级"; break;
      case 4: this.wind10m_spd = "5级"; break;
      case 5: this.wind10m_spd = "6-7级"; break;
      case 6: this.wind10m_spd = "8-9级"; break;
      case 7: this.wind10m_spd = "10-11级"; break;
      case 8: this.wind10m_spd = "12级或以上"; break;
    }
    this.temp2m = data.temp2m.toString() + "摄氏度";
    switch(data.prec_type){
      case "snow": this.prec_type = "降雪"; break;
      case "rain": this.prec_type = "降雨"; break;
      case "none": this.prec_type = "无降水"; break;
    }
  }


  String backString() {
    return "近3小时内\n" + "云量：" + this.cloudcover + "\n" +
    "视宁度：  " + this.seeing + "\n" +
    "透明度：  " + this.transparency + "\n" +
    "抬升指数：  " + this.lifted_index + "\n" +
    "2m相对湿度：  " + this.rh2m + "\n" +
    "10m风向：  " + this.wind10m_dir + "\n" +
    "10m风速：  " + this.wind10m_spd + "\n" +
    "2m温度：  " + this.temp2m + "\n" +
    "降水类型：  " + this.prec_type + "\n";
  }


}