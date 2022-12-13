import 'dart:collection';
import 'dart:math';

class Position {
  final int _x;
  final int _y;

  Position(this._x, this._y);

  int distance(Position position) {
    var xSquared = (position.x - x) * (position.x - x);
    var ySquared = (position.y - y) * (position.y - y);
    return sqrt(xSquared.toDouble() + ySquared.toDouble()).round();
  }

  int get y => _y;

  int get x => _x;

  @override
  bool operator ==(Object other) => other is Position && _x == other._x && _y == other._y;

  @override
  int get hashCode => _x.hashCode ^ _y.hashCode;

  @override
  String toString() {
    return 'Position{x: $_x, y: $_y}';
  }
}

class Graph {
  Map<Position, Node> nodes = HashMap();

  Node getOrCreateNode(Position position, int height) =>
      nodes.putIfAbsent(position, () => Node(position, height));

  Node? get(Position position) => nodes[position];
}

class Node extends LinkedListEntry<Node> {
  final Position _position;
  final int _height;
  int distance = 9999999;
  List<Node> adjacentNodes = List.empty(growable: true);
  List<Node> shortestPath = List.empty(growable: true);

  Node(this._position, this._height);

  void addDestination(Node destination) {
    adjacentNodes.add(destination);
  }

  Position get position => _position;

  int get height => _height;

  @override
  bool operator ==(Object other) => other is Node && _position == other._position;

  @override
  int get hashCode => _position.hashCode;
}

List<Node> findShortestPath(Graph graph, Node start, Node end) {
  graph.nodes.values.forEach((element) {
    element.distance = 9999999;
    element.shortestPath = List.empty(growable: true);
  });
  start.distance = 0;
  Set<Node> unsettledNodes = {start};
  Set<Node> settledNodes = {};

  while (unsettledNodes.isNotEmpty) {
    var currentNode = unsettledNodes.getLowestDistanceNode();
    if (currentNode == end) {
      return end.shortestPath;
    }
    unsettledNodes.remove(currentNode);
    for (Node adjacent in currentNode.adjacentNodes) {
      if (!settledNodes.contains(adjacent)) {
        calculateMinimumDistance(adjacent, currentNode);
        unsettledNodes.add(adjacent);
      }
    }
    settledNodes.add(currentNode);
  }
  return end.shortestPath;
}

void calculateMinimumDistance(Node evaluationNode, Node sourceNode) {
  var sourceDistance = sourceNode.distance + 1;
  if (sourceDistance < evaluationNode.distance) {
    evaluationNode.distance = sourceDistance;
    List<Node> shortestPath = List.from(sourceNode.shortestPath);
    shortestPath.add(sourceNode);
    evaluationNode.shortestPath = shortestPath;
  }
}

extension Utils on Set<Node> {
  Node getLowestDistanceNode() {
    Node lowestDistance = first;
    forEach((element) {
      if (element.distance < lowestDistance.distance) {
        lowestDistance = element;
      }
    });
    return lowestDistance;
  }
}
