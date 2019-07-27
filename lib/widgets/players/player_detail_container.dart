import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:Wellness/model/player.dart';
import 'package:Wellness/widgets/players/player_listing.dart';
import 'package:Wellness/widgets/players/player_detail.dart';
import 'package:Wellness/widgets/players/players_mock_list.dart';

class PlayerDetailContainer extends StatefulWidget {
  Player player;
  PlayerDetailContainer({Key key, this.player}) : super(key: key);
  @override
  _PlayerDetailContainerState createState() => _PlayerDetailContainerState();
}

class _PlayerDetailContainerState extends State<PlayerDetailContainer> {
  static const int kTabletBreakpoint = 600;
  File _image;

  Player _selectedItem;

  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedItem = widget.player ?? players[0];
    });
  }

  Widget _buildMobileLayout() {
    return ItemListing(
      itemSelectedCallback: (item) {
        Navigator.push(
          context,
          //TODO: Use routegenerator
          MaterialPageRoute(
            builder: (BuildContext context) {
              return ItemDetails(
                isInTabletLayout: false,
                item: item,
              );
            },
          ),
        );
      },
    );
  }

  Future<void> editAvatarDialogBox() {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return SimpleDialog(
            children: <Widget>[
              ListTile(
                leading: new Icon(Icons.photo_camera),
                title: new Text('Take a picture'),
                onTap: () async {
                  await getImage(ImageSource.camera);
                  Navigator.pop(context, null);
                },
              ),
              ListTile(
                leading: new Icon(Icons.photo),
                title: new Text('Choose a picture'),
                onTap: () async {
                  await getImage(ImageSource.gallery);
                  Navigator.pop(context, null);
                },
              ),
            ],
          );
        });
  }

  Future getImage(ImageSource imgSource) async {
    var image = await ImagePicker.pickImage(source: imgSource);

    setState(() {
      _image = image;
    });
  }

  Widget _buildTabletLayout(BuildContext context) {
    return Row(
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Material(
            elevation: 4.0,
            child: Container(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: 230,
                      color: Colors.green,
                      child: SafeArea(
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              alignment: Alignment.topLeft,
                              child: FlatButton(
                                  child: Icon(Icons.edit, color: Colors.white),
                                  color: Colors.redAccent,
                                  shape: CircleBorder(),
                                  onPressed: editAvatarDialogBox),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(padding: EdgeInsets.all(15.0)),
                                Container(
                                  height: 100,
                                  width: 100,
                                  margin: const EdgeInsets.all(5),
                                  decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage(_image == null
                                          ? 'assets/avatar.png'
                                          : _image.path),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    _selectedItem.name,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 24.0, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Container(
                      //mainAxisSize: MainAxisSize.min,
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      margin: const EdgeInsets.only(left: 10, right: 10),

                      child: _buildPlayerInfo(_selectedItem),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Flexible(
          flex: 3,
          child: ItemDetails(
            isInTabletLayout: true,
            item: _selectedItem,
          ),
        ),
      ],
    );
  }

  Widget _buildPlayerInfo(Player player) {
    return Column(
      children: <Widget>[
        Row(children: <Widget>[
          Icon(Icons.cake),
          Text(
              '  ${player.birthDate.day} / ${player.birthDate.month} /${player.birthDate.year}')
        ]),
        Padding(padding: EdgeInsets.all(2.0)),
        Row(children: <Widget>[
          Icon(Icons.accessibility_new),
          Text(EnumToString.parseCamelCase(player.dominantMember))
        ]),
        Padding(padding: EdgeInsets.all(2.0)),
        Row(children: <Widget>[ Icon(Icons.ac_unit),Text('  ${player.height}')
        ]),
        Padding(padding: EdgeInsets.all(2.0)),
        Row(children: <Widget>[Icon(Icons.ac_unit), Text('  ${player.weight}')
        ]),
      ],
    );
  }

  TextStyle _statCountTextStyle = TextStyle(
    color: Colors.black54,
    fontSize: 24.0,
    fontWeight: FontWeight.w400,
  );

  Widget _buildStatItem(String label, String val) {
    TextStyle _statLabelTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.w200,
    );

    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          children: <Widget>[
            Text('${label}:  ', style: _statCountTextStyle),
            Text(
              val,
              style: _statLabelTextStyle,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatus(BuildContext context, String name) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        name,
        style: TextStyle(
          fontFamily: 'Spectral',
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    Size screenSize = MediaQuery.of(context).size;
    var shortestSide = MediaQuery.of(context).size.shortestSide;

    if (shortestSide < kTabletBreakpoint) {
      content = _buildTabletLayout(context); //build mobilelayout
    } else {
      content = _buildTabletLayout(context);
    }

    return Scaffold(
      body: content,
    );
  }
}
