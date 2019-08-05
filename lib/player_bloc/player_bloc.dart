import 'dart:async';
import 'dart:math';
import 'package:Wellness/model/player.dart';
import 'package:Wellness/model/player_dao.dart';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  PlayersDAO _playersDao = PlayersDAO();

  @override
  PlayerState get initialState => InitialPlayerState();

  @override
  Stream<PlayerState> mapEventToState(
    PlayerEvent event,
  ) async* {
    if (event is LoadPlayers) {
      yield PlayersLoading();
      yield* _reloadPlayers();
    } else if (event is AddPlayer) {
      await _playersDao.insert(event.insertPlayer);
      yield* _reloadPlayers();
    } else if (event is UpdateWithPlayer) {
      final newPlayer = event.updatedPlayer;
      newPlayer.id = event.updatedPlayer.id;
      await _playersDao.update(newPlayer);
      yield* _reloadPlayers();
    } else if (event is DeletePlayer) {
      await _playersDao.delete(event.player);
      yield* _reloadPlayers();
    }
  }

  Stream<PlayerState> _reloadPlayers() async* {
    final player = await _playersDao.getAllSortedByName();
    yield PlayersLoaded(player);
  }
}

// class RandomplayerGenerator {
//   static final _player = [
//     // Player(name: 'andy', age: 33, weight: 70, isok: true),
//     // Player(name: 'Marco', age: 34, weight: 70, isok: false),
//     // Player(name: 'Ricardo', age: 23, weight: 70, isok: true),
//     // Player(name: 'Ruben', age: 33, weight: 70, isok: false),
//     // Player(name: 'anhhhhhdy', age: 53, weight: 70, isok: true),
//   ];

//   static Player getRandomPlayer() {
//     return _player[Random().nextInt(_player.length)];
//   }
// }
