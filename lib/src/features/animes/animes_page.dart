import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_valuenotifier/src/features/animes/models/anime_model.dart';
import 'package:flutter_valuenotifier/src/features/animes/services/animes_service.dart';
import 'package:flutter_valuenotifier/src/features/animes/states/anime_input_state.dart';
import 'package:flutter_valuenotifier/src/features/animes/states/anime_state.dart';
import 'package:flutter_valuenotifier/src/features/animes/stores/anime_store.dart';
import 'package:flutter_valuenotifier/src/features/animes/stores/input_anime_store.dart';
import 'package:flutter_valuenotifier/src/shareds/widgets.dart';
import 'package:provider/provider.dart';

class AnimePage extends StatefulWidget {
  const AnimePage({Key? key}) : super(key: key);

  @override
  State<AnimePage> createState() => _AnimePageState();
}

class _AnimePageState extends State<AnimePage> {
  final store = AnimeStore(AnimeService(Dio()));
  final inputStore = AnimeInputStore();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final store = context.watch<AnimeStore>();
    final state = store.value;

    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Center(
          child: Text(
            "What Anime",
          ),
        ),
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            ComponentInputAnimeStore(
              functionOnChange: (value) {
                store.nameAnimeSearch = value!;
              },
              functionSearch: store.fetchAnimes,
            ),
            const SizedBox(height: 30),
            listAnimes(state),
          ],
        ),
      ),
    );
  }

  Widget listAnimes(AnimeState state) {
    print(state);
    if (state is LoadingAnimeState) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is ErrorAnimeState) {
      return Text(
        "Erro  ${state.errorMessage}",
        style: const TextStyle(color: Colors.red),
      );
    }

    if (state is SucessAnimeState) {
      return Expanded(
        child: ListView.builder(
          itemCount: state.listAnimes.length,
          itemBuilder: (_, index) {
            final anime = state.listAnimes[index];
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: cardAnime(anime),
            );
          },
        ),
      );
    }

    return Container();
  }

  Widget cardAnime(AnimeModel anime) {
    final animeImage = anime.images!.jpg!.imageUrl;

    TextStyle styleText = const TextStyle(color: Colors.white);
    formatedText(value) => Text(
          value,
          style: styleText,
          textAlign: TextAlign.justify,
        );

    return Card(
      color: Colors.lightBlue,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            if (animeImage != null) ...{
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  animeImage,
                  width: 150,
                ),
              )
            },
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(
                        Icons.star_rate,
                        color: Colors.yellow,
                      ),
                      formatedText("${anime.score ?? 0}"),
                      const SizedBox(width: 10),
                      formatedText("Status: ${anime.status}"),
                    ]),
                formatedText("Tipo: ${anime.type}"),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: formatedText(
                "Nome: ${anime.title ?? anime.titleEnglish ?? anime.titleJapanese}",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ComponentInputAnimeStore extends StatelessWidget {
  final Function(String?) functionOnChange;
  final VoidCallback functionSearch;

  const ComponentInputAnimeStore({
    required this.functionOnChange,
    required this.functionSearch,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = context.watch<AnimeInputStore>();
    final state = store.value;

    var size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width - 100,
      child: CommonWidgets.inputText(
        "Pesquise por uma anime...",
        onChanged: (value) {
          store.onChange(value!);
          functionOnChange(value);
        },
        suffixIcon: IconButton(
          icon: const Icon(Icons.search),
          onPressed:
              state is AvaliableAnimeInputState ? () => functionSearch() : null,
        ),
      ),
    );
  }
}
