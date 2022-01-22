import 'package:flutter/material.dart';
import 'package:flutter_valuenotifier/src/features/animes/models/anime_model.dart';
import 'package:flutter_valuenotifier/src/features/animes_info/states/animes_info_states.dart';
import 'package:flutter_valuenotifier/src/features/animes_info/stores/animes_info_store.dart';
import 'package:flutter_valuenotifier/src/shareds/widgets.dart';
import 'package:provider/src/provider.dart';
import 'package:translator/translator.dart';

class AnimeInfoPage extends StatefulWidget {
  final AnimeModel anime;

  const AnimeInfoPage(this.anime, {Key? key}) : super(key: key);

  @override
  State<AnimeInfoPage> createState() => _AnimeInfoPageState();
}

class _AnimeInfoPageState extends State<AnimeInfoPage> {
  late final AnimeInfoStore animeInfostore;

  @override
  void initState() {
    super.initState();
    animeInfostore = context.read<AnimeInfoStore>();
    animeInfostore.checkAlreadyRegisteredAnime(widget.anime.malId ?? -100);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.addPostFrameCallback(
      (_) => animeInfostore.onDispose(),
    );
    super.dispose();
  }

  final translator = GoogleTranslator();

  Future<String> translateText(String inputText) async {
    try {
      var result = await translator.translate(
        inputText,
        from: 'en',
        to: 'pt',
      );
      return result.text;
    } catch (e) {
      return inputText;
    }
  }

  TextStyle styleText = const TextStyle(color: Colors.white);

  formatedText(value) => Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Text(
          value,
          style: styleText,
          textAlign: TextAlign.justify,
        ),
      );

  @override
  Widget build(BuildContext context) {
    final animeInfostore = context.watch<AnimeInfoStore>();
    final animeInfostate = animeInfostore.value;

    var size = MediaQuery.of(context).size;
    final animeImage = widget.anime.images!.jpg!.largeImageUrl;

    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Center(
          child: Text(
            widget.anime.title ??
                widget.anime.titleEnglish ??
                widget.anime.titleJapanese ??
                "",
          ),
        ),
      ),
      body: Center(
        child: SizedBox(
          width: size.width - 100,
          height: size.height,
          child: ListView(
            children: [
              const SizedBox(height: 30),
              animeImage != null
                  ? SizedBox(
                      height: 300,
                      width: 300,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image.network(
                          animeImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : Container(),
              if (animeInfostate is SucessAnimeInfoState) ...{
                formatedText("Esse anime acabou de ser registrado :)"),
              },
              if (animeInfostate is AnimeAlreadyRegistered) ...{
                formatedText("Esse já foi registrado!"),
              },
              if (animeInfostate is LoadingAnimeInfoState) ...{
                formatedText("Estamos salvando seu anime..."),
              },
              if (animeInfostate is ErrorAnimeInfoState) ...{
                formatedText(
                  "Ocorreu um erro ao registrar: ${animeInfostate.errorMessage}",
                )
              },
              if (animeInfostate is InitialAnimeInfoState) ...{
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CommonWidgets.buttonDefault(
                    "Ei, eu já assisti Esse Anime".toUpperCase(),
                    callback: () => animeInfostore.registerAnimesLocalStorage(
                      widget.anime,
                    ),
                  ),
                ),
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
                          formatedText("${widget.anime.score ?? 0}"),
                        ]),
                  ],
                ),
                formatedText("Status: ${widget.anime.status}"),
                formatedText("Tipo: ${widget.anime.type}"),
                formatedText("Duração: ${widget.anime.duration}"),
                FutureBuilder(
                  future: translateText(widget.anime.synopsis ?? ""),
                  builder: (BuildContext context, AsyncSnapshot<String> text) {
                    return formatedText(
                      "Sinopse: ${text.data}",
                    );
                  },
                ),
                FutureBuilder(
                  future: translateText(widget.anime.background ?? ""),
                  builder: (BuildContext context, AsyncSnapshot<String> text) {
                    return formatedText(
                      "Status: ${text.data}",
                    );
                  },
                ),
              },
            ],
          ),
        ),
      ),
    );
  }
}
