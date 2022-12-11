import 'item.dart';

class Operation {
  final OperationType type;
  final int argument;

  Operation(this.type, this.argument);

  Item perform(Item base) {
    switch (type) {
      case OperationType.plus:
        return base.plus(argument);
      case OperationType.times:
        return base.times(argument);
      case OperationType.square:
        return base * base;
    }
  }
}

enum OperationType {
  plus,
  times,
  square;
}
