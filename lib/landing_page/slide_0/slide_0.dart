import 'package:flutter/material.dart';

import '../../widgets/slides_view/slide/slide.dart';
import 'gradient_background_alignments_ramp.dart';

class Slide0 extends StatefulWidget {
  const Slide0({Key? key}) : super(key: key);

  @override
  State<Slide0> createState() => _Slide0State();
}

class _Slide0State extends State<Slide0> {
  @override
  Widget build(BuildContext context) {
    return Slide(
      entryTransitionBuilder: (content, lifeFactor) {
        return _buildContent(1.0);
      },
      activeBuilder: (context, lifeFactor) {
        return _buildContent(1.0);
      },
      exitTransitionBuilder: (content, lifeFactor) {
        return _buildContent(1.0 - lifeFactor);
      }
    );
  }

  Widget _buildContent(final double opacity) {
    final ThemeData theme = Theme.of(context);

    final GradientBackgroundAlignments backgroundGradientAlignments = _backgroundRamp.sample(_backgroundSamplePoint);    
    
    return Opacity(
      opacity: opacity,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return MouseRegion(
            onHover: (event) {
              const double sensitivity = 0.01;
              double newBackgroundSamplePoint = _backgroundSamplePoint + (event.delta.dx * sensitivity);              
              newBackgroundSamplePoint += newBackgroundSamplePoint.truncate() * -1.0;
              if(newBackgroundSamplePoint < 0.0)
                newBackgroundSamplePoint = 1.0 - newBackgroundSamplePoint.abs();
              setState(() => _backgroundSamplePoint = newBackgroundSamplePoint);
            },
            child: SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: backgroundGradientAlignments.start,
                    end: backgroundGradientAlignments.end,
                    // stops: const <double>[0.2, 1.0],
                    colors: <Color>[Colors.blueAccent.shade700, Colors.tealAccent]
                  )
                ),
                child: Center(
                  child: TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: -20.0, end: 0.0),
                    duration: const Duration(milliseconds: 1000),
                    builder: (context, value, child) {
                      return Transform.translate(
                        offset: Offset(0.0, value),
                        child: Text(
                          'My name is Yamin. I help make your wishes come true in the technology space.', 
                          style: theme.textTheme.headline3!.copyWith(color: Colors.white)
                        )
                      );
                    }
                  )
                )
              )
            ),
          );
        }
      )
    );
  }


  final GradientBackgroundAlignmentsRamp _backgroundRamp = GradientBackgroundAlignmentsRamp();
  double _backgroundSamplePoint = 0.0;
}