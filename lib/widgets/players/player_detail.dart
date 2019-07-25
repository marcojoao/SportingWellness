import 'package:enum_to_string/enum_to_string.dart';
import 'package:sporting_performance/widgets/players/players_mock_list.dart'; //mock DATA
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:sporting_performance/model/player.dart';

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
