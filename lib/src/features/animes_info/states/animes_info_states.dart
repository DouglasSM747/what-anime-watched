abstract class AnimeInfoState {}

class InitialAnimeInfoState implements AnimeInfoState {}

class SucessAnimeInfoState implements AnimeInfoState {}

class ErrorAnimeInfoState implements AnimeInfoState {
  final String errorMessage;

  ErrorAnimeInfoState(this.errorMessage);
}

class LoadingAnimeInfoState implements AnimeInfoState {}

class AnimeAlreadyRegistered implements AnimeInfoState {}
