import 'package:flutter/widgets.dart';
import 'package:sporting_performance/model/report.dart';

class Player {
  int id;

  final String name;
  final int age;
  final DateTime birtDate;
  final String avatarPath;
  final EscalaoType escalao;
  final List<Report> reports;

  Player(
      {@required this.name,
      @required this.age,
      @required this.birtDate,
      @required this.escalao,
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
      'avatarPath': avatarPath,
      'records': reports
    };
  }

  static Player fromMap(Map<String, dynamic> map) {
    return Player(
        name: map['name'],
        age: map['age'],
        birtDate: map['birtDate'],
        escalao: map['escalao'],
        avatarPath: map['avatar_path'],
        reports: map['records']);
  }
}

enum EscalaoType { iniciados, juvenis, juniors }
