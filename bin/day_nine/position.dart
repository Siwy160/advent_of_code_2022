import 'dart:math';

class Position {
  final int x;
  final int y;

  Position(this.x, this.y);

  int distance(Position position) {
    var xSquared = (position.x - x) * (position.x - x);
    var ySquared = (position.y - y) * (position.y - y);
    return sqrt(xSquared.toDouble() + ySquared.toDouble()).round();
  }

  /// Returns new position moved by one tile towards target.
  Position moveTowards(Position target) {
    Position difference = target - this;
    return this + difference.normalize();
  }

  Position normalize() {
    if (magnitude() > 0) {
      return this / magnitude();
    }
    return this;
  }

  int magnitude() => sqrt(x * x + y * y).round();

  operator +(Position other) => Position(x + other.x, y + other.y);

  operator -(Position other) => Position(x - other.x, y - other.y);

  operator /(int value) => Position((x / value).round(), (y / value).round());

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Position && runtimeType == other.runtimeType && x == other.x && y == other.y;

  @override
  int get hashCode => x.hashCode ^ y.hashCode;
}
