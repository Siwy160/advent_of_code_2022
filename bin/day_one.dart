import 'dart:io';

void main(List<String> arguments) async {
  var input = await File("assets/input.txt").readAsString();
  var chunked = input.split('\n');

  var result = [];
  var sumOfChunk = 0;
  for (var element in chunked) {
    var potentialResult = int.tryParse(element);
    if (potentialResult == null) {
      result.add(sumOfChunk);
      sumOfChunk = 0;
    } else {
      sumOfChunk += potentialResult;
    }
  }
  result.sort();
  print(result.reversed.take(3).reduce((value, element) => value + element));
}
