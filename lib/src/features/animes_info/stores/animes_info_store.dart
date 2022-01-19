import 'package:flutter/cupertino.dart';
import 'package:flutter_valuenotifier/src/features/animes/models/anime_model.dart';
import 'package:flutter_valuenotifier/src/features/animes_info/states/animes_info_states.dart';
import 'package:flutter_valuenotifier/src/shareds/services/animes_local_storage.dart';

class AnimeInfoStore extends ValueNotifier<AnimeInfoState> {
  final AnimeLocalStorageService animeLocalStorageService;

  AnimeInfoStore(this.animeLocalStorageService)
      : super(
          InitialAnimeInfoState(),
        );

  Future registerAnimesLocalStorage(AnimeModel newAnime) async {
    value = LoadingAnimeInfoState();
    try {
      await animeLocalStorageService.registerAnimesLocalStorage(newAnime);
      value = SucessAnimeInfoState();
    } catch (error) {
      value = ErrorAnimeInfoState(error.toString());
    }
  }
}
