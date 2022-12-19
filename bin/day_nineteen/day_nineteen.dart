import 'dart:io';

import 'blueprint.dart';
import 'factory.dart';

void main(List<String> arguments) async {
  var cycles = 24;
  var input = await File("assets/input_19.txt").readAsString();
  var blueprints = input.split("\r").map((e) => e.toBlueprint());
  var instructions = generateAllInstructions(cycles);
  var bestResult = 0;
  blueprints.forEach((element) {
    var result = testBlueprint(element, instructions, cycles);
    bestResult += result;
  });
  print("result: $bestResult");
}

int testBlueprint(Blueprint blueprint, List<StopBuildingInstructions> instructions, int cycles) {
  var bestResult = 0;
  instructions.forEach((element) {
    var factory = Factory(blueprint, element);
    var potentialResult = factory.operate(cycles);
    if (potentialResult > bestResult) {
      bestResult = potentialResult;
    }
  });
  print("Best result for blueprint: ${blueprint.id} is:$bestResult");
  return bestResult;
}

extension InputParser on String {
  Blueprint toBlueprint() {
    var regex = RegExp(r'\d+');
    var numbers = regex.allMatches(this);

    return Blueprint(
      int.parse(numbers.elementAt(0).group(0).toString()),
      int.parse(numbers.elementAt(1).group(0).toString()),
      int.parse(numbers.elementAt(2).group(0).toString()),
      int.parse(numbers.elementAt(3).group(0).toString()),
      int.parse(numbers.elementAt(4).group(0).toString()),
      int.parse(numbers.elementAt(5).group(0).toString()),
      int.parse(numbers.elementAt(6).group(0).toString()),
    );
  }
}
