//mock Data
import 'package:Wellness/model/tests/players_mock_list.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:Wellness/model/player.dart';

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
