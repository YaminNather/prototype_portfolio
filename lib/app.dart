import 'package:flutter/material.dart';
import 'package:fps_widget/fps_widget.dart';
import 'package:google_fonts/google_fonts.dart';

import 'landing_page/landing_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData defaultTheme = ThemeData.light();

    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0.0),
        textTheme: GoogleFonts.workSansTextTheme(
          defaultTheme.textTheme.copyWith(bodyText2: const TextStyle(fontSize: 18.0))
        ).copyWith(
          headline1: GoogleFonts.goblinOne(textStyle: defaultTheme.textTheme.headline1)
        )
      ), 
      home: const Material(
        child: FPSWidget(child: LandingPage())
      )
    );
  }
}