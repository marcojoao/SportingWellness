import 'dart:math';

import 'package:Wellness/model/player.dart';
import 'package:Wellness/model/report.dart';
import 'package:Wellness/model/report_data_source.dart';
import 'package:Wellness/widgets/general/floating_action_menu.dart';
import 'package:Wellness/widgets/players/players_mock_list.dart';
import 'package:date_util/date_util.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PlayerDetailContainerDebug extends StatefulWidget {
  Player selectedPlayer;
  DateTime selectedDate;
  PlayerDetailContainerDebug({Key key, this.selectedPlayer, this.selectedDate})
      : super(key: key);
  @override
  _PlayerDetailContainerDebugState createState() =>
      _PlayerDetailContainerDebugState();
}

class _PlayerDetailContainerDebugState
    extends State<PlayerDetailContainerDebug> {
  Player _selectedItem;
  DateTime _selectedDate;
  double _leftPanelWidthSize = 250;
  @override
  void initState() {
    super.initState();
    setState(
      () {
        _selectedItem = widget.selectedPlayer ?? players[0];
        _selectedDate = widget.selectedDate ?? DateTime.now();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildDebug(context, _selectedItem, _selectedDate);
  }

  Widget _buildFloatingMenu(BuildContext context) {
    return FloatingActionMenu(
      closedColor: Theme.of(context).accentColor,
      children: [
        Container(
          child: FloatingActionButton(
            heroTag: "add_report",
            mini: true,
            onPressed: () => {
              Fluttertoast.showToast(
                  msg: "Add Report",
                  toastLength: Toast.LENGTH_SHORT,
                  timeInSecForIos: 1),
            },
            tooltip: 'Add Report',
            backgroundColor: Colors.white,
            child: Icon(Icons.add, color: Theme.of(context).accentColor),
          ),
        ),
        Container(
          child: FloatingActionButton(
            heroTag: "edit_profile",
            mini: true,
            onPressed: () => {
              Fluttertoast.showToast(
                  msg: "Edit Profile",
                  toastLength: Toast.LENGTH_SHORT,
                  timeInSecForIos: 1),
            },
            tooltip: 'Edit Profile',
            backgroundColor: Colors.white,
            child: Icon(Icons.edit, color: Theme.of(context).accentColor),
          ),
        ),
      ],
    );
  }

  Widget _buildLeftPanel(BuildContext context, Player player) {
    return new Container(
      width: _leftPanelWidthSize,
      color: Theme.of(context).accentColor,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 10),
            alignment: Alignment.topLeft,
            height: 40,
            child: FlatButton(
              shape: CircleBorder(),
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () => {
                Fluttertoast.showToast(
                    msg: "Back",
                    toastLength: Toast.LENGTH_SHORT,
                    timeInSecForIos: 1),
              },
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            height: 120,
            width: 120,
            decoration: _buildPlayerAvatar(player),
          ),
          Container(
            margin: EdgeInsets.all(10),
            alignment: Alignment.topCenter,
            height: 40,
            child: Text(
              player.name.split(' ')[0].toUpperCase(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRigtPanel(BuildContext context, Player player, DateTime date) {
    return new Expanded(
      child: new Container(
        color: Theme.of(context).primaryColor,
        child: new ListView(
          children: <Widget>[
            new Container(
              margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 5),
              child: new Card(
                child: new Container(
                  child: chartExample(context, player, date),
                ),
              ),
              alignment: Alignment.center,
              height: 250,
            ),
            Container(
              margin: EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 80),
              child: _buildReportDateTables(context, player)
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDebug(BuildContext context, Player player, DateTime date) {
    if (player.reports == null) player.reports = randomDayReports(date);

    return new Scaffold(
      floatingActionButton: _buildFloatingMenu(context),
      body: new Container(
        child: new Row(
          children: <Widget>[
            _buildLeftPanel(context, player),
            _buildRigtPanel(context, player, date)
          ],
        ),
      ),
    );
  }

  var reportNum = 10;
  PaginatedDataTable _buildReportDateTables(BuildContext context, Player player) {
    return PaginatedDataTable(
      
      rowsPerPage: (player.reports.length < reportNum)
          ? player.reports.length
          : reportNum,
      header: Text('Recent reports'),
      columns: ReportDataSource.getDataColumn,
      source: ReportDataSource(player.reports),
    );
  }

  BoxDecoration _buildPlayerAvatar(Player player) {
    return BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.6),
          blurRadius: 5.0, // has the effect of softening the shadow
          spreadRadius: 1.0, // has the effect of extending the shadow
        ),
      ],
      shape: BoxShape.circle,
      image: new DecorationImage(
        fit: BoxFit.fill,
        image: AssetImage(Player.defaultAvatar),
      ),
    );
  }
}

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
          painNumber: rng.nextInt(10),
          notes: rng.nextBool() ? "Where do random thoughts come from?\nA song can make or ruin a person’s day if they let it get to them." : ""),
    );
  }
  return report;
}

Widget chartExample(BuildContext context, Player player, DateTime date) {
  return SfCartesianChart(
    primaryXAxis: CategoryAxis(),
    primaryYAxis: NumericAxis(
        edgeLabelPlacement: EdgeLabelPlacement.shift,
        interval: 20,
        minimum: -20,
        maximum: 120,
        visibleMinimum: 0,
        visibleMaximum: 100,
        rangePadding: ChartRangePadding.additional,
        labelFormat: '{value}%'),
    title: ChartTitle(text: "Recovery over ${DateFormat('MMMM').format(date)}"),
    tooltipBehavior: TooltipBehavior(enable: true),
    series: <LineSeries<Report, String>>[
      LineSeries<Report, String>(
        color: Theme.of(context).accentColor,
        dataSource: player.reports,
        xValueMapper: (Report report, _) => report.dateTime.day.toString(),
        yValueMapper: (Report report, _) => report.recovery,
        markerSettings: MarkerSettings(color: Colors.white, isVisible: true),
      )
    ],
  );
}
