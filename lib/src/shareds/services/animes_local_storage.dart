import 'package:flutter_valuenotifier/src/features/animes/models/anime_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnimeLocalStorageService {
  //! Não consigo utilziar o sharedpreferences no provider
  late SharedPreferences sharedPreferences;

  AnimeLocalStorageService() {
    SharedPreferences.getInstance().then((value) {
      sharedPreferences = value;
    });
  }

  Future<List<AnimeModel>> fetchAnimesLocalStorage() async {
    var animes = sharedPreferences.getStringList('listAnimes');
    final list = animes as List;
    return list.map((anime) => AnimeModel.fromJson(anime)).toList();
  }

  Future<void> registerAnimesLocalStorage(AnimeModel newAnime) async {
    if (sharedPreferences.getStringList('listAnimes') == null) {
      sharedPreferences.setStringList('listAnimes', []);
    }
    var animes = sharedPreferences.getStringList('listAnimes');
    final list = animes as List<String>;
    list.add(newAnime.toJson().toString());
    sharedPreferences.setStringList('listAnimes', list);
  }
}
