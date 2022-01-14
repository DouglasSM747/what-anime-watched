import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_valuenotifier/src/features/animes/animes_page.dart';
import 'package:flutter_valuenotifier/src/features/animes/services/animes_service.dart';
import 'package:flutter_valuenotifier/src/features/animes/stores/anime_store.dart';
import 'package:flutter_valuenotifier/src/features/animes/stores/input_anime_store.dart';
import 'package:provider/provider.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => Dio()),
        Provider(create: (context) => AnimeService(context.read())),
        ChangeNotifierProvider(create: (context) => AnimeStore(context.read())),
        ChangeNotifierProvider(create: (context) => AnimeInputStore()),
      ],
      child: MaterialApp(
        title: 'Flutter Value Notifier',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const AnimePage(),
      ),
    );
  }
}
