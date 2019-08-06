import 'package:Wellness/model/player.dart';
import 'package:Wellness/model/report.dart';

final List<Player> players = <Player>[
  Player(
      name: 'Anderson Cansado',
      team: TeamType.under17,
      dominantMember: BodySide.left,
      height: 190,
      avatarPath: '',
      birthDate: DateTime.now(),
      weight: 60),
  Player(
      name: 'Marco João',
      team: TeamType.woman,
      height: 190,
      weight: 80,
      dominantMember: BodySide.both,
      avatarPath: '',
      birthDate: DateTime.now()),
  Player(
      name: 'Ricardo',
      team: TeamType.woman,
      height: 190,
      weight: 80,
      avatarPath: '',
      dominantMember: BodySide.right,
      birthDate: DateTime.now())
];
