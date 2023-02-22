class Tuple<T1, T2> {
  final T1 first;
  final T2 second;

  Tuple(this.first, this.second);

  operator [](int index) {
    if (index == 0) {
      return this.first;
    } else if (index == 1) {
      return this.second;
    } else {
      throw IndexError.withLength(index, 2);
    }
  }

  @override
  String toString() {
    return 'Tuple<$first, $second>';
  }
}
