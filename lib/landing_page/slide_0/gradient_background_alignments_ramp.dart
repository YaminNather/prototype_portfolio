import 'package:flutter/rendering.dart';

import 'alignment_ramp.dart';

class GradientBackgroundAlignmentsRamp {
  GradientBackgroundAlignmentsRamp() : 
    _ramp0 = AlignmentRamp(
      <Alignment>[Alignment.topLeft, Alignment.topRight, Alignment.bottomRight, Alignment.bottomLeft, Alignment.topLeft]
    ),
    _ramp1 = AlignmentRamp(
      <Alignment>[Alignment.bottomRight, Alignment.bottomLeft, Alignment.topLeft, Alignment.topRight, Alignment.bottomRight]
    );



  GradientBackgroundAlignments sample(final double t) {
    return GradientBackgroundAlignments(_ramp0.sample(t), _ramp1.sample(t));
  }

  final AlignmentRamp _ramp0;
  final AlignmentRamp _ramp1;
}

class GradientBackgroundAlignments {
  const GradientBackgroundAlignments(this.start, this.end);

  final Alignment start;
  final Alignment end;
}