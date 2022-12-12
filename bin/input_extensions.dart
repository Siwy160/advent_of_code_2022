extension ReadingInput on String {
  void iterateThroughGrid(Function(int x, int y, String char) onItem) {
    var lines = split("\r\n");
    for (int y = 0; y < lines.length; y++) {
      var currentLine = lines[y];
      for (int x = 0; x < lines[0].length; x++) {
        onItem(x, y, currentLine[x]);
      }
    }
  }
}
