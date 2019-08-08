import 'package:flutter/widgets.dart';
import 'package:Wellness/model/report.dart';

//* Reference: https://www.visualpharm.com/free-icons/teams-595b40b85ba036ed117dbbff

class Player {
  int id;

  String name;
  double height;
  double weight;
  DateTime birthDate;
  String avatarPath;
  TeamType team;
  BodySide dominantMember;

  Player(
      {@required this.name,
      @required this.birthDate,
      @required this.team,
      @required this.height,
      @required this.weight,
      @required this.dominantMember,
      this.avatarPath});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'birt_date': birthDate,
      'team': team,
      'height': height,
      'weight': weight,
      'avatarPath': avatarPath,
      'dominantMember': dominantMember,
    };
  }

  static String defaultAvatar = "assets/player_default.png";

  static Player fromMap(Map<String, dynamic> map) {
    return Player(
        name: map['name'],
        birthDate: map['birthDate'],
        team: map['team'],
        height: map['height'],
        weight: map['weight'],
        avatarPath: map['avatar_path'],
        dominantMember: map['dominantMember']);
  }
}

enum TeamType { under17, under19, under23, woman }