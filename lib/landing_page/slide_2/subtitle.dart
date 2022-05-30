import 'package:flutter/material.dart';

class Subtitle extends StatefulWidget {
  const Subtitle({Key? key, required this.isSubtitleIn}) : super(key: key);

  @override
  State<Subtitle> createState() => _SubtitleState();

  final bool isSubtitleIn;
}

class _SubtitleState extends State<Subtitle> {
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(end: (!widget.isSubtitleIn) ? 0.0 : 1.0),
      duration: Duration(milliseconds: (widget.isSubtitleIn) ? 1000 : 0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0.0, 64.0 * (1.0 - value)),
          child: Opacity(
            opacity: value,
            child: child
          )
        );
      },
      child: const Text('I\'m Yamin, an artist/designer based in San Fransisco, focused on 3D illustration, animation and product design.')
    );
  }
}