class Blueprint {
  final int id;
  final int oreRobotCost;
  final int clayRobotCost;
  final int obsidianRobotOreCost;
  final int obsidianRobotClayCost;
  final int geodeRobotOreCost;
  final int geodeRobotObsidianCost;

  Blueprint(
    this.id,
    this.oreRobotCost,
    this.clayRobotCost,
    this.obsidianRobotOreCost,
    this.obsidianRobotClayCost,
    this.geodeRobotOreCost,
    this.geodeRobotObsidianCost,
  );

  @override
  String toString() {
    return 'Blueprint{id: $id, oreRobotCost: $oreRobotCost, clayRobotCost: $clayRobotCost, obsidianRobotOreCost: $obsidianRobotOreCost, obsidianRobotClayCost: $obsidianRobotClayCost, geodeRobotOreCost: $geodeRobotOreCost, geodeRobotObsidianCost: $geodeRobotObsidianCost}';
  }
}

class StopBuildingInstructions {
  final int startClayRobotsAt;
  final int stopClayRobotsAt;
  final int startOreRobotsAt;
  final int stopOreRobotsAt;
  final int startObsidianRobotsAt;
  final int stopObsidianRobotsAt;

  StopBuildingInstructions(
    this.startClayRobotsAt,
    this.stopClayRobotsAt,
    this.startOreRobotsAt,
    this.stopOreRobotsAt,
    this.startObsidianRobotsAt,
    this.stopObsidianRobotsAt,
  );

  @override
  String toString() {
    return 'StopBuildingInstructions{stopClayRobotsAt: $stopClayRobotsAt, stopOreRobotsAt: $stopOreRobotsAt, stopObsidianRobotsAt: $stopObsidianRobotsAt}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StopBuildingInstructions &&
          runtimeType == other.runtimeType &&
          startClayRobotsAt == other.startClayRobotsAt &&
          stopClayRobotsAt == other.stopClayRobotsAt &&
          startOreRobotsAt == other.startOreRobotsAt &&
          stopOreRobotsAt == other.stopOreRobotsAt &&
          startObsidianRobotsAt == other.startObsidianRobotsAt &&
          stopObsidianRobotsAt == other.stopObsidianRobotsAt;

  @override
  int get hashCode =>
      startClayRobotsAt.hashCode ^
      stopClayRobotsAt.hashCode ^
      startOreRobotsAt.hashCode ^
      stopOreRobotsAt.hashCode ^
      startObsidianRobotsAt.hashCode ^
      stopObsidianRobotsAt.hashCode;
}

List<StopBuildingInstructions> generateAllInstructions(int cycles) {
  List<StopBuildingInstructions> result = [];
  for (int oreStart = 0; oreStart < cycles; oreStart++) {
    print("generating: ${oreStart/cycles}");
    for (int oreEnd = 0; oreEnd < cycles; oreEnd++) {
      for (int clayStart = 0; clayStart < cycles; clayStart++) {
        for (int clayEnd = 0; clayEnd < cycles; clayEnd++) {
          for (int obsidianStart = 0; obsidianStart < cycles; obsidianStart++) {
            for (int obsidianEnd = 0; obsidianEnd < cycles; obsidianEnd++) {
              result.add(StopBuildingInstructions(
                  clayStart, clayEnd, oreStart, oreEnd, obsidianStart, obsidianEnd));
            }
          }
        }
      }
    }
  }
  print("generated");
  return result;
}
