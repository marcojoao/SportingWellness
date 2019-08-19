import 'package:enum_to_string/enum_to_string.dart';
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
      {this.id,
      @required this.name,
      @required this.birthDate,
      @required this.team,
      @required this.height,
      @required this.weight,
      @required this.dominantMember,
      this.avatarPath});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'birt_date': birthDate.toString(),
      'team': EnumToString.parse(team),
      'height': height,
      'weight': weight,
      'avatarPath': avatarPath,
      'dominantMember': EnumToString.parse(dominantMember),
    };
  }

  static String defaultAvatar = "assets/player_default.png";

  static Player fromMap(Map<String, dynamic> map) {
    return Player(
        id: map['id'],
        name: map['name'],
        birthDate: DateTime.tryParse(map['birthDate']),
        team: EnumToString.fromString(TeamType.values, map['team']),
        height: map['height'],
        weight: map['weight'],
        avatarPath: map['avatar_path'],
        dominantMember:
            EnumToString.fromString(BodySide.values, map['dominantMember']));
  }

  @override
  String toString() {
    final data = """
                    Name: ${this.name}
                    Birth Date: ${this.birthDate.toString()}
                    Team: ${EnumToString.parseCamelCase(this.team)}
                    Height: ${this.height}
                    Weight: ${EnumToString.parseCamelCase(this.weight)}
                    Dominant Member: ${EnumToString.parseCamelCase(this.dominantMember)}                   
                    """;
    return data;
  }
}

enum TeamType { under17, under19, under23, woman }
