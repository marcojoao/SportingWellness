import 'package:Wellness/model/player.dart';
import 'package:Wellness/widgets/players/charts_player_details.dart';
import 'package:Wellness/widgets/players/player_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

final _player = Player(
    name: 'Marco',
    team: TeamType.sub23,
    height: 190,
    weight: 80,
    avatarPath: 'ww',
    birthDate: DateTime.now(),
    dominantMember: null);

void main() {
//   test('find add button', (WidgetTester tester) async {
//     await tester.pumpWidget(ItemDetails(isInTabletLayout: true, item: _player));
// //
//     await tester.tap(find.byType(Icon));
//     expect(find.byTooltip('Add'), findsOneWidget);
//   });

//   test('test _chartITem', (WidgetTester tester) async {
//     await tester.pumpWidget(
//       MaterialApp(
//         home:
//             Scaffold(body: ItemDetails(isInTabletLayout: true, item: _player)),
//       ),
//     );

//     expect(find.byType(LineChartPlayer), findsOneWidget);
//   });
}
