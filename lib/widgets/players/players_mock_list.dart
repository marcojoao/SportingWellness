import 'package:meta/meta.dart';
import 'package:Wellness/model/player.dart';
import 'package:sporting_performance/model/report.dart';

final List<Player> players = <Player>[
  Player(
      name: 'anderson',
      age: 220,
      escalao: EscalaoType.juniors,
      dominantMember: BodySide.left,
      higth: 190,
      avatarPath: 'ww',
      birthDate: DateTime.now()),
  Player(
      name: 'Marco',
      team: TeamType.u_23,
      height: 190,
      weight: 80,
      dominantMember: BodySide.left,
      avatarPath: 'ww',
      birthDate: DateTime.now()),
  Player(
      name: 'Ricardo',
      team: TeamType.woman,
      height: 190,
      weight: 80,
      avatarPath: 'ww',
      dominantMember: BodySide.left,
      birtDate: DateTime.now())
];
