extension ReadingInput on String {
  String read(int x, int y) {
    var countSpace = 1;
    if (numberOfColumns() == x) countSpace = 0;
    int charsInRow = indexOf('\n') + 1;
    var row = (y - 1) * charsInRow;
    var firstChar = row + x * (3 + countSpace);
    var item = substring(firstChar, firstChar + 3);
    return item[1];
  }

  int numberOfColumns() {
    int charsPerColumn = 4;
    return (indexOf('\n') / charsPerColumn).floor();
  }

  int numberOfRows() {
    int charsInRow = indexOf('\n');
    int firstNumber = indexOf(' 1');
    return (firstNumber / charsInRow).floor();
  }
}
