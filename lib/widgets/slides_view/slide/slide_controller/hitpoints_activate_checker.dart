import 'dart:math';
import '../slide_age_hit_point.dart';

class HitPointsActivateChecker {
  const HitPointsActivateChecker(this.hitPoints, this._ageFactor, this._previousAgeFactor);

  void checkHitPoints() {
    final List<SlideAgeHitPoint>? hitPoints = this.hitPoints;

    if(hitPoints == null)
      return;

    for(final hitPoint in hitPoints) {
      if(_didHitPoint(hitPoint)) {        
        hitPoint.onHit();
      }
    }
  }

  bool _didHitPoint(final SlideAgeHitPoint hitPoint) {  
    final double smallerScrollFactorPoint = min(_previousAgeFactor, _ageFactor);
    final double largerScrollFactorPoint = max(_previousAgeFactor, _ageFactor);

    return hitPoint.at > smallerScrollFactorPoint && hitPoint.at < largerScrollFactorPoint;
  }


  
  final double _ageFactor;
  final double _previousAgeFactor;  
  final List<SlideAgeHitPoint>? hitPoints;
}