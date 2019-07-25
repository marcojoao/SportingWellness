import 'package:flutter/widgets.dart';
import 'package:sporting_performance/model/report.dart';

class Player {
  int id;

  final String name;
  final int age;
  final double higth;
  final DateTime birtDate;
  final String avatarPath;
  final EscalaoType escalao;
  final BodySide dominantMember;
  final List<Report> reports;

  Player(
      {@required this.name,
      @required this.age,
      @required this.birtDate,
      @required this.escalao,
      @required this.higth,
      @required this.dominantMember,
      this.avatarPath,
      this.reports});

  Future insertRecord(Report rec) async {
    this.reports.add(rec);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'birt_date': birtDate,
      'escalao': escalao,
      'higth': higth,
      'avatarPath': avatarPath,
      'dominantMember': dominantMember,
      'records': reports
    };
  }

  static Player fromMap(Map<String, dynamic> map) {
    return Player(
        name: map['name'],
        age: map['age'],
        birtDate: map['birtDate'],
        escalao: map['escalao'],
        higth: map['higth'],
        avatarPath: map['avatar_path'],
        dominantMember: map['dominantMember'],
        reports: map['records']);
  }
}

enum EscalaoType { iniciados, juvenis, juniors }
