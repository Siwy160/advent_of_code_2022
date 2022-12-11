import 'item.dart';
import 'operation.dart';
import 'operation_result.dart';

class Monkey {
  final List<Item> _heldItems;
  final int _testDivisibleBy;
  final Operation _operation;
  final int _trueThrowItemTarget;
  final int _falseThrowItemTarget;
  final int _name;
  int _timesItemsInspected = 0;

  Monkey(
    this._heldItems,
    this._testDivisibleBy,
    this._operation,
    this._trueThrowItemTarget,
    this._falseThrowItemTarget,
    this._name,
  );

  void addItem(Item item) {
    _heldItems.add(item);
  }

  List<OperationResult> perform(int superMod) {
    List<OperationResult> thrownItems = [];
    _heldItems.forEach((element) {
      var operationResult = _operation.perform(element);
      //Commented out for second round
      operationResult = operationResult.mod(superMod);
      _timesItemsInspected++;
      int targetMonkey;
      if (test(operationResult)) {
        targetMonkey = _trueThrowItemTarget;
      } else {
        targetMonkey = _falseThrowItemTarget;
      }
      thrownItems.add(OperationResult(targetMonkey, operationResult));
    });
    _heldItems.clear();
    return thrownItems;
  }

  bool test(Item item) => item.divisableBy(_testDivisibleBy);

  int get timesItemsInspected => _timesItemsInspected;

  int get name => _name;

  List<Item> get heldItems => _heldItems;

  int get testDivisibleBy => _testDivisibleBy;
}
