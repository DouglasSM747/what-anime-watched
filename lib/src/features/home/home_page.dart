import 'package:flutter/material.dart';
import 'package:flutter_valuenotifier/src/features/home/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final counter = Counter();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ValueListenableBuilder<int>(
              valueListenable: counter,
              builder: (context, value, child) {
                return Text("Valor: $value");
              },
            ),
            Row(
              children: [
                IconButton(
                  onPressed: counter.increment,
                  icon: const Icon(Icons.add),
                ),
                IconButton(
                  onPressed: counter.decrement,
                  icon: const Icon(Icons.remove),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
