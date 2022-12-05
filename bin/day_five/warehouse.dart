import 'day_five.dart';

class Warehouse {
  final List<Stack<String>> _stacks;

  Warehouse(int stacks) : _stacks = List.generate(stacks, (_) => Stack());

  String pickFromStack(int stack) => _stacks[stack].pop();

  void putOnStack(int stack, String item) => _stacks[stack].push(item);

  void performWithCrateMove9000(Operation operation) {
    for (var i = 0; i < operation.count; i++) {
      var item = pickFromStack(operation.from);
      putOnStack(operation.to, item);
    }
  }

  void performWithCrateMove9001(Operation operation) {
    List<String> picked = [];
    for (var i = 0; i < operation.count; i++) {
      picked.add(pickFromStack(operation.from));
    }
    picked.reversed.forEach((element) => putOnStack(operation.to, element));
  }

  String readTop() => _stacks.map((e) => e.peek()).join();

  @override
  String toString() {
    return 'Warehouse{_stacks: $_stacks}';
  }
}

class Stack<E> {
  final _list = <E>[];

  void push(E value) => _list.add(value);

  E pop() => _list.removeLast();

  E peek() => _list.last;
}
