import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_valuenotifier/src/features/animes/models/anime_model.dart';

class AnimeService {
  final Dio dio;

  AnimeService(this.dio);

  Future<List<AnimeModel>> fetchAnimes(String animeName) async {
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient dioClient) {
      dioClient.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      return dioClient;
    };

    final response = await dio.get(
      "https://api.jikan.moe/v4/anime?q= $animeName",
    );
    final list = response.data['data'] as List;
    return list.map((anime) => AnimeModel.fromJson(anime)).toList();
  }
}
