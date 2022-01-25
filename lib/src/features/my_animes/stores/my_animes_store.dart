import 'package:flutter/cupertino.dart';
import 'package:flutter_valuenotifier/src/features/my_animes/states/my_animes_state.dart';
import 'package:flutter_valuenotifier/src/shareds/services/animes_local_storage.dart';

class MyAnimeStore extends ValueNotifier<MyAnimeState> {
  final AnimeLocalStorageService animeService;

  MyAnimeStore(this.animeService) : super(InitialMyAnimeState());

  Future fetchAnimes() async {
    value = LoadingMyAnimeState();
    try {
      final animes = await animeService.fetchAnimesLocalStorage();
      value = SucessMyAnimeState(animes);
    } catch (error) {
      value = ErrorMyAnimeState(error.toString());
    }
  }

  Future removeAnime(int idAnime) async {
    value = LoadingMyAnimeState();
    try {
      await animeService.removeAnimeLocalStorage(idAnime);
      final animes = await animeService.fetchAnimesLocalStorage();
      print(animes.length);
      value = SucessMyAnimeState(animes);
    } catch (error) {
      value = ErrorMyAnimeState(error.toString());
    }
  }
}
