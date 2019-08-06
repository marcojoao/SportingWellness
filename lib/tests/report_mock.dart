import 'dart:math';

import 'package:Wellness/model/report.dart';
import 'package:date_util/date_util.dart';

List<Report> randomDayReports(DateTime date) {
  List<Report> report = new List<Report>();
  Random rng = new Random();
  var playerId = rng.nextInt(1000);
  var dateUtility = new DateUtil();
  var days = dateUtility.daysInMonth(date.month, date.year);
  for (var i = 1; i <= days; i++) {
    report.add(
      Report(
          playerId: playerId,
          dateTime: DateTime.utc(date.year, date.month, i),
          sleepState: SleepState.values[rng.nextInt(SleepState.values.length)],
          recovery: (rng.nextDouble() * 100).round() * 1.0,
          sorroness: rng.nextBool(),
          soronessLocation:
              BodyLocation.values[rng.nextInt(BodyLocation.values.length)],
          sorronessSide: BodySide.values[rng.nextInt(BodySide.values.length)],
          pain: rng.nextBool(),
          painLocation:
              BodyLocation.values[rng.nextInt(BodyLocation.values.length)],
          painSide: BodySide.values[rng.nextInt(BodySide.values.length)],
          painNumber: rng.nextInt(5),
          notes: rng.nextBool()
              ? "Where do random thoughts come from?\nA song can make or ruin a person’s day if they let it get to them."
              : ""),
    );
  }
  return report;
}