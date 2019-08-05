import 'package:Wellness/model/player.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PlayerState extends Equatable {
  PlayerState([List props = const []]) : super(props);
}

class InitialPlayerState extends PlayerState {}

class PlayersLoading extends PlayerState {}

class PlayersLoaded extends PlayerState {
  final List<Player> players;

  PlayersLoaded(this.players) : super([players]);
}
