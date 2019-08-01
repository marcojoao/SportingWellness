import 'dart:math';

import 'package:Wellness/model/player.dart';
import 'package:Wellness/model/report.dart';
import 'package:Wellness/model/report_data_source.dart';
import 'package:Wellness/widgets/general/diagonally_cut_colored_image.dart';
import 'package:Wellness/widgets/general/floating_action_menu.dart';
import 'package:Wellness/widgets/players/players_mock_list.dart';
import 'package:date_util/date_util.dart';
import 'package:enum_to_string/enum_to_string.dart';
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
  int _reportPerPage = 10;
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
      child: new Stack(
        children: <Widget>[
          _buildBackgroundHeader(context),
          new Align(
            alignment: FractionalOffset.bottomCenter,
            heightFactor: 1.4,
            child: new Column(
              children: <Widget>[
                Container(
                  child: _buildPlayerName(player),
                  alignment: Alignment.topCenter,
                  margin: EdgeInsets.only(top: 180),
                )
              ],
            ),
          ),
          new Positioned(
            top: 10.0,
            left: 4.0,
            child: new BackButton(color: Colors.white),
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
                  child: _buildChart(context, player, date),
                ),
              ),
              alignment: Alignment.center,
              height: 250,
            ),
            Container(
                margin:
                    EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 80),
                child: _buildReportDateTables(context, player)),
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

  Widget _buildChart(BuildContext context, Player player, DateTime date) {
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
      title:
          ChartTitle(text: "Recovery over ${DateFormat('MMMM').format(date)}"),
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

  PaginatedDataTable _buildReportDateTables(
      BuildContext context, Player player) {
    return PaginatedDataTable(
      rowsPerPage: (player.reports.length < _reportPerPage)
          ? player.reports.length
          : _reportPerPage,
      header: Text('Recent reports'),
      columns: ReportDataSource.getDataColumn,
      source: ReportDataSource(context, player.reports),
    );
  }

  Widget _buildPlayerAvatar(Player player) {
    return CircleAvatar(
      backgroundImage: Image.asset(Player.defaultAvatar).image,
      radius: 50.0,
    );
  }

  Widget _buildBackgroundHeader(BuildContext context) {
    return new DiagonallyCutColoredImage(
      new Image.asset(
        Player.defaultAvatar,
        height: 280.0,
        fit: BoxFit.cover,
      ),
      color: Colors.black.withOpacity(0.3),
    );
  }

  Widget _buildPlayerName(Player player) {
    var rawNameS = player.name.split(" ");
    for (var i = 0; i < rawNameS.length; i++) {
      var n = rawNameS[i];
      rawNameS[i] =
          n.substring(0, 1).toUpperCase() + n.substring(1, n.length);
    }
    var name = (rawNameS.length) > 1
        ? "${rawNameS[0].substring(0, 1)}. ${rawNameS[rawNameS.length - 1]}"
        : rawNameS[0];
    return Column(
      children: <Widget>[
        Text(
          name,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                offset: Offset(1, 1),
                blurRadius: 5,
              ),
            ],
          ),
        ),
        Text(
          EnumToString.parseCamelCase(player.team),
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                offset: Offset(1, 1),
                blurRadius: 5,
              ),
            ],
          ),
        ),
      ],
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
          notes: rng.nextBool()
              ? "Where do random thoughts come from?\nA song can make or ruin a person’s day if they let it get to them."
              : ""),
    );
  }
  return report;
}
