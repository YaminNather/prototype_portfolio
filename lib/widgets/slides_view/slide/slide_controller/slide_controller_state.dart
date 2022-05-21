class SlideAgeRangeHandler {
  SlideAgeRangeHandler(this._start, this._end);

  void setNewRange(final double start, final double end) {
    _start = start;
    _end = end;
  }

  double getAgeFactor(final double slideAgeFactor) {
    final double difference = _end - _start;
    final double ageFactor = (slideAgeFactor - _start) / difference;

    return ageFactor;
  }



  double _start;
  double _end;
}