import 'package:flutter/material.dart';

class Slide0 extends StatefulWidget {
  const Slide0({Key? key}) : super(key: key);

  @override
  State<Slide0> createState() => _Slide0State();
}

class _Slide0State extends State<Slide0> {
  @override
  Widget build(BuildContext context) {
    return Slide(
      child: SlideTransitionBuilder(
        builder: (inTransition, value, child) {
          return Container(
            width: double.infinity, height: double.infinity,
            child: const Text('Yamin')
          );
        }
      )
    );
  }
}