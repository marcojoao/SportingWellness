import 'package:meta/meta.dart';
import 'package:Wellness/model/player.dart';
import 'package:Wellness/model/report.dart';

final List<Player> players = <Player>[
  Player(
      name: 'anderson',
      team: TeamType.u_17,
      dominantMember: BodySide.left,
      height: 190,
      avatarPath: 'ww',
      birthDate: DateTime.now(),
      weight: 60),
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
      birthDate: DateTime.now())
];
