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
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Position && runtimeType == other.runtimeType && _x == other._x && _y == other._y;

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
  int distance = 0;
  List<Node> adjacentNodes = List.empty(growable: true);
  List<Node> shortestPath = List.empty(growable: true);

  Node(this._position, this._height);

  void addDestination(Node destination) {
    adjacentNodes.add(destination);
  }

  Position get position => _position;

  int get height => _height;
}

List<Node> findShortestPath(Graph graph, Node start, Node end) {
  List<Node> unsettledNodes = [end];
  List<Node> settledNodes = List.empty(growable: true);

  while (unsettledNodes.isNotEmpty) {
    var currentNode = unsettledNodes.getLowestDistanceNode();
    unsettledNodes.remove(currentNode);
    for (Node adjacent in currentNode.adjacentNodes) {
      var value = (adjacent.height - currentNode.height);
      if (!settledNodes.contains(adjacent)) {
        calculateMinimumDistance(adjacent, value, currentNode);
        unsettledNodes.add(adjacent);
      }
    }
    settledNodes.add(currentNode);
  }
  return start.shortestPath;
}

void calculateMinimumDistance(Node evaluationNode, int edgeWeight, Node sourceNode) {
  var sourceDistance = sourceNode.distance;
  if (sourceDistance + edgeWeight < evaluationNode.distance) {
    evaluationNode.distance = sourceDistance + edgeWeight;
    var shortestPath = sourceNode.shortestPath;
    shortestPath.add(sourceNode);
    evaluationNode.shortestPath = shortestPath;
  }
}

extension Utils on List<Node> {
  Node getLowestDistanceNode() {
    sort((element, element1) => element.distance - element1.distance);
    return last;
  }
}
