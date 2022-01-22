import 'dart:convert';

import 'package:flutter_valuenotifier/src/features/animes/models/anime_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnimeLocalStorageService {
  //! Não consigo utilziar o sharedpreferences no provider
  late SharedPreferences _sharedPreferences;

  AnimeLocalStorageService();

  Future<List<AnimeModel>> fetchAnimesLocalStorage() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    var animes = _sharedPreferences.getStringList('listAnimes');
    if (animes == null) {
      return List.empty();
    }

    return animes.map((anime) {
      return AnimeModel.fromJson(Map.from(json.decode(anime)));
    }).toList();
  }

  Future<bool> isAnimeRegistedInStorage(int idAnime) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    bool isNullList = _sharedPreferences.getStringList('listAnimes') == null;
    print(isNullList);
    if (!isNullList) {
      List<AnimeModel> listAnimes = await fetchAnimesLocalStorage();
      print(listAnimes);
      for (AnimeModel anime in listAnimes) {
        if (anime.malId == idAnime) {
          return true;
        }
      }
    }
    return false;
  }

  registerAnimesLocalStorage(AnimeModel newAnime) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    if (_sharedPreferences.getStringList('listAnimes') == null) {
      _sharedPreferences.setStringList('listAnimes', []);
    }
    var animes = _sharedPreferences.getStringList('listAnimes');
    final list = animes as List<String>;
    list.add(jsonEncode(newAnime));
    _sharedPreferences.setStringList('listAnimes', list);
  }
}
