import 'dart:math';

import 'package:Wellness/model/player.dart';
import 'package:Wellness/model/report.dart';
import 'package:Wellness/model/report_data_source.dart';
import 'package:Wellness/widgets/general/floating_action_menu.dart';
import 'package:Wellness/widgets/players/players_mock_list.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PlayerDetailContainerDebug extends StatefulWidget {
  Player player;
  PlayerDetailContainerDebug({Key key, this.player}) : super(key: key);
  @override
  _PlayerDetailContainerDebugState createState() =>
      _PlayerDetailContainerDebugState();
}

class _PlayerDetailContainerDebugState
    extends State<PlayerDetailContainerDebug> {
  Player _selectedItem;
  double _leftPanelWidthSize = 250;
  @override
  void initState() {
    super.initState();
    setState(
      () {
        _selectedItem = widget.player ?? players[0];
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildDebug(context, _selectedItem);
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
            backgroundColor: Theme.of(context).cardColor,
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
            backgroundColor: Theme.of(context).cardColor,
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

  Widget _buildRigtPanel(BuildContext context, Player player) {
    return new Expanded(
      child: new Container(
        child: new Column(
          children: <Widget>[
            new Container(
              margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 5),
              child: new Card(
                child: new Container(
                  margin: EdgeInsets.all(10),
                  child: chartExample(context, player),
                ),
              ),
              alignment: Alignment.center,
              height: 250,
            ),
            new Expanded(
              child: new Container(
                margin:
                    EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 10),
                child: new Card(
                  child: new Container(
                    child: _buildReportDateTables(context, player),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 65),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDebug(BuildContext context, Player player) {
    if (player.reports == null) player.reports = randomReports();

    return new Scaffold(
      floatingActionButton: _buildFloatingMenu(context),
      body: new Container(
        child: new Row(
          children: <Widget>[
            _buildLeftPanel(context, player),
            _buildRigtPanel(context, player)
          ],
        ),
      ),
    );
  }

  PaginatedDataTable _buildReportDateTables(
      BuildContext context, Player player) {
    return PaginatedDataTable(
      rowsPerPage: 5,
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

List<Report> randomReports() {
  List<Report> report = new List<Report>();
  Random rng = new Random();
  var playerId = rng.nextInt(1000);
  for (var i = 1; i <= 12; i++) {
    report.add(
      Report(
          playerId: playerId,
          dateTime: DateTime.utc(DateTime.now().year, i, 1),
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
          selected: false),
    );
  }
  return report;
}

Widget chartExample(BuildContext context, Player player) {
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
        ChartTitle(text: "${player.name} recovery over ${DateTime.now().year}"),
    tooltipBehavior: TooltipBehavior(enable: true),
    series: <LineSeries<Report, String>>[
      LineSeries<Report, String>(
        color: Theme.of(context).accentColor,
        dataSource: player.reports,
        xValueMapper: (Report report, _) =>
            '${DateFormat('MMMM').format(report.dateTime).substring(0, 3)}',
        yValueMapper: (Report report, _) => report.recovery,
        markerSettings: MarkerSettings(color: Colors.white, isVisible: true),
      )
    ],
  );
}
