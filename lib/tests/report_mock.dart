import 'dart:convert';
import 'dart:math';

import 'package:Wellness/model/dao/report_dao.dart';
import 'package:Wellness/model/player.dart';
import 'package:Wellness/model/report.dart';
import 'package:date_util/date_util.dart';
import 'package:http/http.dart' as http;

List<Report> randomDayReports(Player player, DateTime date) {
  print("randomDayReports");
  ReportDAO repo = ReportDAO();

  List<Report> report = new List<Report>();
  Random rng = new Random();
  var dateUtility = new DateUtil();
  var days = dateUtility.daysInMonth(date.month, date.year);

  for (var i = 1; i <= days; i++) {
    var rep = Report(
        playerId: player.id,
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
            : "");

    report.add(rep);
    repo.insert(rep);
    // repo.getAllById(1).then((vals) => {
    //       vals.forEach((f) => {print("${f.toString()}")})
    //     });

    return report;
  }

  Future<List<String>> _fetchNotes(int nums) async {
    final res = await http
        .get("https://baconipsum.com/api/?type=meat-and-filler&paras=$nums");

    final ret = json.decode(res.body.toString()) as List<String>;
    return ret;
  }
}
