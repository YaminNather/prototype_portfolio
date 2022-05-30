import 'package:flutter/material.dart';
import '../../widgets/slides_view/slide/slide.dart';
import '../../widgets/link.dart';
import '../../widgets/slides_view/slide/slide_age_hit_point.dart';
import 'subtitle.dart';

class Slide2 extends StatefulWidget {
  const Slide2({Key? key}) : super(key: key);

  @override
  State<Slide2> createState() => _Slide2State();
}

class _Slide2State extends State<Slide2> {
  @override
  Widget build(BuildContext context) {
    return Slide(
      onEnter: () => setState(() => _isSubtitleIn = false),
      onExit: () {},
      activeHitPoints: <SlideAgeHitPoint>[
        SlideAgeHitPoint(0.12, () => setState(() => _isSubtitleIn = true))
      ],
      entryTransitionBuilder: (content, lifeFactor) {
        return _buildContent(titleAnimationT: lifeFactor);
      },
      activeBuilder: (context, lifeFactor) {
        return _buildContent();
      },
      exitTransitionBuilder: (content, lifeFactor) {
        return _buildContent(titleAnimationT: 1.0 - lifeFactor);
      }
    );
  }

  Widget _buildContent({final double titleAnimationT = 1.0}) {
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
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(                  
                            padding: const EdgeInsets.symmetric(horizontal: 128.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Opacity(
                                  opacity: titleAnimationT,
                                  child: Text(
                                    'Hello', 
                                    style: theme.textTheme.headline1!.copyWith(fontSize: screenSize.width * 0.14, color: defaultTextColor)
                                  )
                                ),

                                // const SizedBox(height: 16.0),

                                SizedBox(
                                  width: screenSize.width * 0.3,
                                  child: Subtitle(isSubtitleIn: _isSubtitleIn)
                                ),

                                Container(height: 9000.0, color: Colors.green)
                              ]
                            )
                          )
                        ]
                      )
                    )
                  )
                )
            ]
          )
        )
      )
    );
  }


  bool _isSubtitleIn = false;
  final ScrollController _scrollController = ScrollController();
}