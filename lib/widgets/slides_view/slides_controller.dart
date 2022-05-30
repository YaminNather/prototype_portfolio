import 'package:flutter/widgets.dart';

import '../../utils/reactive_value.dart';

class SlidesController extends ChangeNotifier {
  void updateDataFromWidget(final double sensitivity, final int pagesCount) {
    _sensitivity = sensitivity;
    _pagesCount = pagesCount;
  }

  void onScrolled(final Offset delta) {
    print('CustomLog: Scroll delta = $delta');

    double newScrollFactor = _scrollFactor.value + (delta.dy * _sensitivity);
    newScrollFactor = newScrollFactor.clamp(0, _pagesCount.toDouble());    
    _scrollFactor.value = newScrollFactor;
    

    notifyListeners();
  }

  int currentPage() => _scrollFactor.value.truncate();

  ReactiveValue<double> get scrollFactor => _scrollFactor;

  int get pagesCount => _pagesCount;


  double _sensitivity = 0.0;
  final ReactiveValue<double> _scrollFactor = ReactiveValue<double>(0.0);
  int _pagesCount = 0;
}