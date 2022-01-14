import 'package:flutter_valuenotifier/src/features/animes/models/anime_model.dart';

abstract class AnimeState {}

class InitialAnimeState implements AnimeState {}

class SucessAnimeState implements AnimeState {
  final List<AnimeModel> listAnimes;

  SucessAnimeState(this.listAnimes);
}

class ErrorAnimeState implements AnimeState {
  final String errorMessage;

  ErrorAnimeState(this.errorMessage);
}

class LoadingAnimeState implements AnimeState {}
