import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Report {
  int id;
  int playerId;
  SleepState sleepState;
  double recovery;
  bool sorroness;
  BodyLocation soronessLocation;
  BodySide sorronessSide;
  bool pain;
  BodyLocation painLocation;
  BodySide painSide;
  int painNumber;
  DateTime dateTime;
  String notes;

  Report(
      {@required this.playerId,
      @required this.dateTime,
      @required this.sleepState,
      @required this.recovery,
      @required this.sorroness,
      this.soronessLocation,
      this.sorronessSide,
      @required this.pain,
      this.painLocation,
      this.painSide,
      this.painNumber,
      this.notes});

  Map<String, dynamic> toMap() {
    return {
      'playerId': playerId,
      'sleepState': EnumToString.parse(sleepState),
      'recovery': recovery,
      'sorroness': sorroness,
      'soronessLocation': EnumToString.parse(soronessLocation),
      'sorronessSide': EnumToString.parse(sorronessSide),
      'pain': pain,
      'painLocation': EnumToString.parse(painLocation),
      'painSide': EnumToString.parse(painSide),
      'painNumber': painNumber,
      'dateTime': dateTime.toString(),
      'notes': notes
    };
  }

  static Report fromMap(Map<String, dynamic> map) {
    return Report(
        playerId: map['playerId'],
        sleepState:
            EnumToString.fromString(SleepState.values, map['sleepState']),
        recovery: map['recovery'],
        sorroness: map['sorroness'],
        soronessLocation: EnumToString.fromString(
            BodyLocation.values, map['soronessLocation']),
        sorronessSide:
            EnumToString.fromString(BodySide.values, map['sorronessSide']),
        pain: map['pain'],
        painLocation:
            EnumToString.fromString(BodyLocation.values, map['painLocation']),
        painSide: EnumToString.fromString(BodyLocation.values, map['painSide']),
        painNumber: map['painNumber'],
        dateTime: DateTime.tryParse(map['dateTime']),
        notes: map['notes']);
  }

  @override
  String toString() {
    final data = """
                    PlayerId: ${this.playerId}
                    SleepState: ${EnumToString.parseCamelCase(this.sleepState)}
                    Recovery: ${this.recovery}
                    Sorroness: ${this.sorroness}
                    Sorroness Location: ${EnumToString.parseCamelCase(this.soronessLocation)}
                    Sorroness Side: ${EnumToString.parseCamelCase(this.sorronessSide)}
                    Pain: ${this.pain}
                    Pain Location: ${EnumToString.parseCamelCase(this.painLocation)}
                    Pain Side: ${EnumToString.parseCamelCase(this.painSide)}
                    Pain Number: ${this.painNumber}
                    Created at: ${this.dateTime.toString()}
                    Notes: ${this.notes}
                    """;
    return data;
  }
}

enum SleepState { good, noInfo, notAtAll, bad }
enum BodyLocation {
  upperBack,
  abdomen,
  ankle,
  arm,
  calf,
  chest,
  elbow,
  foot,
  forerm,
  hamstring,
  hand,
  head,
  lowerBack,
  neck,
  quadriceps,
  shoulder,
  wrist,
  knee,
  adductor,
  lowerBody,
  allBody
}
enum BodySide { left, right, both }
