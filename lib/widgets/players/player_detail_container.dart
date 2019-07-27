import 'dart:io';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

  Widget _buildButtons() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          OutlineButton(
            onPressed: () async {
              editAvatarDialogBox();
            },
            child: Icon(Icons.edit),
            shape: new CircleBorder(),
          ),
        ]);
  }

  Widget _buildTabletLayout(BuildContext context) {
    return Row(
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Material(
              elevation: 4.0,
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      SafeArea(
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              _buildProfileImage(),
                              _buildButtons(),
                              _buildPlayerInfo(_selectedItem)
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              )),
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

  Widget _buildCoverImage(Size screenSize) {
    return Container(
      height: screenSize.height / 4.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/background.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Center(
      child: Container(
        width: 140.0,
        height: 140.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image:
                AssetImage(_image == null ? 'assets/avatar.png' : _image.path),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(80.0),
          border: Border.all(
            color: Colors.white,
            width: 10.0,
          ),
        ),
      ),
    );
  }

  Widget _buildPlayerInfo(Player player) {
    return Column(
      children: <Widget>[
        _buildStatItem('Name', player.name),
        _buildStatItem('Birth Date',
            '${player.birthDate.day} / ${player.birthDate.month} /${player.birthDate.year}'),
        _buildStatItem('Dominant member',
            EnumToString.parseCamelCase(player.dominantMember)),
        _buildStatItem('Heigth', player.height.toString()),
        _buildStatItem('Weigth', player.weight.toString()),
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
