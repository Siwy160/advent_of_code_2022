class Item {
  BigInt _value;

  Item.fromString(String value) : _value = BigInt.parse(value);

  Item(this._value);

  operator *(Item other) => Item(_value * other._value);

  operator +(Item other) => Item(_value + other._value);

  Item plus(int other) => Item(_value + BigInt.from(other));

  Item times(int other) => Item(_value * BigInt.from(other));

  void subtract(Item other) {
    _value -= other._value;
  }

  Item mod(int i) => Item(_value % BigInt.from(i));

  bool divisableBy(int other) {
//    if (_value < BigInt.parse("100000000000000000000")) {
      return _value % BigInt.from(other) == BigInt.zero;
 //   }
    switch (other) {
      case 2:
        return _value.isEven;
      case 3:
        return sumOfDigits() % 3 == 0;
      case 4:
        {
          var digits = getDigits();
          return digits[digits.length] % 4 == 0 &&
              digits[digits.length - 1] % 4 == 0;
        }
      case 5:
        {
          var lastDigit = getDigits().last;
          return lastDigit == 5 || lastDigit == 0;
        }
      case 11:
        return getDigits().last == 0;
      case 13:
        {
          var digits = getDigits();
          if (digits.length % 3 == 1) {
            digits.add(0);
            digits.add(0);
          }
          if (digits.length % 3 == 2) {
            digits.add(0);
          }
          int sum = 0;
          int p = 1;
          for (int i = digits.length - 1; i >= 0; i--) {
            int group = 0;
            group += digits[i--];
            group += digits[i--] * 10;
            group += digits[i] * 100;

            sum = sum + group * p;
            p *= -1;
          }
          sum = sum.abs();
          return sum % 13 == 0;
        }
      case 17:
        {
          BigInt n = _value;
          var zero = BigInt.zero;
          while (n ~/ BigInt.from(100) > zero) {
            var d = n % BigInt.from(10);
            n = n ~/ BigInt.from(10);
            n = n - d * BigInt.from(5);
          }
          return n % BigInt.from(17) == BigInt.from(0);
        }
      case 19:
        {
          BigInt n = _value;
          while (n ~/ BigInt.from(100) > BigInt.zero) {
            var d = n % BigInt.from(10);
            n = n ~/ BigInt.from(10);
            n = n + d * BigInt.from(2);
          }
          return n % BigInt.from(19) == BigInt.from(0);
        }
      case 23:
        {
          BigInt n = _value;
          while (n ~/ BigInt.from(100) > BigInt.zero) {
            var d = n % BigInt.from(10);
            n = n ~/ BigInt.from(10);
            n = n + d * BigInt.from(7);
          }
          return n % BigInt.from(23) == BigInt.from(0);
        }
      default:
        return _value % BigInt.from(other) == BigInt.zero;
      //throw Exception(other);
    }
  }

  int sumOfDigits() {
    var kurwa = _value.toString();
    var sum = 0;
    for (int i = 0; i < kurwa.length; i++) {
      sum += int.parse(kurwa[i]);
    }
    return sum;
  }

  List<int> getDigits() {
    List<int> result = [];
    var kurwa = _value.toString();
    for (int i = 0; i < kurwa.length; i++) {
      result.add(int.parse(kurwa[i]));
    }
    return result;
  }
}
