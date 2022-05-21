import 'package:flutter/material.dart';
import 'package:prototype_portfolio/widgets/slides_view/slide/slide_age_hit_point.dart';
import 'package:provider/provider.dart';

import 'slide_controller/slide_controller.dart';
import 'slide_data.dart';
import '../slides_controller.dart';
import 'slide_state.dart';

class Slide extends StatefulWidget {
  const Slide({
    Key? key, 
    this.onEntered,
    this.onStateChanged,
    this.onExited,
    this.entryTransitionDurationFactor = 0.1,
    this.exitTransitionDurationFactor = 0.1,
    this.entryTransitionBuilder,
    required this.activeBuilder,
    this.exitTransitionBuilder,    
    this.activeHitPoints
  }) : super(key: key);

  @override
  State<Slide> createState() => _SlideState();

  final void Function()? onEntered;
  final void Function(SlideState state)? onStateChanged;  
  final void Function()? onExited;
  final double entryTransitionDurationFactor;
  final double exitTransitionDurationFactor;
  final Widget Function(BuildContext context, double lifeFactor)? entryTransitionBuilder;
  final Widget Function(BuildContext context, double lifeFactor) activeBuilder;
  final Widget Function(BuildContext context, double lifeFactor)? exitTransitionBuilder;
  final List<SlideAgeHitPoint>? activeHitPoints;
}

class _SlideState extends State<Slide> {
  @override
  void initState() {
    super.initState();

    _controller.addListener(_update);
  }

  @override
  Widget build(BuildContext context) {
    final SlideData slideData = SlideData.of(context);
    final SlidesController slidesController = Provider.of<SlidesController>(context, listen: false);
    _controller.updateWithWidgetData(
      slidesController: slidesController, 
      index: slideData.index, 
      entryTransitionDurationFactor: widget.entryTransitionDurationFactor,
      exitTransitionDurationFactor: widget.exitTransitionDurationFactor,
      hitPoints: widget.activeHitPoints
    );    
  
    final SlideState slideState = _controller.slideState;


    Widget? r;
    if(slideState == SlideState.entryTransition)
      r = widget.entryTransitionBuilder?.call(context, _controller.rangeAgeFactor);
    else if(slideState == SlideState.exitTransition)
      r = widget.exitTransitionBuilder?.call(context, _controller.rangeAgeFactor);
    
    r ??= widget.activeBuilder(context, _controller.rangeAgeFactor);

    print('CustomLog: Slide at index ${_controller.index} = ${_controller.visibility}');

    return Visibility(
      maintainState: true,
      visible: _controller.visibility,
      child: r
    );
  }

  void _update() => setState(() {});

  @override
  void dispose() {
    _controller.removeListener(_update);

    super.dispose();
  }


  final SlideController _controller = SlideController();
}