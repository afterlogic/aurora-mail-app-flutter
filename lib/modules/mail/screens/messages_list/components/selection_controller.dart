class SelectionController<K, I> {
  final _selected = <K, I>{};
  final _listeners = <Function()>[];
  var _enable = false;

  set enable(bool value) {
    if (_enable != value) {
      _enable = value;
      clear();
      notify();
    }
  }

  bool get enable => _enable;

  Map<K, I> get selected => _selected;

  clear() {
    _selected.clear();
    notify();
  }

  add(K key, I item) {
    enable = true;
    _selected[key] = item;
    notify();
  }

  remove(K key) {
    _selected.remove(key);
    if (selected.length == 0) {
      enable = false;
    }
    notify();
  }

  bool isSelected(K key) => _selected.containsKey(key);

  addOrRemove(K key, I item) {
    if (isSelected(key)) {
      remove(key);
    } else {
      add(key, item);
    }
  }

  notify() {
    for (var value in _listeners) {
      value();
    }
  }

  addListener(Function() listener) {
    _listeners.add(listener);
  }

  removeListener(Function() listener) {
    _listeners.remove(listener);
  }
}
