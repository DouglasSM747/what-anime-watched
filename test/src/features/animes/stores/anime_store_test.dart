import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_valuenotifier/src/features/animes/services/animes_service.dart';
import 'package:flutter_valuenotifier/src/features/animes/states/anime_state.dart';
import 'package:flutter_valuenotifier/src/features/animes/stores/anime_store.dart';
import 'package:mocktail/mocktail.dart';

class AnimeServiceMock extends Mock implements AnimeService {}

void main() {
  final animeService = AnimeServiceMock();
  final animeStore = AnimeStore(animeService);
  test("Deve ter state sucess", () async {
    animeStore.nameAnimeSearch = "Naruto";

    when(() => animeService.fetchAnimes(animeStore.nameAnimeSearch))
        .thenAnswer((_) async => []);
    await animeStore.fetchAnimes();
    expect(animeStore.value, isA<SucessAnimeState>());
  });

  test("Deve ter state error", () async {
    animeStore.nameAnimeSearch = "Naruto";

    when(() => animeService.fetchAnimes(animeStore.nameAnimeSearch)).thenThrow(
      Exception('Deu Erro'),
    );
    await animeStore.fetchAnimes();
    expect(animeStore.value, isA<ErrorAnimeState>());
  });
}
