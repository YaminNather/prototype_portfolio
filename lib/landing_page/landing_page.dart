import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => LandingPageState();
}

class LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

  PreferredSizeWidget _buildAppBar() {
    final ThemeData theme = Theme.of(context);

    return PreferredSize(
      preferredSize: const Size.fromHeight(120.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 200.0),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('S', style: theme.textTheme.headline6),

              IconButton(icon: const Icon(Icons.menu, size: 28.0), onPressed: () {})
            ]
          )
        )
      )
    );
  }

  Widget _buildBody() {
    return SlidesView(
      children: <Widget>[
        Slide0(),

        Slide1()
      ]
    );
  }
}