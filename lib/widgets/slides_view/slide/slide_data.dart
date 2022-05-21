import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SlideData extends InheritedWidget {
  const SlideData({ Key? key, required this.index, required Widget child }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(SlideData oldWidget) => true;

  static SlideData of(final BuildContext context) {    
    final SlideData slideData = context.dependOnInheritedWidgetOfExactType<SlideData>()!;

    return slideData;
  }


  final int index;
}