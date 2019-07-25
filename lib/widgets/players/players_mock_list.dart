import 'package:meta/meta.dart';
import 'package:sporting_performance/model/player.dart';
import 'package:sporting_performance/model/report.dart';

final List<Player> players = <Player>[
  Player(
      name: 'anderson',
      age: 220,
      escalao: EscalaoType.juniors,
      dominantMember: BodySide.left,
      higth: 190,
      avatarPath: 'ww',
      birtDate: DateTime.now()),
  Player(
      name: 'Marco',
      age: 22,
      escalao: EscalaoType.juniors,
      higth: 190,
      dominantMember: BodySide.left,
      avatarPath: 'ww',
      birtDate: DateTime.now()),
  Player(
      name: 'ricardo',
      age: 22,
      escalao: EscalaoType.juniors,
      higth: 190,
      avatarPath: 'ww',
      dominantMember: BodySide.left,
      birtDate: DateTime.now())
];
