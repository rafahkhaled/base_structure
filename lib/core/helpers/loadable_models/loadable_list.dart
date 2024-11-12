class LoadableList<T> {
  final List<T> _items;
  List<T> get items => _items;
  bool isLoading = false;
  bool get isEmpty => _items.isEmpty;
  bool get isNotEmpty => _items.isNotEmpty;
  int get length => _items.length;

  LoadableList({List<T>? initial})
      : _items = initial == null
            ? List.empty(growable: true)
            : List.from(initial, growable: true);

  void clear() {
    _items.clear();
  }

  void addRange(Iterable<T> elements) {
    _items.addAll(elements);
  }

  void remove(T element) {
    _items.remove(element);
  }

  void add(T element) {
    _items.add(element);
  }

  void addTop(T element) {
    _items.insert(0, element);
  }
}

