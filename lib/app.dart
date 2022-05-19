import 'package:flutter/material.dart';

import 'landing_page/landing_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0.0)
      ), 
      home: const LandingPage()
    );
  }
}