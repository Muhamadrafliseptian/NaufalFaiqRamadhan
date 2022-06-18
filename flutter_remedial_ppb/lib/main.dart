import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int counter = 0;
  bool isDark = false;

  Future<void> setPreference() async {
    final jembatan = await SharedPreferences.getInstance();

    if (jembatan.containsKey('myData')) {
      jembatan.clear();
    }

    final myData = json.encode({
      'counter': counter.toString(),
      'isDark': isDark.toString(),
    });

    jembatan.setString('myData', myData);
    setState(() {});
  }

  Future<void> getPreference() async {
    final jembatan = await SharedPreferences.getInstance();

    if (jembatan.containsKey('myData')) {
      final myData =
          json.decode(jembatan.getString('myData')!) as Map<String, dynamic>;

      counter = int.parse(myData["counter"]);
      isDark = myData["isDark"] == "true" ? true : false;
    }
  }

  void minus() {
    counter = counter - 1;

    setPreference();
  }

  void add() {
    counter = counter + 1;

    setPreference();
  }

  void changeTheme() {
    isDark = !isDark;

    setPreference();
  }

  void refresh() {
    counter = 0;
    isDark = false;
    setPreference();
  }

  ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    primarySwatch: Colors.blue,
    accentColor: Colors.blue,
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        primary: Colors.white,
        side: BorderSide(
          color: Colors.white,
          width: 2,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    ),
  );

  ThemeData light = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.green,
    primarySwatch: Colors.green,
    accentColor: Colors.green,
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        primary: Colors.black,
        side: BorderSide(
          color: Colors.black,
          width: 2,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    print("build");
    return FutureBuilder(
      future: getPreference(),
      builder: (context, snapshot) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: isDark ? dark : light,
        home: Scaffold(
          appBar: AppBar(
            title: Center(child: Text("Perbaikan UTS & UAS - 17 Juni 2022")),
            actions: [
              IconButton(icon: Icon(Icons.refresh), onPressed: refresh),
            ],
          ),
          body: Container(
            child: Column(
              children: [
                SizedBox(height: 40),
                Text('Nama  : Naufal Faiq Ramadhan'),
                Text('Kelas : D3 TI 2A'),
                Text('NIM : 2003021'),
                Text('Perbaikan UTS & UAS'),
                SizedBox(
                  height: 170,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Angka : $counter",
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                      onPressed: minus,
                      child: Icon(Icons.remove),
                    ),
                    OutlinedButton(
                      onPressed: add,
                      child: Icon(Icons.add),
                    ),
                  ],
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: changeTheme,
            child: Icon(Icons.color_lens),
          ),
        ),
      ),
    );
  }
}
