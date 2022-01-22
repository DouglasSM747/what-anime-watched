import 'package:flutter_valuenotifier/src/features/animes/models/anime_model.dart';

abstract class MyAnimeState {}

class InitialMyAnimeState implements MyAnimeState {}

class SucessMyAnimeState implements MyAnimeState {
  final List<AnimeModel> listAnimes;

  SucessMyAnimeState(this.listAnimes);
}

class ErrorMyAnimeState implements MyAnimeState {
  final String errorMessage;

  ErrorMyAnimeState(this.errorMessage);
}

class LoadingMyAnimeState implements MyAnimeState {}
