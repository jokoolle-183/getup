class Pair<L, R> {
  final L left;
  final R right;

  Pair(this.left, this.right);

  Pair<L, R> copyWith({L? left, R? right}) {
    return Pair(
      left ?? this.left,
      right ?? this.right,
    );
  }

  @override
  String toString() => 'Pair($left, $right)';
}
