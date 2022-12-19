import 'blueprint.dart';

class Factory {
  int obsidianCollectingRobots = 0;
  int oreCollectingRobots = 1;
  int clayCollectingRobots = 0;
  int geodeCrackingRobots = 0;

  int ore = 0;
  int obsidian = 0;
  int geodes = 0;
  int clay = 0;

  final Blueprint blueprint;
  final StopBuildingInstructions instructions;

  Factory(this.blueprint, this.instructions);

  int operate(int durationMinutes) {
    for (int m = 0; m < durationMinutes; m++) {
      _performCycle(m);
    }
    return geodes * blueprint.id;
  }

  void _performCycle(int currentCycle) {
    var additionalOre = oreCollectingRobots;
    var additionalClay = clayCollectingRobots;
    var additionalObsidian = obsidianCollectingRobots;
    var additionalGeodes = geodeCrackingRobots;
    if (ore >= blueprint.clayRobotCost &&
        currentCycle < instructions.stopClayRobotsAt &&
        currentCycle >= instructions.startClayRobotsAt) {
      ore -= blueprint.clayRobotCost;
      clayCollectingRobots++;
    }
    if (ore >= blueprint.oreRobotCost &&
        currentCycle < instructions.stopOreRobotsAt &&
        currentCycle >= instructions.startOreRobotsAt) {
      ore -= blueprint.oreRobotCost;
      oreCollectingRobots++;
    }
    if (ore >= blueprint.obsidianRobotOreCost &&
        clay >= blueprint.obsidianRobotClayCost &&
        currentCycle < instructions.stopObsidianRobotsAt &&
        currentCycle >= instructions.startObsidianRobotsAt) {
      ore -= blueprint.obsidianRobotOreCost;
      clay -= blueprint.obsidianRobotClayCost;
      obsidianCollectingRobots++;
    }
    if (obsidian >= blueprint.geodeRobotObsidianCost && ore >= blueprint.geodeRobotOreCost) {
      obsidian -= blueprint.geodeRobotObsidianCost;
      ore -= blueprint.geodeRobotOreCost;
      geodeCrackingRobots++;
    }
    ore += additionalOre;
    clay += additionalClay;
    obsidian += additionalObsidian;
    geodes += additionalGeodes;
  }
}
