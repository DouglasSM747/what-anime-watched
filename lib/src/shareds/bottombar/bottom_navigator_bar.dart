import 'package:flutter/material.dart';
import 'package:flutter_valuenotifier/src/features/animes/animes_page.dart';
import 'package:flutter_valuenotifier/src/features/my_animes/my_animes_page.dart';
import 'package:flutter_valuenotifier/src/shareds/bottombar/bottom_bar_controller.dart';

class BtnNavigator extends StatefulWidget {
  const BtnNavigator({Key? key}) : super(key: key);

  @override
  _BtnNavigatorState createState() => _BtnNavigatorState();
}

class _BtnNavigatorState extends State<BtnNavigator> {
  var controllerBottomBar = BottomBarController();

  final pages = [const AnimePage(), const MyAnimesPage()];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controllerBottomBar,
      builder: (BuildContext context, value, Widget? child) {
        return Scaffold(
          body: pages[controllerBottomBar.value],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controllerBottomBar.value,
            onTap: (index) => {
              controllerBottomBar.value = index,
            },
            items: const [
              BottomNavigationBarItem(
                label: "Buscar Anime",
                icon: Icon(Icons.list),
                activeIcon: Icon(Icons.list_alt_outlined),
              ),
              BottomNavigationBarItem(
                label: "Meus Animes",
                icon: Icon(Icons.ac_unit),
                activeIcon: Icon(Icons.ac_unit_outlined),
              ),
            ],
          ),
        );
      },
      child: Container(),
    );
  }
}
