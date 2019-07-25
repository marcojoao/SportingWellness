import 'dart:math';

import 'package:camera/camera.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as ipath;
import 'package:path_provider/path_provider.dart';
import 'package:Wellness/model/player.dart';
import 'package:Wellness/widgets/players/player_listing.dart';
import 'package:Wellness/widgets/players/player_detail.dart';
import 'package:Wellness/widgets/camera_controller/camera_controller.dart';
import 'package:Wellness/widgets/players/players_mock_list.dart';

class PlayerDetailContainer extends StatefulWidget {
  Player player;
  PlayerDetailContainer({Key key, this.player}) : super(key: key);
  @override
  _PlayerDetailContainerState createState() => _PlayerDetailContainerState();
}

class _PlayerDetailContainerState extends State<PlayerDetailContainer> {
  static const int kTabletBreakpoint = 600;

  Player _selectedItem;
  CameraDescription cams;

  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedItem = widget.player ?? players[0];
      initCamera();
    });
  }

  void initCamera() async {
    var camList = await availableCameras();
    for (var item in camList) {
      if (item.lensDirection == CameraLensDirection.front) {
        this.cams = item;
      }
    }
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

  Widget _buildButtons() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          RawMaterialButton(
            onPressed: () async {
              try {
                final path = ipath.join(
                  (await getTemporaryDirectory()).path,
                  '${DateTime.now()}.png',
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TakePictureScreen(camera: cams)),
                );
              } catch (e) {
                print(e);
              }
            },
            child: Icon(
              Icons.camera_alt,
              color: Colors.blue,
              size: 35.0,
            ),
            shape: new CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(15.0),
          ),
          RawMaterialButton(
            onPressed: () {},
            child: Icon(
              Icons.edit,
              color: Colors.blue,
              size: 35.0,
            ),
            shape: new CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(15.0),
          ),
        ]);
  }

  Widget _buildTabletLayout(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
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
                      _buildCoverImage(screenSize),
                      SafeArea(
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: screenSize.height / 9),
                              _buildProfileImage(),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  _buildButtons(),
                  _buildPlayerInfo(_selectedItem)
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
            image: AssetImage('assets/avatar.png'),
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
    TextStyle _statLabelTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 22,
      fontWeight: FontWeight.w200,
    );

    TextStyle _statCountTextStyle = TextStyle(
      color: Colors.black54,
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
    );

    return Column(
      children: <Widget>[
        _buildStatItem('Name', player.name.toString()),
        _buildStatItem('Birth Date',
            '${player.birthDate.day} / ${player.birthDate.month} /${player.birthDate.year}'),
        _buildStatItem('Dominant member',
            EnumToString.parseCamelCase(player.dominantMember)),
        _buildStatItem('Heigth', player.height.toString()),
        _buildStatItem(
            'Weigth', EnumToString.parseCamelCase(player.dominantMember)),
      ],
    );
  }

  Widget _buildStatItem(String label, String val) {
    TextStyle _statLabelTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.w200,
    );

    TextStyle _statCountTextStyle = TextStyle(
      color: Colors.black54,
      fontSize: 24.0,
      fontWeight: FontWeight.w400,
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
      appBar: AppBar(
        title: Text('Sport'),
      ),
      body: content,
    );
  }
}
