import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:prototype_portfolio/widgets/slides_view/slide/slide_controller/slide_controller_state.dart';

import '../../../../utils/reactive_value.dart';
import '../../slides_controller.dart';
import '../slide_age_hit_point.dart';
import '../slide_state.dart';
import 'hitpoints_activate_checker.dart';

class SlideController extends ChangeNotifier {
  void updateWithWidgetData({
    required SlidesController slidesController, 
    required int index,
    required double entryTransitionDurationFactor,
    required double exitTransitionDurationFactor,
    required List<SlideAgeHitPoint>? hitPoints
  }) {
    _slidesController.value = slidesController;
    _index = index;
    _entryTransitionDurationFactor = entryTransitionDurationFactor;
    _exitTransitionDurationFactor = exitTransitionDurationFactor;
    _hitPoints = hitPoints;

    if(_slidesController.value != _slidesController.oldValue) {
      _slidesController.oldValue?.removeListener(_onSlidesControllerUpdated);

      _slidesController.value!.addListener(_onSlidesControllerUpdated);
    }
  }  

  void _onSlidesControllerUpdated() {
    _slideState.value = _calculateSlideState();

    if(_slideState.value != _slideState.oldValue)
      _calculateAgeRangeHandler();

    _rangeAgeFactor = _slideAgeRangeHandler.getAgeFactor(ageFactor);
    
    _visibility = _slideState.value != SlideState.none;

    checkAndNotifyHitPoints();

    notifyListeners();
  }

  void _calculateAgeRangeHandler() {
    final SlideState slideState = _slideState.value;
    final double start;
    final double end;
 
    if(slideState == SlideState.entryTransition) {
      start = 0.0;
      end = _entryTransitionDurationFactor;
    }
    else if(slideState == SlideState.active) {
      start = _entryTransitionDurationFactor;
      end = 1.0 - _entryTransitionDurationFactor;
    }
    else {
      start = 1.0 - _exitTransitionDurationFactor;
      end = 1.0;
    }    
    _slideAgeRangeHandler.setNewRange(start, end);
  }

  void checkAndNotifyHitPoints() {
    final double previousAgeFactor = _getAgeFactorFromScrollFactor(_slidesController.value!.scrollFactor.oldValue);

    final HitPointsActivateChecker hitPointsActivateChecker = HitPointsActivateChecker(
      _hitPoints,
      ageFactor,
      previousAgeFactor,
    );

    hitPointsActivateChecker.checkHitPoints();
  }

  SlideState get slideState => _slideState.value;

  SlideState _calculateSlideState() {
    if(index != _slidesController.value!.currentPage())
      return SlideState.none;

    if(ageFactor <= _entryTransitionDurationFactor)
      return SlideState.entryTransition;

    if(ageFactor >= _exitTransitionStartPoint())
      return SlideState.exitTransition;    

    return SlideState.active;
  }

  double get ageFactor => _getAgeFactorFromScrollFactor(_slidesController.value!.scrollFactor.value);

  double _getAgeFactorFromScrollFactor(final double scrollFactor) {
    double r = scrollFactor - index;
    r = r.clamp(0.0, 1.0);

    return r;
  }

  double get rangeAgeFactor => _rangeAgeFactor;

  double _exitTransitionStartPoint() => 1.0 - _exitTransitionDurationFactor;

  int get index => _index;

  bool get visibility => _visibility;


  late int _index;
  final ReactiveValue<SlidesController?> _slidesController = ReactiveValue<SlidesController?>(null);
  late double _exitTransitionDurationFactor;
  late double _entryTransitionDurationFactor;
  late List<SlideAgeHitPoint>? _hitPoints;
  double _rangeAgeFactor = 0.0;
  final ReactiveValue<SlideState> _slideState = ReactiveValue<SlideState>(SlideState.none);
  bool _visibility = true;
  
  final SlideAgeRangeHandler _slideAgeRangeHandler = SlideAgeRangeHandler(0.0, 0.0);
}