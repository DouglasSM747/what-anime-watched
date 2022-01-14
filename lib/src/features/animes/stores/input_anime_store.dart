import 'package:flutter/cupertino.dart';
import 'package:flutter_valuenotifier/src/features/animes/states/anime_input_state.dart';

class AnimeInputStore extends ValueNotifier<AnimeInputState> {
  AnimeInputStore() : super(DisableAnimeInputState());

  bool inputDisable = true;

  onChange(String input) {
    if (input.length > 3) {
      value = AvaliableAnimeInputState();
    } else {
      value = DisableAnimeInputState();
    }
  }
}
