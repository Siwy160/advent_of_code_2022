import 'dart:io';

void main(List<String> arguments) async {
  var input = await File("assets/input_10.txt").readAsString();
  var commands = input.split("\n").map((e) => e.replaceAll("\r", ""));

  var currentCycle = 0;
  var xRegister = 1;
  var cyclesToCount = [20, 60, 100, 140, 180, 220];
  var result = 0;
  var image = "";

  void draw() {
    var positionToLook = currentCycle % 40;
    var canDraw = xRegister + 1 == positionToLook ||
        xRegister - 1 == positionToLook ||
        xRegister == positionToLook;
    if (canDraw) {
      image += "#";
    } else {
      image += ".";
    }
  }

  void incrementCycle() {
    currentCycle++;
    if (cyclesToCount.contains(currentCycle)) {
      print(
          "cycle:$currentCycle xRegister:$xRegister  result:${currentCycle * xRegister}");
      result += currentCycle * xRegister;
    }
  }

  for (var line in commands) {
    var split = line.split(" ");
    var command = split.first;
    var argument = 0;
    if (split.length > 1) {
      argument = int.parse(split[1]);
    }
    if (command == "noop") {
      draw();
      incrementCycle();
    }
    if (command == "addx") {
      for (int i = 0; i < 2; i++) {
        draw();
        incrementCycle();
        if (i == 1) {
          xRegister += argument;
        }
      }
    }
  }
  print("result: $result");

  var screen = "";
  for (int i = 0; i < image.length; i++) {
    if (i % 40 == 0) {
      screen += "\n";
    }
    screen += image[i];
  }
  print("screen: $screen");
}
