import 'package:Wellness/model/report.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:Wellness/widgets/players/players_mock_list.dart'; //mock DATA
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
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

  Widget _listReports(
      IconData icon, String heading, int color, BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 8,
      shadowColor: Color.fromARGB(243, 128, 33, 150),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // ListView.builder(

          // ),
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
            children: <Widget>[_addReportButton(context)],
          )
        ],
      ),
    );
  }

  Widget _addReportButton(BuildContext context) {
    return Container(
        width: 50.0,
        height: 50.0,
        child: FittedBox(
          child: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                _addReport(context);
              }),
        ));
  }

  Widget _buildReportListHeader() {
    final labelStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.w200,
    );
    return Material(
        color: Colors.white,
        elevation: 8,
        shadowColor: Color.fromARGB(243, 128, 33, 150),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text('Date', style: labelStyle),
            Text('Cpompleted', style: labelStyle),
          ],
        ));
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
        _listReports(Icons.graphic_eq, "Total Reports", 0xffed22b, context),
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

  Future<void> _addReport(BuildContext context) {
    final GlobalKey<FormBuilderState> _formKey =
        new GlobalKey<FormBuilderState>();
    final labelStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.w200,
    );
    print('_ADDREPORT');
    return showDialog(
      barrierDismissible: true,
      builder: (BuildContext context) {
        return SimpleDialog(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              child: FormBuilder(
                key: _formKey,
                autovalidate: true,
                child: Column(
                  children: <Widget>[
                    Text('Add Reportinformation', style: labelStyle),
                    Padding(padding: EdgeInsets.only(top: 2, bottom: 2)),
                    FormBuilderDropdown(
                      attribute: "sleepState",
                      decoration: InputDecoration(labelText: "Sleep State"),
                      initialValue: SleepState.good,
                      hint: Text('Sleep State'),
                      validators: [FormBuilderValidators.required()],
                      items: SleepState.values
                          .map((side) => DropdownMenuItem(
                              value: side,
                              child: Text(EnumToString.parseCamelCase(side))))
                          .toList(),
                    ),
                    FormBuilderRate(
                      decoration: InputDecoration(labelText: "Recovery"),
                      attribute: "recovery",
                      iconSize: 32.0,
                      initialValue: 1,
                      max: 5,
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      },
      context: context,
    );
  }
}
