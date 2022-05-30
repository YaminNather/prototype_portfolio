import 'package:flutter/material.dart';
import '../../widgets/slides_view/slide/slide.dart';
import '../../widgets/link.dart';

class Slide1 extends StatefulWidget {
  const Slide1({Key? key}) : super(key: key);

  @override
  State<Slide1> createState() => _Slide1State();
}

class _Slide1State extends State<Slide1> {
  @override
  Widget build(BuildContext context) {
    return Slide(
      entryTransitionBuilder: (content, lifeFactor) {
        return _buildContent(lifeFactor, lifeFactor);
      },
      activeBuilder: (context, lifeFactor) {
        return _buildContent(1.0, 1.0);
      },
      exitTransitionBuilder: (content, lifeFactor) {
        return _buildContent(1.0 - lifeFactor, 1.0 - lifeFactor);
      }      
    );
  }

  Widget _buildContent(final double textOpacity, final double subtitleAnimationT) {
    final ThemeData theme = Theme.of(context);

    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final Size screenSize = mediaQuery.size;

    const Color defaultTextColor = Color(0xff454545);

    return Theme(
      data: theme.copyWith(cardTheme: const CardTheme(elevation: 0.0)),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 200.0, right: 200.0, bottom: 80.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: Row(
                  children: <Widget>[
                    IconButton(icon: const Icon(Icons.ac_unit), iconSize: 64.0, onPressed: () {}),

                    const Spacer(),

                    const Link(text: 'Work', to: ''),

                    const SizedBox(width: 32.0),

                    const Link(text: 'About', to: ''),

                    const SizedBox(width: 32.0),

                    const Link(text: 'Contact', to: '')
                  ]
                ),
              ),

              Expanded(
                child: Card(
                  color: const Color(0xFFf4f4f4),
                  child: Padding(                  
                    padding: const EdgeInsets.symmetric(horizontal: 128.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Opacity(
                          opacity: textOpacity,
                          child: Text(
                            'Hello', 
                            style: theme.textTheme.headline1!.copyWith(fontSize: screenSize.width * 0.14, color: defaultTextColor)
                          )
                        ),

                        // const SizedBox(height: 16.0),

                        SizedBox(
                          width: screenSize.width * 0.3,
                          child: Transform.translate(
                            offset: Offset(0.0, 64.0 * (1.0 - subtitleAnimationT)),
                            child: Opacity(
                              opacity: subtitleAnimationT,
                              child: const Text('I\'m Yamin, an artist/designer based in San Fransisco, focused on 3D illustration, animation and product design.')
                            )
                          )
                        )
                      ]
                    )
                  )
                )
              )
            ]
          )
        ),
      )
    );
  }
}