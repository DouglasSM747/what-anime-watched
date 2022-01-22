import 'package:flutter/material.dart';
import 'package:flutter_valuenotifier/src/features/my_animes/states/my_animes_state.dart';
import 'package:flutter_valuenotifier/src/features/my_animes/stores/my_animes_store.dart';
import 'package:provider/src/provider.dart';

class MyAnimesPage extends StatefulWidget {
  const MyAnimesPage({Key? key}) : super(key: key);

  @override
  _MyAnimesPageState createState() => _MyAnimesPageState();
}

class _MyAnimesPageState extends State<MyAnimesPage> {
  late final MyAnimeStore myAnimeStore;

  @override
  void initState() {
    super.initState();
    myAnimeStore = context.read<MyAnimeStore>();

    WidgetsBinding.instance?.addPostFrameCallback(
      (_) => myAnimeStore.fetchAnimes(),
    );
  }

  @override
  Widget build(BuildContext context) {
    var myAnimeStore = context.watch<MyAnimeStore>();
    var myAnimeState = myAnimeStore.value;

    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Center(
          child: Text(
            "My Animes",
          ),
        ),
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: listAnimes(myAnimeState),
      ),
    );
  }

  Widget listAnimes(MyAnimeState myAnimeState) {
    if (myAnimeState is SucessMyAnimeState) {
      return ListView.builder(
          itemCount: myAnimeState.listAnimes.length,
          itemBuilder: (_, index) {
            var anime = myAnimeState.listAnimes[index];

            return ListTile(
              title: Text(anime.title ?? ""),
              subtitle: Text("${anime.malId ?? -100}"),
              leading: Image.network(
                anime.images?.jpg?.smallImageUrl ??
                    "https://i.pinimg.com/564x/6e/f4/ca/6ef4caa2da03b1fb9e4a00563c76ef5a.jpg",
                width: 50,
              ),
            );
          });
    }

    if (myAnimeState is ErrorMyAnimeState) {
      return Text("Ocorreu um erro:  ${myAnimeState.errorMessage}");
    }
    if (myAnimeState is LoadingMyAnimeState) {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.orange,
        ),
      );
    }
    return Container();
  }
}
