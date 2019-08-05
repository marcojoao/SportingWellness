import 'dart:io';
import 'dart:math';

import 'package:Wellness/model/player.dart';
import 'package:Wellness/model/report.dart';
import 'package:Wellness/model/report_data_source.dart';
import 'package:Wellness/tests/players_mock_list.dart';
import 'package:Wellness/services/app_localizations.dart';
import 'package:Wellness/widgets/general/diagonally_cut_image.dart';
import 'package:Wellness/widgets/general/floating_action_menu.dart';
import 'package:date_util/date_util.dart';
import 'package:enum_to_string/enum_to_string.dart';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:root_checker/root_checker.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PlayerDetailContainer extends StatefulWidget {
  Player selectedPlayer;
  DateTime selectedDate;
  PlayerDetailContainer({Key key, this.selectedPlayer, this.selectedDate})
      : super(key: key);
  @override
  _PlayerDetailContainerState createState() => _PlayerDetailContainerState();
}

class _PlayerDetailContainerState extends State<PlayerDetailContainer> {
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
        _checkDeviceSecure();
        _selectedItem = widget.selectedPlayer ?? players[0];
        _selectedDate = widget.selectedDate ?? DateTime.now();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
        connectivityBuilder: (BuildContext context,
            ConnectivityResult connectivity, Widget child) {
          return _buildScaffold(_selectedItem, _selectedDate);
        },
        child: Container());
  }

  Future _checkDeviceSecure() async {
    bool isDeviceSecure = await RootChecker.isDeviceRooted;
    if (isDeviceSecure)
      _showMessageDialog(
        AppLocalizations.translate("warning"),
        Text(
          AppLocalizations.translate("yourDeviceIsNotSecure"),
          textAlign: TextAlign.center,
        ),
      );
  }

  Widget _buildFloatingMenu() {
    return FloatingActionMenu(
      closedColor: Theme.of(context).accentColor,
      children: [
        Container(
          child: FloatingActionButton(
            heroTag: "addReport",
            mini: true,
            onPressed: () => {
              // Fluttertoast.showToast(
              //     msg: "Add Report",
              //     toastLength: Toast.LENGTH_SHORT,
              //     timeInSecForIos: 1),
            },
            backgroundColor: Colors.white,
            child: Icon(Icons.add, color: Theme.of(context).accentColor),
          ),
        ),
        Container(
          child: FloatingActionButton(
            heroTag: "editProfile",
            mini: true,
            onPressed: () => {
              // Fluttertoast.showToast(
              //     msg: "Edit Profile",
              //     toastLength: Toast.LENGTH_SHORT,
              //     timeInSecForIos: 1),
            },
            backgroundColor: Colors.white,
            child: Icon(Icons.edit, color: Theme.of(context).accentColor),
          ),
        ),
      ],
    );
  }

  Widget _buildLeftPanel(Player player) {
    return new Container(
      width: _leftPanelWidthSize,
      color: Theme.of(context).accentColor,
      child: Column(
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                _buildBackgroundHeader(_debugImage),
                new Positioned(
                  top: 0,
                  left: 0,
                  child: new BackButton(color: Colors.white),
                ),
                new Positioned(
                  bottom: 18,
                  right: 12,
                  child: _buildPlayerEdit(),
                ),
              ],
            ),
          ),
          Container(
            child: _buildPlayerInfo(player),
            alignment: Alignment.topLeft,
            margin: EdgeInsets.all(5),
          ),
        ],
      ),
    );
  }

  Widget _buildRightPanel(Player player, DateTime date) {
    return new Expanded(
      child: new Container(
        color: Theme.of(context).primaryColor,
        child: new ListView(
          children: <Widget>[
            new Container(
              margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 5),
              child: new Card(
                child: new Container(
                  child: _buildChart(player, date),
                ),
              ),
              alignment: Alignment.center,
              height: 250,
            ),
            Container(
                margin:
                    EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 80),
                child: _buildReportDateTables(player, date)),
          ],
        ),
      ),
    );
  }

  Widget _buildScaffold(Player player, DateTime date) {
    if (player.reports == null) player.reports = randomDayReports(date);
    return new Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: "FaAdd",
        onPressed: () {
          _showReportDialog(player, true);
        },
        child: Icon(Icons.add),
      ),
      body: _buildPainels(player, date),
    );
  }

  Widget _buildPainels(Player player, DateTime date) {
    return Container(
      child: Row(
        children: <Widget>[
          _buildLeftPanel(player),
          _buildRightPanel(player, date)
        ],
      ),
    );
  }

  Widget _buildChart(Player player, DateTime date) {
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
      title: ChartTitle(
          text:
              "${AppLocalizations.translate('recoveryOver')} ${DateFormat('MMMM').format(date)}"),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <LineSeries<Report, String>>[
        LineSeries<Report, String>(
          name: AppLocalizations.translate('recovery'),
          color: Theme.of(context).accentColor,
          dataSource: player.reports,
          xValueMapper: (Report report, _) => report.dateTime.day.toString(),
          yValueMapper: (Report report, _) => report.recovery,
          markerSettings: MarkerSettings(color: Colors.white, isVisible: true),
        )
      ],
    );
  }

  PaginatedDataTable _buildReportDateTables(Player player, DateTime date) {
    return PaginatedDataTable(
      rowsPerPage: (player.reports.length < _reportPerPage)
          ? player.reports.length
          : _reportPerPage,
      columnSpacing: 40,
      header: Text(
          '${AppLocalizations.translate('reportsOver')} ${DateFormat('MMMM').format(date)}'),
      columns: ReportDataSource.getDataColumn,
      source: ReportDataSource(context, player.reports),
    );
  }

  Widget _buildPlayerEdit() {
    return FloatingActionButton(
      onPressed: () => _editAvatarDialog(),
      elevation: 0,
      mini: true,
      child: Icon(
        Icons.edit,
        color: Theme.of(context).accentColor,
      ),
      backgroundColor: Colors.white,
    );
  }

  Future _getImage(ImageSource imgSource) async {
    var image = await ImagePicker.pickImage(source: imgSource);
    setState(() {
      if (image != null) _debugImage = image;
    });
  }

  Future<void> _editAvatarDialog() {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12.0),
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
                      await _getImage(ImageSource.camera),
                    },
                    child: Text(
                      AppLocalizations.translate("takePicture"),
                      textAlign: TextAlign.center,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.0),
                        topRight: Radius.circular(12.0),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 60,
                  child: FlatButton(
                    onPressed: () async => {
                      Navigator.pop(context, null),
                      await _getImage(ImageSource.gallery),
                    },
                    child: Text(
                      AppLocalizations.translate("choosePicture"),
                      textAlign: TextAlign.center,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12.0),
                        bottomRight: Radius.circular(12.0),
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

  Widget _buildBackgroundHeader(File file) {
    return new DiagonallyCutImage(
      Image.asset(
        file == null ? Player.defaultAvatar : file.path,
        fit: BoxFit.cover,
        alignment: Alignment.topCenter,
        height: 300,
      ),
      color: Colors.black.withOpacity(0.3),
    );
  }

  Widget _buildPlayerInfo(Player player) {
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
                  child: _buildPlayerTeam(player),
                  padding: const EdgeInsets.only(right: 5, left: 5),
                ),
                new Padding(
                  child: _buildPlayerDominantMember(player),
                  padding: const EdgeInsets.only(right: 5, left: 5),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 0),
              child: Row(
                children: <Widget>[
                  new Padding(
                    child: _buildPlayerHeight(player),
                    padding: const EdgeInsets.only(right: 5, left: 5),
                  ),
                  new Padding(
                    child: _buildPlayerWeight(player),
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

  Widget _buildPlayerHeight(Player player) {
    return new Row(
      children: <Widget>[
        CircleAvatar(
          backgroundColor: Colors.white12,
          child: Padding(
            padding: EdgeInsets.all(6),
            child: SvgPicture.asset(
              "assets/height.svg",
              color: Colors.white,
              width: 100,
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

  Widget _buildPlayerWeight(Player player) {
    return new Row(
      children: <Widget>[
        CircleAvatar(
          backgroundColor: Colors.white12,
          child: Padding(
            padding: EdgeInsets.all(4),
            child: SvgPicture.asset(
              "assets/weight.svg",
              color: Colors.white,
              width: 100,
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

  Widget _buildPlayerDominantMember(Player player) {
    return new Row(
      children: <Widget>[
        CircleAvatar(
          backgroundColor: Colors.white12,
          child: Padding(
            padding: EdgeInsets.all(4),
            child: SvgPicture.asset(
              "assets/leg.svg",
              color: Colors.white,
              width: 100,
            ),
          ),
          radius: 14,
        ),
        new Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: new Text(
            AppLocalizations.translate(
                EnumToString.parse(player.dominantMember)),
            style: Theme.of(context)
                .textTheme
                .subhead
                .copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildPlayerTeam(Player player) {
    var team = EnumToString.parseCamelCase(player.team).split(" ");
    var teamName = AppLocalizations.translate(team[0].toLowerCase());
    if (team.length > 1) {
      teamName = "$teamName ${team[1]}";
    }
    return new Row(
      children: <Widget>[
        CircleAvatar(
          backgroundColor: Colors.white12,
          child: Padding(
            padding: EdgeInsets.all(3),
            child: SvgPicture.asset(
              "assets/teams.svg",
              color: Colors.white,
              width: 100,
            ),
          ),
          radius: 14,
        ),
        new Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: new Text(
            teamName,
            style: Theme.of(context)
                .textTheme
                .subhead
                .copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Future<void> _showReportDialog(Player player, bool create) {
    final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
    var width = 400.0;
    var height = 400.0;
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
          contentPadding: EdgeInsets.only(top: 10.0),
          content: Container(
            width: width,
            height: height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  height: 350,
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: Text(
                          AppLocalizations.translate("createReport"),
                          style: TextStyle(fontSize: 24.0),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Divider(
                        color: Colors.grey,
                        height: 5.0,
                      ),
                      Container(
                        margin: EdgeInsets.all(20),
                        height: 270,
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              FormBuilder(
                                key: _fbKey,
                                initialValue: {
                                  'date': DateTime.now(),
                                  'accept_terms': false,
                                },
                                autovalidate: true,
                                child: Column(
                                  children: <Widget>[
                                    FormBuilderDateTimePicker(
                                      attribute: "date",
                                      inputType: InputType.date,
                                      format: DateFormat("yyyy-MM-dd"),
                                      decoration: InputDecoration(
                                          labelText: "Appointment Time"),
                                    ),
                                    FormBuilderSlider(
                                      attribute: "slider",
                                      validators: [
                                        FormBuilderValidators.min(6)
                                      ],
                                      min: 0.0,
                                      max: 10.0,
                                      initialValue: 1.0,
                                      divisions: 20,
                                      decoration: InputDecoration(
                                          labelText: "Number of things"),
                                    ),
                                    FormBuilderCheckbox(
                                      attribute: 'accept_terms',
                                      label: Text(
                                          "I have read and agree to the terms and conditions"),
                                      validators: [
                                        FormBuilderValidators.requiredTrue(
                                          errorText:
                                              "You must accept terms and conditions to continue",
                                        ),
                                      ],
                                    ),
                                    FormBuilderDropdown(
                                      attribute: "gender",
                                      decoration:
                                          InputDecoration(labelText: "Gender"),
                                      // initialValue: 'Male',
                                      hint: Text('Select Gender'),
                                      validators: [
                                        FormBuilderValidators.required()
                                      ],
                                      items: ['Male', 'Female', 'Other']
                                          .map((gender) => DropdownMenuItem(
                                              value: gender,
                                              child: Text("$gender")))
                                          .toList(),
                                    ),
                                    FormBuilderTextField(
                                      attribute: "age",
                                      decoration:
                                          InputDecoration(labelText: "Age"),
                                      validators: [
                                        FormBuilderValidators.numeric(),
                                        FormBuilderValidators.max(70),
                                      ],
                                    ),
                                    FormBuilderSegmentedControl(
                                      decoration: InputDecoration(
                                          labelText: "Movie Rating (Archer)"),
                                      attribute: "movie_rating",
                                      options: List.generate(5, (i) => i + 1)
                                          .map((number) =>
                                              FormBuilderFieldOption(
                                                  value: number))
                                          .toList(),
                                    ),
                                    FormBuilderSwitch(
                                      label: Text(
                                          'I Accept the tems and conditions'),
                                      attribute: "accept_terms_switch",
                                      initialValue: true,
                                    ),
                                    FormBuilderStepper(
                                      decoration:
                                          InputDecoration(labelText: "Stepper"),
                                      attribute: "stepper",
                                      initialValue: 10,
                                      step: 1,
                                    ),
                                    FormBuilderRate(
                                      decoration: InputDecoration(
                                          labelText: "Rate this form"),
                                      attribute: "rate",
                                      iconSize: 32.0,
                                      initialValue: 1,
                                      max: 5,
                                    ),
                                    FormBuilderCheckboxList(
                                      decoration: InputDecoration(
                                          labelText:
                                              "The language of my people"),
                                      attribute: "languages",
                                      initialValue: ["Dart"],
                                      options: [
                                        FormBuilderFieldOption(value: "Dart"),
                                        FormBuilderFieldOption(value: "Kotlin"),
                                        FormBuilderFieldOption(value: "Java"),
                                        FormBuilderFieldOption(value: "Swift"),
                                        FormBuilderFieldOption(
                                            value: "Objective-C"),
                                      ],
                                    ),
                                    FormBuilderSignaturePad(
                                      decoration: InputDecoration(
                                          labelText: "Signature"),
                                      attribute: "signature",
                                      height: 100,
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  MaterialButton(
                                    child: Text("Submit"),
                                    onPressed: () {
                                      _fbKey.currentState.save();
                                      if (_fbKey.currentState.validate()) {
                                        print(_fbKey.currentState.value);
                                      }
                                    },
                                  ),
                                  MaterialButton(
                                    child: Text("Reset"),
                                    onPressed: () {
                                      _fbKey.currentState.reset();
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 50,
                        width: width * .5,
                        child: FlatButton(
                          onPressed: () => {
                            Navigator.pop(context),
                          },
                          child: Text(
                            AppLocalizations.translate("create"),
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          color: Theme.of(context).accentColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(12.0),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        width: width * .5,
                        child: FlatButton(
                          onPressed: () => {
                            Navigator.pop(context),
                          },
                          child: Text(
                            AppLocalizations.translate("cancel"),
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          color: Colors.red[400],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(12.0),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showMessageDialog(String title, Text msg) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
          contentPadding: EdgeInsets.only(top: 10.0),
          content: Container(
            width: 300.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 24.0),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Divider(
                  color: Colors.grey,
                  height: 4.0,
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: msg,
                  ),
                ),
                Container(
                  height: 50,
                  child: FlatButton(
                    onPressed: () => {
                      Navigator.pop(context),
                    },
                    child: Text(
                      AppLocalizations.translate("close"),
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    color: Theme.of(context).accentColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12.0),
                        bottomRight: Radius.circular(12.0),
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
          painNumber: rng.nextInt(5),
          notes: rng.nextBool()
              ? "Where do random thoughts come from?\nA song can make or ruin a person’s day if they let it get to them."
              : ""),
    );
  }
  return report;
}
