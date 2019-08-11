import 'package:Wellness/model/player.dart';
import 'package:Wellness/model/report.dart';

final List<Player> players = <Player>[
  Player(
      id: 1,
      name: 'Anderson Cançado',
      team: TeamType.under17,
      dominantMember: BodySide.left,
      height: 190,
      avatarPath: '',
      birthDate: DateTime.now(),
      weight: 90),
  Player(
      id: 2,
      name: 'Marco João',
      team: TeamType.woman,
      height: 190,
      weight: 80,
      dominantMember: BodySide.both,
      avatarPath: '',
      birthDate: DateTime.now()),
  Player(
      id: 3,
      name: 'Ricardo',
      team: TeamType.woman,
      height: 190,
      weight: 80,
      avatarPath: '',
      dominantMember: BodySide.right,
      birthDate: DateTime.now())
];
