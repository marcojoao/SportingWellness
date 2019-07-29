import 'package:enum_to_string/enum_to_string.dart';
import 'package:Wellness/widgets/players/players_mock_list.dart'; //mock DATA
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:meta/meta.dart';
import 'package:Wellness/model/player.dart';

import 'charts_player_details.dart';

class ItemDetails extends StatelessWidget {
  ItemDetails({
    @required this.isInTabletLayout,
    @required this.item,
  });

  final bool isInTabletLayout;
  final Player item;

  Widget _listReports(IconData icon, String heading, int color) {
    return Center(
      child: Material(
        color: Colors.white,
        elevation: 8,
        shadowColor: Color.fromARGB(243, 128, 33, 150),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(heading,
                        style: TextStyle(color: Colors.black, fontSize: 20.0)),
                  ),
                ),
                Material(
                  color: Color.fromARGB(243, 128, 33, 150),
                  borderRadius: BorderRadius.circular(24.0),
                  child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Icon(
                        icon,
                        color: Colors.white,
                        size: 30.0,
                      )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[_addReportButton()],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _addReportButton() {
    return Container(
        width: 80.0,
        height: 80.0,
        child: FittedBox(
          child: FloatingActionButton(child: Icon(Icons.add), onPressed: () {}),
        ));
  }

  Widget _buildReportListHeader() {
    return Center(
        child: Material(
            color: Colors.white,
            elevation: 8,
            shadowColor: Color.fromARGB(243, 128, 33, 150),
            child: Center(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Center(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('heading',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 10.0)),
                          )),
                        ])))));
  }

  Widget _chartITem(String heading, Color color, double height, double width) {
    return Center(
        child: Material(
            color: Colors.white,
            elevation: 8,
            shadowColor: Color.fromARGB(243, 128, 33, 150),
            child: LineChartPlayer()));
  }

  @override
  Widget build(BuildContext context) {
    final _sizeHeigth = MediaQuery.of(context).size.height;

    final Widget content = StaggeredGridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 12.0,
      mainAxisSpacing: 12.0,
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      children: <Widget>[
        _chartITem('Soroness', Colors.black, 100, 100),
        _chartITem('Pain', Colors.black, 100, 100),
        _buildReportListHeader(),
        _listReports(Icons.graphic_eq, "Total Reports", 0xffed22b),
      ],
      staggeredTiles: [
        StaggeredTile.extent(1, _sizeHeigth * 0.25),
        StaggeredTile.extent(1, _sizeHeigth * 0.25),
        StaggeredTile.extent(2, _sizeHeigth * 0.1),
        StaggeredTile.extent(2, _sizeHeigth * 0.57),
      ],
    );
    // Column(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: [
    //     Text(
    //       item?.name ?? 'No item selected!',
    //       style: textTheme.headline,
    //     ),
    //     Text(
    //       EnumToString.parse(item?.team) ?? 'Please select one on the left.',
    //       style: textTheme.subhead,
    //     ),
    //   ],
    // );

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
