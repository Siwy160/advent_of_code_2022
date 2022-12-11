import 'dart:io';

import 'item.dart';
import 'monkey.dart';
import 'operation.dart';

void main(List<String> arguments) async {
  List<Monkey> monkeys = await parseInputFile("assets/input_11.txt");
  var rounds = 10000;
  var timeStarted = DateTime.now().millisecondsSinceEpoch;
  for (int i = 0; i < rounds; i++) {
    print("round: $i");
    var superModulo = 1;
    for(int i = 0;i<monkeys.length;i++){
      superModulo *= monkeys[i].testDivisibleBy;
    }
    for (int j = 0; j < monkeys.length; j++) {
      var monkey = monkeys[j];
      var result = monkey.perform(superModulo);
      result.forEach((element) {
        monkeys[element.targetMonkey].addItem(element.item);
      });
    }
  }
  print("took: ${DateTime.now().millisecondsSinceEpoch - timeStarted}ms");

  monkeys.forEach((element) {
    var inspected = element.timesItemsInspected;
    var name = element.name;
    print("Monkey  $name inspected items $inspected times.");
  });

  monkeys.sort((monkey, monkey2) =>
      monkey2.timesItemsInspected - monkey.timesItemsInspected);
  var monkeyBusiness =
      monkeys[0].timesItemsInspected * monkeys[1].timesItemsInspected;
  print("Result: $monkeyBusiness");
}

Future<List<Monkey>> parseInputFile(String filename) async {
  List<Monkey> monkeys = [];

  var input = await File(filename).readAsString();
  var operations = input.split('\r\n\r\n');
  var name = 0;
  operations.forEach((monkeyInput) {
    var monkey = parse(monkeyInput, name);
    monkeys.add(monkey);
    name++;
  });

  return monkeys;
}

Monkey parse(String monkeyInput, int name) {
  List<Item> heldItems = [];
  Operation operation = Operation(OperationType.times, 0);
  int testDivisibleBy = 0;
  int trueThrowItemTarget = 0;
  int falseThrowItemTarget = 0;
  var lines = monkeyInput.split('\r\n');
  for (int i = 1; i < lines.length; i++) {
    var line = lines[i];
    switch (i) {
      case 0:
        // Monkey name. Itnored
        break;
      case 1:
        // Starting items
        heldItems.addAll(line
            .split(':')[1]
            .split(',')
            .map((e) => e.trim())
            .map((e) => Item.fromString(e)));
        break;
      case 2:
        // Operation
        var split = line.split(" = ")[1].split(' ');
        OperationType type;
        int argument = int.tryParse(split[2]) ?? 0;
        switch (split[1]) {
          case '+':
            type = OperationType.plus;
            break;
          case '*':
            if (split[2] == 'old') {
              type = OperationType.square;
            } else {
              type = OperationType.times;
            }
            break;
          default:
            throw FormatException("Unrecognized operation: ${split[1]}");
        }
        operation = Operation(type, argument);
        break;
      case 3:
        testDivisibleBy = int.parse(line.split(' ').last);
        break;
      case 4:
        trueThrowItemTarget = int.parse(line.split(' ').last);
        break;
      case 5:
        falseThrowItemTarget = int.parse(line.split(' ').last);
    }
  }

  return Monkey(
    heldItems,
    testDivisibleBy,
    operation,
    trueThrowItemTarget,
    falseThrowItemTarget,
    name,
  );
}
