import 'package:flutter/material.dart';

class CommonWidgets extends StatelessWidget {
  const CommonWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  static showAlertDialog(
    BuildContext context, {
    String title = "Alerta",
    String subtitle = "Ocorreu um Erro!",
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text(title),
          ),
          content: Center(
            child: Text(subtitle),
          ),
        );
      },
    );
  }

  static Widget radioCheck(
    String text,
    String controll,
    Function(String?)? onChanged,
  ) {
    return SizedBox(
      height: 14,
      child: Radio(
        value: text,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        groupValue: controll,
        onChanged: onChanged,
      ),
    );
  }

  static Widget table(
    List<String> names,
    List<List<String>> cells, {
    int columnClick = 0,
    bool clicked = false,
    Function(String)? function,
  }) {
    return ListView(
      children: <Widget>[
        DataTable(
          columns: List.generate(names.length, (index) {
            return DataColumn(
              label: Text(
                names[index],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }),
          rows: List.generate(
            cells.length,
            (i) {
              return DataRow(
                cells: List.generate(
                  cells[i].length,
                  (j) {
                    if (clicked && columnClick == j) {
                      return DataCell(TextButton(
                        onPressed: () =>
                            function != null ? function(cells[i][j]) : () {},
                        child: Text(cells[i][j]),
                      ));
                    } else {
                      return DataCell(Text(cells[i][j]));
                    }
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  static Widget cardInfoData(String title, String info) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 15),
        ),
        SizedBox(
          width: 120,
          height: 80,
          child: Card(
            color: Colors.grey[200],
            child: Center(
              child: Text(
                info,
                style: const TextStyle(fontSize: 15),
              ),
            ),
          ),
        ),
      ],
    );
  }

  static Widget loading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  static Widget buttonDefault(String text, {required VoidCallback? callback}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple[100]!,
            spreadRadius: 10,
            blurRadius: 20,
          ),
        ],
      ),
      child: ElevatedButton(
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: Center(child: Text(text)),
        ),
        onPressed: callback,
        style: ElevatedButton.styleFrom(
          primary: Colors.deepPurple,
          onPrimary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }

  static Widget inputText(
    String hintText, {
    Function(String?)? onChanged,
    bool isObscureText = false,
    bool useIcon = false,
    Widget? suffixIcon,
  }) {
    return TextField(
      obscureText: isObscureText,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.blueGrey[50],
        labelStyle: const TextStyle(fontSize: 12),
        contentPadding: const EdgeInsets.only(left: 30),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey[50]!),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey[50]!),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
