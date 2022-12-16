import 'dart:convert';
import 'dart:io';

void main(List<String> arguments) async {
  var input = await File("assets/input_13.txt").readAsString();
  var pairsOfPackets = input.replaceAll("\r", "").split("\n\n");

  //Part 1
  var currentIndex = 1;
  var sumOfCorrectIndexes = 0;
  pairsOfPackets.forEach((element) {
    var pair = element.split('\n');
    var firstPair = jsonDecode(pair[0]);
    var secondPair = jsonDecode(pair[1]);
    var result = compare(firstPair, secondPair);
    print("$currentIndex rightOrder:$result first:$firstPair second:$secondPair");
    if (result == 1) {
      sumOfCorrectIndexes += currentIndex;
    }
    currentIndex++;
  });
  print("result: $sumOfCorrectIndexes");

  //Part 2
  var listOfPackets = input.replaceAll("\r", "").replaceAll("\n\n", "\n").split("\n");
  var firstDividerPacket = "[[2]]";
  var secondDividerPacket = "[[6]]";
  listOfPackets.add(firstDividerPacket);
  listOfPackets.add(secondDividerPacket);
  listOfPackets.sort((first, second) =>
      compare(jsonDecode(second), jsonDecode(first))
  );
  var result = (listOfPackets.indexOf(firstDividerPacket) + 1) *
      (listOfPackets.indexOf(secondDividerPacket) + 1);
  print("result: $result");
}

///
/// 1 - first
/// 0 - undefined
/// -1 - second
int compare(List<dynamic> first, List<dynamic> second) {
  var longerLength = first.length;
  if (second.length > longerLength) {
    longerLength = second.length;
  }
  for (int i = 0; i < longerLength; i++) {
    if (i >= first.length) {
      return 1;
    }
    if (i >= second.length) {
      return -1;
    }
    var firstItem = first[i];
    var secondItem = second[i];
    print("comparing: $firstItem to $secondItem");
    if (firstItem is int && secondItem is int) {
      if (firstItem < secondItem) {
        return 1;
      }
      if (firstItem > secondItem) {
        return -1;
      }
    }
    if (firstItem is int && secondItem is List) {
      var result = compare([firstItem], secondItem);
      if (result == 1 || result == -1) {
        return result;
      }
    }
    if (firstItem is List && secondItem is int) {
      var result = compare(firstItem, [secondItem]);
      if (result == 1 || result == -1) {
        return result;
      }
    }
    if (firstItem is List && secondItem is List) {
      var result = compare(firstItem, secondItem);
      if (result == 1 || result == -1) {
        return result;
      }
    }
  }
  return 0;
}
