import 'package:flutter/widgets.dart';

class Player {
  int id;

  final String name;
  final int age;
  final DateTime birtDate;
  final String avatarPath;
  final EscalaoType escalao;

  Player(
      {@required this.name,
      @required this.age,
      @required this.birtDate,
      @required this.escalao,
      this.avatarPath});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'birt_date': birtDate,
      'escalao': escalao,
      'avatarPath': avatarPath
    };
  }

  static Player fromMap(Map<String, dynamic> map) {
    return Player(
        name: map['name'],
        age: map['age'],
        birtDate: map['birtDate'],
        escalao: map['escalao'],
        avatarPath: map['avatar_path']);
  }
}

enum EscalaoType { iniciados, juvenis, juniors }
