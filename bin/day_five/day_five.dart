import 'dart:io';

import 'string_utils.dart';
import 'warehouse.dart';

void main(List<String> arguments) async {
  var input = await File("assets/input_5.txt").readAsString();
  var operations = readOperations(input.split('\r\n\r\n')[1]);

  //Part 1
  var warehouse = fillWarehouse(input);
  operations.forEach((operation) => warehouse.performWithCrateMove9000(operation));
  print("result: ${warehouse.readTop()}");

  //Part 2
  warehouse = fillWarehouse(input);
  operations.forEach((operation) => warehouse.performWithCrateMove9001(operation));
  print("result: ${warehouse.readTop()}");
}

Warehouse fillWarehouse(String input) {
  var numberOfColumns = input.numberOfColumns();
  var numberOfRows = input.numberOfRows();
  var warehouse = Warehouse(numberOfColumns);
  for (var y = numberOfRows; y > 0; y--) {
    for (var x = 0; x < numberOfColumns; x++) {
      var item = input.read(x, y);
      if (item != ' ') {
        warehouse.putOnStack(x, item);
      }
    }
  }
  return warehouse;
}

List<Operation> readOperations(String input) {
  var lines = input.split('\r\n');
  return lines.map<Operation>((element) {
    var splitted = element.split(' ');
    return Operation(
      int.parse(splitted[1]),
      int.parse(splitted[3]) - 1,
      int.parse(splitted[5]) - 1,
    );
  }).toList();
}

class Operation {
  int count;
  int from;
  int to;

  Operation(this.count, this.from, this.to);
}
