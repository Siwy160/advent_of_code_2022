import 'dart:io';

import 'position.dart';

void main(List<String> arguments) async {
  var input = await File("assets/input_9.txt").readAsString();
  var commands = input.split("\n").map((e) => e.replaceAll("\r", ""));
  List<Position> rope = List.generate(2, (_) => Position(0, 0));

  Set<Position> visitedPositions = {rope.last};
  printCurrentState(rope);
  for (var command in commands) {
    print("command: $command");
    var split = command.split(" ");
    var direction = split[0].parseDirection();
    var movements = int.parse(split[1]);

    for (int i = 0; i < movements; i++) {
      rope.first += direction;
      for (int j = 1; j < rope.length; j++) {
        if (rope[j].distance(rope[j - 1]) > 1) {
          rope[j] = rope[j].moveTowards(rope[j - 1]);
        }
      }
      visitedPositions.add(rope.last);
    }
    printCurrentState(rope);
  }
  //5010 is too high
  print("Total number of tail movements: ${visitedPositions.length}");
}

void printCurrentState(List<Position> rope) {
  var gridSize = 10;
  print('');
  for (var y = gridSize - 1; y >= 0 - gridSize; y--) {
    String currentLine = '';
    for (var x = 0 - gridSize; x < gridSize; x++) {
      var current = Position(x, y);
      if (rope.contains(current)) {
        currentLine += rope.indexOf(current).toString();
      } else if (x == 0 && y == 0) {
        currentLine += "s";
      } else {
        currentLine += ".";
      }
    }
    print(currentLine);
  }
}

extension InputProcessing on String {
  Position parseDirection() {
    switch (this) {
      case 'R':
        return Position(1, 0);
      case 'L':
        return Position(-1, 0);
      case 'U':
        return Position(0, 1);
      case 'D':
        return Position(0, -1);
    }
    return Position(0, 0);
  }
}
