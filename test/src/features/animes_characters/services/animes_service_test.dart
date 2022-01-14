import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_valuenotifier/src/features/animes/services/animes_service.dart';

void main() {
  final servicesAnimesCharacters = AnimeService(Dio());
  test("Deve Pegar Todos Os Animes", () async {
    final animesCharacters = await servicesAnimesCharacters.fetchAnimes(
      "Naruto",
    );

    expect(animesCharacters[0].malId, 34566);
    expect(animesCharacters[1].malId, 28755);
  });
}
