import 'package:meta/meta.dart';
import 'package:Wellness/model/player.dart';
import 'package:Wellness/model/report.dart';

final List<Player> players = <Player>[
  Player(
      name: 'Anderson Cansado',
      team: TeamType.sub17,
      dominantMember: BodySide.left,
      height: 190,
      avatarPath: '',
      birthDate: DateTime.now(),
      weight: 60),
  Player(
      name: 'Marco João',
      team: TeamType.sub23,
      height: 190,
      weight: 80,
      dominantMember: BodySide.left,
      avatarPath: '',
      birthDate: DateTime.now()),
  Player(
      name: 'Ricardo',
      team: TeamType.woman,
      height: 190,
      weight: 80,
      avatarPath: '',
      dominantMember: BodySide.left,
      birthDate: DateTime.now())
];
