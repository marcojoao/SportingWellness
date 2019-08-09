import 'dart:io';

import 'package:Wellness/model/player.dart';
import 'package:Wellness/tests/players_mock_list.dart';
import 'package:Wellness/services/app_localizations.dart';
import 'package:Wellness/tests/report_mock.dart';

import 'package:Wellness/widgets/floating_action_menu.dart';
import 'package:Wellness/widgets/player/player_avatar.dart';
import 'package:Wellness/widgets/player/player_cartesian_chart.dart';
import 'package:Wellness/widgets/player/player_info.dart';
import 'package:Wellness/widgets/player/player_report_datatable.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:Wellness/utils/general.dart';

class PlayerPage extends StatefulWidget {
  Player selectedPlayer;
  DateTime selectedDate;

  PlayerPage({Key key, this.selectedPlayer, this.selectedDate})
      : super(key: key);
  @override
  _PlayerPageState createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
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
        checkDeviceSecure(context);
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

  Widget _buildScaffold(Player player, DateTime date) {
    //if (player.reports == null) player.reports = randomDayReports(date);
    return new Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: "FaAdd",
        onPressed: () {
          //_showReportDialog2();
          //_reportDialog2(player, true);
          randomDayReports(player, DateTime.now());
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

  Widget _buildLeftPanel(Player player) {
    return new Container(
      width: _leftPanelWidthSize,
      color: Theme.of(context).accentColor,
      child: Column(
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                PlayerAvatar(_debugImage),
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
            child: PlayerInfo(player),
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
                  child: PlayerCartesianChart(player, date),
                ),
              ),
              alignment: Alignment.center,
              height: 250,
            ),
            Container(
                margin:
                    EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 80),
                child: PlayerReportDatatable(player, date, _reportPerPage)),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayerEdit() {
    return FloatingActionButton(
      onPressed: () => _avatarDialog(),
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

  Future<void> _reportDialog(Player player, bool create) {
    final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
    var width = 520.0;
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
          contentPadding: EdgeInsets.only(top: 10.0),
          content: Container(
            width: width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          AppLoc.getValue("submitReport"),
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
                        height: 350,
                        child: Scrollbar(
                          child: SingleChildScrollView(
                            child: Container(
                              margin: EdgeInsets.all(20),
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
                                          decoration: InputDecoration(
                                              labelText: "Gender"),
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
                                              labelText:
                                                  "Movie Rating (Archer)"),
                                          attribute: "movie_rating",
                                          options:
                                              List.generate(5, (i) => i + 1)
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
                                          decoration: InputDecoration(
                                              labelText: "Stepper"),
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
                                            FormBuilderFieldOption(
                                                value: "Dart"),
                                            FormBuilderFieldOption(
                                                value: "Kotlin"),
                                            FormBuilderFieldOption(
                                                value: "Java"),
                                            FormBuilderFieldOption(
                                                value: "Swift"),
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
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        width: width * .5,
                        child: FlatButton(
                          onPressed: () => {
                            _fbKey.currentState.save(),
                            if (_fbKey.currentState.validate())
                              {
                                print(_fbKey.currentState.value),
                              },
                            Navigator.pop(context),
                          },
                          child: Text(
                            AppLoc.getValue("submit"),
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
                        width: width * .5,
                        child: FlatButton(
                          onPressed: () => {
                            _fbKey.currentState.reset(),
                            Navigator.pop(context),
                          },
                          child: Text(
                            AppLoc.getValue("cancel"),
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

  Future<void> _reportDialog2(Player player, bool create) {
    final basicSlider = CarouselSlider(
      items: [1, 2, 3, 4, 5].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: 520.0,
                //margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(color: Colors.amber),
                child: Text(
                  'text $i',
                  style: TextStyle(fontSize: 16.0),
                ));
          },
        );
      }).toList(),
      autoPlay: false,
      enlargeCenterPage: true,
      viewportFraction: 0.9,
      aspectRatio: 2.0,
    );
    var width = 520.0;
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
          contentPadding: EdgeInsets.only(top: 10.0),
          content: Container(
            width: width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          AppLoc.getValue("submitReport"),
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
                        height: 350,
                        child: basicSlider,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        width: width * .5,
                        child: FlatButton(
                          onPressed: () => basicSlider.previousPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.linear),
                          child: Text(
                            AppLoc.getValue("submit"),
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
                        width: width * .5,
                        child: FlatButton(
                          onPressed: () => basicSlider.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.linear),
                          child: Text(
                            AppLoc.getValue("cancel"),
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

  Future<void> _avatarDialog() {
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
                      AppLoc.getValue("takePicture"),
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
                      AppLoc.getValue("choosePicture"),
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
}
