import 'package:enum_to_string/enum_to_string.dart';
import 'package:sporting_performance/widgets/players/players_mock_list.dart'; //mock DATA
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:sporting_performance/model/player.dart';

//------------------------------------------------------------

class PlayerHome extends StatefulWidget {
  final String title;
  PlayerHome({Key key, this.title}) : super(key: key);

  _PlayerHomeState createState() => _PlayerHomeState();
}

class _PlayerHomeState extends State<PlayerHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('drawe'),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            // DrawerHeader(
            //   // decoration: BoxDecoration(
            //   //     gradient: LinearGradient(
            //   //         colors: <Color>[Colors.green[700], Colors.green[300]])),
            //   child: Container(
            //     child: Column(
            //       children: <Widget>[
            //         _buildCoverImage(Size(800, 600)),
            //         _buildProfileImage(),
            //       ],
            //     ),
            //   ),
            // ),
            _buildCoverImage(Size(800, 600)),
            _buildProfileImage(),
            ListTile(
              title: Text('item1'),
            ),
            ListTile(
              title: Text('item2'),
            ),
            ListTile(
              title: Text('item3'),
            ),
            ListTile(
              title: Text('item4'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCoverImage(Size screenSize) {
    return Container(
      height: screenSize.height / 2.6,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Center(
      child: Container(
        width: 100.0,
        height: 100.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://robohash.org/andy'),
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
}

//------------------------------------------------------------

class ItemDetails extends StatelessWidget {
  ItemDetails({
    @required this.isInTabletLayout,
    @required this.item,
  });

  final bool isInTabletLayout;
  final Player item;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Widget content = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          item?.name ?? 'No item selected!',
          style: textTheme.headline,
        ),
        Text(
          EnumToString.parse(item?.escalao) ?? 'Please select one on the left.',
          style: textTheme.subhead,
        ),
      ],
    );

    if (isInTabletLayout) {
      return Center(child: content);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(item.name),
      ),
      body: Center(child: content),
    );
  }
}
