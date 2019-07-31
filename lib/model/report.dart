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
  bool selected ;

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
      this.selected});

  Map<String, dynamic> toMap() {
    return {
      'playerId': playerId,
      'sleepState': sleepState,
      'recovery': recovery,
      'sorroness': sorroness,
      'soronessLocation': soronessLocation,
      'sorronessSide': sorronessSide,
      'pain': pain,
      'painLocation': painLocation,
      'painSide': painSide,
      'painNumber': painNumber,
      'dateTime': dateTime,
      'selected': selected
    };
  }

  static Report fromMap(Map<String, dynamic> map) {
    return Report(
        playerId: map['playerId'],
        sleepState: map['sleepState'],
        recovery: map['recovery'],
        sorroness: map['sorroness'],
        soronessLocation: map['soronessLocation'],
        sorronessSide: map['sorronessSide'],
        pain: map['pain'],
        painLocation: map['painLocation'],
        painSide: map['painSide'],
        painNumber: map['painNumber'],
        dateTime: map['dateTime'],
        selected: map['selected']);
  }

  static List<DataColumn> dataTableColumn = <DataColumn>[
    DataColumn(
    label: const Text('Date'),
    numeric: false,
  ),
  DataColumn(
    label: const Text('Sleep'),
    numeric: false,
  ),
  DataColumn(
    label: const Text('Recovery'),
    numeric: false,
  ),
  DataColumn(
    label: const Text('Sorness'),
    numeric: false,
  ),
  DataColumn(
    label: const Text('Pain'),
    numeric: false,
  ),
];
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
