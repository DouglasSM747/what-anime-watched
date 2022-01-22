import 'package:flutter/material.dart';
import 'package:flutter_valuenotifier/src/features/animes/models/anime_model.dart';
import 'package:flutter_valuenotifier/src/features/animes/states/anime_input_state.dart';
import 'package:flutter_valuenotifier/src/features/animes/states/anime_state.dart';
import 'package:flutter_valuenotifier/src/features/animes/stores/anime_store.dart';
import 'package:flutter_valuenotifier/src/features/animes/stores/input_anime_store.dart';
import 'package:flutter_valuenotifier/src/features/animes_info/animes_info_page.dart';
import 'package:flutter_valuenotifier/src/shareds/widgets.dart';
import 'package:provider/provider.dart';

class AnimePage extends StatefulWidget {
  const AnimePage({Key? key}) : super(key: key);

  @override
  State<AnimePage> createState() => _AnimePageState();
}

class _AnimePageState extends State<AnimePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final animeStore = context.watch<AnimeStore>();
    final animeState = animeStore.value;

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
                animeStore.nameAnimeSearch = value!;
              },
              functionSearch: animeStore.fetchAnimes,
            ),
            const SizedBox(height: 30),
            listAnimes(animeState),
          ],
        ),
      ),
    );
  }

  Widget listAnimes(AnimeState state) {
    if (state is LoadingAnimeState) {
      return const Center(
          child: CircularProgressIndicator(
        color: Colors.orange,
      ));
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
              padding: const EdgeInsets.only(
                left: 50,
                right: 50,
                top: 20,
                bottom: 20,
              ),
              child: cardAnime(anime),
            );
          },
        ),
      );
    }

    return Container();
  }

  Widget cardAnime(AnimeModel anime) {
    final animeImage = anime.images!.jpg!.largeImageUrl;

    return GestureDetector(
      onTap: () => CommonWidgets.changeScreen(
        context: context,
        screen: AnimeInfoPage(anime),
      ),
      child: Card(
        elevation: 8,
        color: Colors.lightBlue,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Padding(
              padding: const EdgeInsets.all(4),
              child: SizedBox(
                height: 350,
                width: 350,
                child: Image.network(
                  animeImage!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: infoAnime(anime),
            ),
          ],
        ),
      ),
    );
  }
}

Widget infoAnime(AnimeModel anime) {
  TextStyle styleText = const TextStyle(color: Colors.white);
  formatedText(value) => Text(
        value,
        style: styleText,
        textAlign: TextAlign.justify,
      );

  return Card(
    color: Colors.black,
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          child: formatedText(
            anime.title ?? anime.titleEnglish ?? anime.titleJapanese,
          ),
        ),
      ],
    ),
  );
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
