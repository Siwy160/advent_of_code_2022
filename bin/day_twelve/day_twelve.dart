import 'dart:io';

import '../input_extensions.dart';
import 'dijkstra.dart';

void main(List<String> arguments) async {
  var input = await File("assets/input_12.txt").readAsString();
  Node start = Node(Position(0, 0), 0);
  Node end = Node(Position(0, 0), 0);
  Graph graph = Graph();

  input.iterateThroughGrid((x, y, char) {
    var currentNode = graph.getOrCreateNode(Position(x, y), toHeight(char));
    if (char == 'S') {
      start = currentNode;
    } else if (char == 'E') {
      end = currentNode;
    }
  });
  input.iterateThroughGrid((x, y, char) {
    var current = graph.get(Position(x, y));
    if (current != null) {
      bool heightCheck(Node? node) => node != null && (node.height - current.height) <= 1;
      var top = graph.get(Position(x, y - 1));
      var bottom = graph.get(Position(x, y + 1));
      var left = graph.get(Position(x - 1, y));
      var right = graph.get(Position(x + 1, y));
      if (heightCheck(top)) {
        current.adjacentNodes.add(top!);
      }
      if (heightCheck(bottom)) {
        current.adjacentNodes.add(bottom!);
      }
      if (heightCheck(left)) {
        current.adjacentNodes.add(left!);
      }
      if (heightCheck(right)) {
        current.adjacentNodes.add(right!);
      }
    }
  });

  //Part 1
  var shortestPath = findShortestPath(graph, start, end);
  print(shortestPath.length);
  //Part 2
  graph.nodes.values.forEach((element) {
    if (element.height == toHeight("a")) {
      var potentialRoute = findShortestPath(graph, element, end);
      if (potentialRoute.isNotEmpty && potentialRoute.length < shortestPath.length) {
        shortestPath = potentialRoute;
      }
    }
  });
  print(shortestPath.length);
}

int toHeight(String input) {
  int index(String char) => char.codeUnits.first;
  if (input == "S") {
    return index("a");
  } else if (input == "E") {
    return index("z");
  } else {
    return index(input);
  }
}
