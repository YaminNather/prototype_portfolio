import 'package:flutter/material.dart';

class SlideProgressIndicator extends StatefulWidget {
  const SlideProgressIndicator({Key? key}) : super(key: key);

  @override
  State<SlideProgressIndicator> createState() => _SlideProgressIndicatorState();
}

class _SlideProgressIndicatorState extends State<SlideProgressIndicator> {
  @override
  Widget build(BuildContext context) {
    return const LinearProgressIndicator(value: 0.1);
  }
}