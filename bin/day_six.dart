import 'dart:collection';
import 'dart:io';

void main(List<String> arguments) async {
  var input = await File("assets/input_6.txt").readAsString();
  var uniqueCharsToLook = 14;
  for (var i = uniqueCharsToLook; i < input.length; i++) {
    var set = HashSet<int>();
    var substring = input.substring(i - uniqueCharsToLook, i);
    set.addAll(substring.runes.toList());
    if (set.length == uniqueCharsToLook) {
      print(i);
      return;
    }
  }
}
