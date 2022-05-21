import 'package:flutter/material.dart';

import '../widgets/slides_view/slides_controller.dart';

class SlidesAgeIndicator extends StatefulWidget {
  const SlidesAgeIndicator({Key? key, required this.slidesController}) : super(key: key);

  @override
  State<SlidesAgeIndicator> createState() => _SlidesAgeIndicatorState();

  final SlidesController slidesController;
}

class _SlidesAgeIndicatorState extends State<SlidesAgeIndicator> {
  @override
  void initState() {
    super.initState();

    _slidesController = widget.slidesController;
    _slidesController.addListener(_update);
  }

  @override
  Widget build(BuildContext context) {
    if(widget.slidesController != _slidesController) {
      _slidesController.removeListener(_update);
            
      _slidesController = widget.slidesController;
      _slidesController.addListener(_update);
    }

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        LinearProgressIndicator(value: _slidesController.scrollFactor.value / _slidesController.pagesCount),

        Positioned.fill(
          child: Center(child: Text(_slidesController.scrollFactor.value.toString(), style: const TextStyle(fontSize: 13.0)))
        )
      ]
    ); 
  }

  void _update() => setState(() {});

  late SlidesController _slidesController;
}