class ReactiveValue<T> {
  ReactiveValue(final T initialValue) : _value = initialValue, _oldValue = initialValue;

  void addListener(OnChangedFunction<T> listener) {
    _listeners.add(listener);
  }

  void removeListener(OnChangedFunction<T> listener) {
    _listeners.remove(listener);
  }

  T get value => _value;

  set value(T newValue) {
    if(_value == newValue)
      return;
    
    _oldValue = _value;
    _value = newValue;

    _notifyListeners();
  }

  T get oldValue => _oldValue;

  void _notifyListeners() {
    for(final listener in _listeners)
      listener(oldValue, value);
  }



  T _value;
  T _oldValue;

  final List<OnChangedFunction<T>> _listeners = <OnChangedFunction<T>>[];
}

typedef OnChangedFunction<T> = void Function(T oldValue, T newValue);