import 'package:flutter/widgets.dart';

class Report {
  int id;
  SleepState sleepState;
  double recovery;
  bool sorroness;
  BodyLocation soronessLocation;
  BodySide sorronessSide;
  bool pain;
  BodyLocation painLocation;
  BodySide painSide;
  int painNumber;

  Report(
      {@required this.sleepState,
      @required this.recovery,
      @required this.sorroness,
      this.soronessLocation,
      this.sorronessSide,
      @required this.pain,
      this.painLocation,
      this.painSide,
      this.painNumber});

  Map<String, dynamic> toMap() {
    return {
      'sleepState': sleepState,
      'recovery': recovery,
      'sorroness': sorroness,
      'soronessLocation': soronessLocation,
      'sorronessSide': sorronessSide,
      'pain': pain,
      'painLocation': painLocation,
      'painSide': painSide,
      'painNumber': painNumber
    };
  }

  static Report fromMap(Map<String, dynamic> map) {
    return Report(
        sleepState: map['sleepState'],
        recovery: map['recovery'],
        sorroness: map['sorroness'],
        soronessLocation: map['soronessLocation'],
        sorronessSide: map['sorronessSide'],
        pain: map['pain'],
        painLocation: map['painLocation'],
        painSide: map['painSide'],
        painNumber: map['painNumber']);
  }
}

enum SleepState { good, medium, bad }
enum BodyLocation { legs, arms }
enum BodySide { left, right, both }
