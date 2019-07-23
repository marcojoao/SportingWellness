import 'package:sporting_performance/widgets/players/players_mock_list.dart'; //mock Data
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:sporting_performance/model/player.dart';

class ItemListing extends StatelessWidget {
  ItemListing({
    @required this.itemSelectedCallback,
    this.selectedItem,
  });

  final ValueChanged<Player> itemSelectedCallback;
  final Player selectedItem;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: players.map((item) {
        return ListTile(
          title: Text(item.name),
          onTap: () => itemSelectedCallback(item),
          selected: selectedItem == item,
        );
      }).toList(),
    );
  }
}
