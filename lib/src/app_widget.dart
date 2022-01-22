import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_valuenotifier/src/features/animes/animes_page.dart';
import 'package:flutter_valuenotifier/src/features/animes/services/animes_service.dart';
import 'package:flutter_valuenotifier/src/features/animes/stores/anime_store.dart';
import 'package:flutter_valuenotifier/src/features/animes/stores/input_anime_store.dart';
import 'package:flutter_valuenotifier/src/features/animes_info/stores/animes_info_store.dart';
import 'package:flutter_valuenotifier/src/features/my_animes/stores/my_animes_store.dart';
import 'package:flutter_valuenotifier/src/shareds/bottombar/bottom_navigator_bar.dart';
import 'package:flutter_valuenotifier/src/shareds/services/animes_local_storage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => Dio()),
        Provider(create: (_) => SharedPreferences.getInstance()),
        Provider(create: (context) => AnimeService(context.read())),
        Provider(create: (context) => AnimeLocalStorageService()),
        ChangeNotifierProvider(create: (context) => AnimeStore(context.read())),
        ChangeNotifierProvider(
          create: (context) => AnimeInfoStore(context.read()),
        ),
        ChangeNotifierProvider(create: (context) => AnimeInputStore()),
        ChangeNotifierProvider(
            create: (context) => MyAnimeStore(context.read())),
      ],
      child: MaterialApp(
        title: 'Flutter Value Notifier',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const BtnNavigator(),
      ),
    );
  }
}
