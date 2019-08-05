import 'package:Wellness/model/player.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PlayerEvent extends Equatable {
  PlayerEvent([List props = const []]) : super(props);
}

class LoadPlayers extends PlayerEvent {}

class AddPlayer extends PlayerEvent {
  final Player insertPlayer;

  AddPlayer(this.insertPlayer) : super([insertPlayer]);
}

class UpdateWithPlayer extends PlayerEvent {
  final Player updatedPlayer;

  UpdateWithPlayer(this.updatedPlayer) : super([updatedPlayer]);
}

class DeletePlayer extends PlayerEvent {
  final Player player;

  DeletePlayer(this.player) : super([player]);
}
