import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../widgets/slides_view/slides_controller.dart';
import '../widgets/slides_view/slides_view.dart';
import 'slide_0/slide_0.dart';
import 'slide_1/slide_1.dart';
import 'slides_age_indicator.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => LandingPageState();
}

class LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody());
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
    return Column(      
      children: <Widget>[
        Expanded(
          child: SlidesView(            
            controller: _slidesController,
            sensitivity: 0.0002,
            slides: const <Widget>[
              Slide0(),

              Slide1()              
            ]
          )
        ),

        FutureBuilder<void>(
          future: Future.delayed(const Duration()),
          builder: (context, snapshot) {
            if(snapshot.connectionState != ConnectionState.done)
              return const SizedBox.shrink();

            return SizedBox(
              height: 16.0,
              child: SlidesAgeIndicator(slidesController: _slidesController)
            );
          }
        )
      ]
    );
  }

  final SlidesController _slidesController = SlidesController();
}