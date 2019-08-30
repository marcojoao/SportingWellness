import 'package:Wellness/model/dao/player_dao.dart';
import 'package:Wellness/tests/players_mock_list.dart';
import 'package:flutter/material.dart';

class DashBoardMock extends StatefulWidget {
  DashBoardMock({Key key}) : super(key: key);

  _DashBoardMockState createState() => _DashBoardMockState();
}

class _DashBoardMockState extends State<DashBoardMock> {
  @override
  Widget build(BuildContext context) {
    //PlayersDAO _playerDao = PlayersDAO();
    return Scaffold(
        body: Center(
      child: Column(
        children: <Widget>[
          FlatButton(
            child: Text("Add Players"),
            onPressed: () {
              //var player = await _playerDao.getAllSortedByName();
              var player = players[0];
              if (player != null) {
                Navigator.of(context).pushNamed(
                  '/playerdetail',
                  arguments: player,
                );
              } else {
                Navigator.of(context).pushNamed('/mockdashboard');
              }
            },
          ),
          FlatButton(
            child: Text("Player page"),
            onPressed: () {},
          ),
        ],
      ),
    ));
  }
}
