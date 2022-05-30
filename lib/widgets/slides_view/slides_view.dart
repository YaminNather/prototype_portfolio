import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'slide/slide_data.dart';
import 'slides_controller.dart';

class SlidesView extends StatefulWidget {
  const SlidesView({ Key? key, required this.controller, required this.slides, this.sensitivity = 0.0001 }) : super(key: key);

  @override
  State<SlidesView> createState() => _SlidesViewState();

  final SlidesController controller;
  final List<Widget> slides;
  final double sensitivity;
}

class _SlidesViewState extends State<SlidesView> {
  @override
  Widget build(BuildContext context) {
    _controller.updateDataFromWidget(widget.sensitivity, widget.slides.length);  

    return ChangeNotifierProvider<SlidesController>(
      create: (context) => _controller,      
      child: Listener(
        onPointerSignal: (event) {
          GestureBinding.instance.pointerSignalResolver.register(
            event,
            (event) {
              if(event is PointerScrollEvent)
               _controller.onScrolled(event.scrollDelta);
            }
          );          
        },
        child: Container(
          color: Colors.transparent,
          child: Stack(children: _getWrappedSlidesWithData())
        ),
      )
    );
  }

  List<Widget> _getWrappedSlidesWithData() {
    final List<Widget> r = List<Widget>.generate(
      widget.slides.length,
      (index) {
        return SlideData(index: index, child: widget.slides[index]);
      }
    ).reversed.toList();

    return r;
  }

  SlidesController get _controller => widget.controller;
}