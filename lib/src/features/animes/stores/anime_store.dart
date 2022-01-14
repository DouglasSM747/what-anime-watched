import 'package:flutter/cupertino.dart';
import 'package:flutter_valuenotifier/src/features/animes/services/animes_service.dart';
import 'package:flutter_valuenotifier/src/features/animes/states/anime_state.dart';

class AnimeStore extends ValueNotifier<AnimeState> {
  final AnimeService animeService;

  AnimeStore(this.animeService) : super(InitialAnimeState());

  String nameAnimeSearch = "";

  Future fetchAnimes() async {
    value = LoadingAnimeState();
    try {
      final animes = await animeService.fetchAnimes(nameAnimeSearch);
      value = SucessAnimeState(animes);
    } catch (error) {
      value = ErrorAnimeState(error.toString());
    }
  }
}
