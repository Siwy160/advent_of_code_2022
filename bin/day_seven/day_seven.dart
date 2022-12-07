import 'dart:io' as io;

import 'file_tree.dart';

void main(List<String> arguments) async {
  var input = await io.File("assets/input_7.txt").readAsString();
  var commands = input.split("\n").map((e) => e.replaceAll("\r", ""));
  var fileTree = FileTree();
  List<String> currentPath = [];
  var isListing = false;
  commands.forEach(
    (element) {
      var splitted = element.split(" ");
      if (splitted[0] == "\$") {
        //Executing command
        if (splitted[1] == "ls") {
          //Listing contents of current directory
          isListing = true;
        }
        if (splitted[1] == "cd") {
          //Changing directory
          if (splitted[2] == "..") {
            currentPath.removeLast();
          } else {
            currentPath.add(splitted[2]);
          }
        }
      } else {
        Item currentItem;
        if (splitted[0] == "dir") {
          currentItem = Directory(splitted[1]);
        } else {
          currentItem = File(splitted[1], int.parse(splitted[0]));
        }
        fileTree.insertTo(currentItem, currentPath);
      }
    },
  );
  var sizeTaken = fileTree
      .getAllDirectories(fileTree.root)
      .where((value) => value.size() < 100000)
      .map((e) => e.size())
      .reduce((value, element) => value + element);

  print("first star: $sizeTaken");

  var totalSize = 70000000;
  var sizeNeeded = 30000000;
  var availableSize = totalSize - fileTree.root.size();

  var result2 = fileTree.getAllDirectories(fileTree.root);
  result2.sort((a, b) => a.size() - b.size());
  Directory? directoryToRemove;
  for (final e in result2) {
    var freeSpaceIfRemoved = availableSize + e.size();
    directoryToRemove = e;
    if (freeSpaceIfRemoved > sizeNeeded) {
      break;
    }
  }
  print("secondStar: ${directoryToRemove?.size()}");
}
