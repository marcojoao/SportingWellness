import 'dart:io';
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
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
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

  File _debugImage;

  @override
  void initState() {
    super.initState();
    setState(
      () {
        _selectedItem = widget.selectedPlayer ?? players[1];
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
            child: Stack(
              children: <Widget>[
                _buildBackgroundHeader(context, _debugImage),
                new Positioned(
                  top: 0,
                  left: 0,
                  child: new BackButton(color: Colors.white),
                ),
                new Positioned(
                  bottom: 18,
                  right: 12,
                  child: _buildPlayerEdit(context),
                ),
              ],
            ),
          ),
          Container(
            child: _buildPlayerInfo(context, player),
            alignment: Alignment.topLeft,
            margin: EdgeInsets.all(5),
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
                child: _buildReportDateTables(context, player, date)),
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
          name: "Recovery",
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
      BuildContext context, Player player, DateTime date) {
    return PaginatedDataTable(
      rowsPerPage: (player.reports.length < _reportPerPage)
          ? player.reports.length
          : _reportPerPage,
      columnSpacing: 40,
      header: Text('Reports over ${DateFormat('MMMM').format(date)}'),
      columns: ReportDataSource.getDataColumn,
      source: ReportDataSource(context, player.reports),
    );
  }

  Widget _buildPlayerEdit(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _editAvatarDialogBox(context),
      elevation: 0,
      mini: true,
      child: Icon(
        Icons.edit,
        color: Theme.of(context).accentColor,
      ),
      backgroundColor: Colors.white,
    );
  }

  Future getImage(ImageSource imgSource) async {
    var image = await ImagePicker.pickImage(source: imgSource);
    setState(() {
      if (image != null) _debugImage = image;
    });
  }

  Future<void> _editAvatarDialogBox(BuildContext context) {
    var accentColor = Theme.of(context).accentColor;
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(24.0),
            ),
          ),
          contentPadding: EdgeInsets.all(0),
          content: Container(
            width: 300.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  height: 60,
                  child: FlatButton(
                    onPressed: () async => {
                      Navigator.pop(context, null),
                      await getImage(ImageSource.camera),
                    },
                    child: Text(
                      "Take a picture",
                      textAlign: TextAlign.center,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24.0),
                        topRight: Radius.circular(24.0),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 60,
                  child: FlatButton(
                    onPressed: () async => {
                      Navigator.pop(context, null),
                      await getImage(ImageSource.gallery),
                    },
                    child: Text(
                      "Choose a picture",
                      textAlign: TextAlign.center,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(24.0),
                        bottomRight: Radius.circular(24.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBackgroundHeader(BuildContext context, File file) {
    return new DiagonallyCutColoredImage(
      Image.asset(
        file == null ? Player.defaultAvatar : file.path,
      ),
      color: Colors.black.withOpacity(0.3),
    );
  }

  Widget _buildPlayerInfo(BuildContext context, Player player) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Text(
          player.name,
          style: Theme.of(context)
              .textTheme
              .headline
              .copyWith(color: Colors.white),
        ),
        new Padding(
          padding: const EdgeInsets.only(top: 10),
        ),
        Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                new Padding(
                  child: _buildPlayerTeam(context, player),
                  padding: const EdgeInsets.only(right: 5, left: 5),
                ),
                new Padding(
                  child: _buildPlayerDominantMember(context, player),
                  padding: const EdgeInsets.only(right: 5, left: 5),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 0),
              child: Row(
                children: <Widget>[
                  new Padding(
                    child: _buildPlayerHeight(context, player),
                    padding: const EdgeInsets.only(right: 5, left: 5),
                  ),
                  new Padding(
                    child: _buildPlayerWeight(context, player),
                    padding: const EdgeInsets.only(right: 5, left: 5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPlayerHeight(BuildContext context, Player player) {
    return new Row(
      children: <Widget>[
        CircleAvatar(
          backgroundColor: Colors.white12,
          child: Padding(
            padding: EdgeInsets.all(6),
            child: SvgPicture.asset(
              "assets/height.svg",
              color: Colors.white,
            ),
          ),
          radius: 14,
        ),
        new Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: new Text(
            "${player.height} cm",
            style: Theme.of(context)
                .textTheme
                .subhead
                .copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildPlayerWeight(BuildContext context, Player player) {
    return new Row(
      children: <Widget>[
        CircleAvatar(
          backgroundColor: Colors.white12,
          child: Padding(
            padding: EdgeInsets.all(4),
            child: SvgPicture.asset(
              "assets/weight.svg",
              color: Colors.white,
            ),
          ),
          radius: 14,
        ),
        new Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: new Text(
            "${player.weight} kg",
            style: Theme.of(context)
                .textTheme
                .subhead
                .copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildPlayerDominantMember(BuildContext context, Player player) {
    return new Row(
      children: <Widget>[
        CircleAvatar(
          backgroundColor: Colors.white12,
          child: Padding(
            padding: EdgeInsets.all(4),
            child: SvgPicture.asset(
              "assets/leg.svg",
              color: Colors.white,
            ),
          ),
          radius: 14,
        ),
        new Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: new Text(
            "${EnumToString.parseCamelCase(player.dominantMember)} foot",
            style: Theme.of(context)
                .textTheme
                .subhead
                .copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildPlayerTeam(BuildContext context, Player player) {
    return new Row(
      children: <Widget>[
        CircleAvatar(
          backgroundColor: Colors.white12,
          child: Padding(
            padding: EdgeInsets.all(3),
            child: SvgPicture.asset("assets/teams.svg", color: Colors.white),
          ),
          radius: 14,
        ),
        new Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: new Text(
            EnumToString.parseCamelCase(player.team),
            style: Theme.of(context)
                .textTheme
                .subhead
                .copyWith(color: Colors.white),
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
