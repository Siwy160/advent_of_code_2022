import 'item.dart';

class OperationResult {
  final int _targetMonkey;
  final Item _item;

  OperationResult(this._targetMonkey, this._item);

  Item get item => _item;

  int get targetMonkey => _targetMonkey;
}
