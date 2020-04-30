// Import the test package and Counter class
import 'package:simple_grocery/models/grocery_item.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GroceryItem', () {
    test('GroceryItem should have the given fields', () {
      final item =
          GroceryItem(pk: 2, name: 'apple', amount: 3, msg: 'needed for pie');

      expect(item.pk, 2);
      expect(item.name, 'apple');
      expect(item.amount, 3);
      expect(item.msg, 'needed for pie');
    });

    test('GroceryItem from JSON should have the given fields', () {
      final jsonMap = {
        'pk': 2,
        'name': 'apple',
        'amount': 3,
        'msg': 'needed for pie',
      };
      final item = GroceryItem.fromJson(jsonMap);

      expect(item.pk, 2);
      expect(item.name, 'apple');
      expect(item.amount, 3);
      expect(item.msg, 'needed for pie');
    });
  });
}
