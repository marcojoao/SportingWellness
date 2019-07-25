import 'package:flutter/widgets.dart';
import 'package:Wellness/model/report.dart';

class Player {
  int id;

  final String name;
  final double height;
  final double weight;
  final DateTime birthDate;
  final String avatarPath;
  final TeamType team;
  final BodySide dominantMember;
  final List<Report> reports;

  Player(
      {@required this.name,
      @required this.birthDate,
      @required this.team,
      @required this.height,
      @required this.weight,
      @required this.dominantMember,
      this.avatarPath,
      this.reports});

  Future insertRecord(Report rec) async {
    this.reports.add(rec);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'birt_date': birthDate,
      'team': team,
      'height': height,
      'weight': weight,
      'avatarPath': avatarPath,
      'dominantMember': dominantMember,
      'records': reports
    };
  }

  static Player fromMap(Map<String, dynamic> map) {
    return Player(
        name: map['name'],
        birthDate: map['birthDate'],
        team: map['team'],
        height: map['height'],
        weight: map['weight'],
        avatarPath: map['avatar_path'],
        dominantMember: map['dominantMember'],
        reports: map['records']);
  }
}

enum TeamType { u_17, u_19, u_23, woman }
