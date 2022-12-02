import 'dart:io';

void main(List<String> arguments) async {
  var input = await File("assets/input_2.txt").readAsString();
  var chunked = input.split('\n');

  var points = 0;
  for (var element in chunked) {
    var splitted = element.split(' ');

    var opponent = 0;
    var desiredOutcome = 0;
    switch (splitted[0]) {
      case 'A':
        opponent = 1;
        break;
      case 'B':
        opponent = 2;
        break;
      case 'C':
        opponent = 3;
        break;
    }
    switch (splitted[1][0]) {
      case 'X':
        desiredOutcome = 1;
        break;
      case 'Y':
        desiredOutcome = 2;
        break;
      case 'Z':
        desiredOutcome = 3;
        break;
    }

    // 1 - kamien
    // 2 - paper
    // 3 - nozyce
    if (desiredOutcome == 2) {
      //I need to draw
      points += 3;
      points += opponent;
    }
    if (desiredOutcome == 1) {
      // I need to lose
      if (opponent == 1) {
        points += 3;
      }
      if (opponent == 2) {
        points += 1;
      }
      if (opponent == 3) {
        points += 2;
      }
    }
    if (desiredOutcome == 3) {
      // I need to win
      points += 6;
      if (opponent == 1) {
        points += 2;
      }
      if (opponent == 2) {
        points += 3;
      }
      if (opponent == 3) {
        points += 1;
      }
    }
  }
  print(points);
}
