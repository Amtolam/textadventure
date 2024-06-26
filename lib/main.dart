import 'package:flutter/material.dart';

import 'pages/selection_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Celebrity Life - text adventure',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 0, 160, 107)),
      ),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 122, 0, 81)),
      ),
      themeMode: ThemeMode.system,
      home: const SelectionPage(),
    );
  }
}
