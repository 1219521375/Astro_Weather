
import 'package:json_annotation/json_annotation.dart';

part 'MessierStar.g.dart';
@JsonSerializable()
class MessierStar {
  String m_num;
  String ngc_num;
  String right_asc;
  String declination;
  String sight_size;
  double sight_bright;
  int ly;
  String constellation;
  String kind;  //class
  String others;

  MessierStar(this.m_num, this.ngc_num, this.right_asc, this.declination,
      this.sight_size, this.sight_bright, this.ly, this.constellation,
      this.kind, this.others);

  @override
  String toString() {
    return 'MessierStar{m_num: $m_num, ngc_num: $ngc_num, right_asc: $right_asc, declination: $declination, sight_size: $sight_size, sight_bright: $sight_bright, ly: $ly, constellation: $constellation, class: $kind, others: $others, }';
  }
  factory MessierStar.fromJson(Map<String, dynamic> json) => _$MessierStarFromJson(json);


}