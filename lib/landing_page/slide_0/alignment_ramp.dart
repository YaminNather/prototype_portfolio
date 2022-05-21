import 'package:flutter/widgets.dart';

class AlignmentRamp {
  factory AlignmentRamp(List<Alignment> points, {List<double>? pointPositions}) {
    final List<double> finalPointPositions;
    if(pointPositions == null) {
      final double distance = 1.0 / points.length;
      finalPointPositions = List<double>.generate(
        points.length + 1,
        (index) => distance * index
      );
    }
    else
      finalPointPositions = pointPositions;

    finalPointPositions.last = 1.0;    

    return AlignmentRamp._(points, finalPointPositions);
  }

  const AlignmentRamp._(this._points, this._pointPositions) 
  : assert(
    _points.length >= 2,
    _pointPositions.length == _points.length
  );

  Alignment sample(final double t) {
    final int firstPointIndex = _getFirstPointIndexForT(t);
    final secondPointIndex = _getSecondPointIndexFromFirstPointIndex(firstPointIndex);

    return _sampleBetweenPoints(firstPointIndex, secondPointIndex, t);
  }

  Alignment _sampleBetweenPoints(int firstPointIndex, int secondPointIndex, double t) {
    final double firstPointPosition = _pointPositions[firstPointIndex];
    final double secondPointPosition = _pointPositions[secondPointIndex];
    final double difference = secondPointPosition - firstPointPosition;

    final double sampleFactor = (t - firstPointPosition) / difference;

    return Alignment.lerp(_points[firstPointIndex], _points[secondPointIndex], sampleFactor)!;
  }

  int _getFirstPointIndexForT(final double t) {
    for(int i = 0; i < _pointPositions.length; i++) {
      if(_pointPositions[i] > t)
        return (i - 1).clamp(0, _pointPositions.length);
    }

    throw Exception();
  }

  int _getSecondPointIndexFromFirstPointIndex(final int firstPointIndex) {
    if(firstPointIndex == _points.length - 1)
      return firstPointIndex;

    return firstPointIndex + 1;
  }


  final List<Alignment> _points;
  final List<double> _pointPositions;
}