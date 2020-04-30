import 'package:meta/meta.dart';

/// Information about a [GroceryItem].
class GroceryItem {
  final int pk;
  final String name;
  final int amount;
  final String msg;

  /// A [GroceryItem] stores its primary key, name, amount and message.
  ///
  /// An example would be '3', 'Apple', '5' and 'needed for pie'.
  const GroceryItem({
    @required this.pk,
    @required this.name,
    @required this.amount,
    @required this.msg,
  })  : assert(pk != null),
        assert(name != null),
        assert(amount != null && amount != 0),
        assert(msg != null);

  /// Creates a [GroceryItem] from a JSON object.
  GroceryItem.fromJson(Map jsonMap)
      : assert(jsonMap['pk'] != null),
        assert(jsonMap['name'] != null),
        assert(jsonMap['amount'] != null),
        assert(jsonMap['msg'] != null),
        pk = jsonMap['pk'].toInt(),
        name = jsonMap['name'],
        amount = jsonMap['amount'].toInt(),
        msg = jsonMap['msg'];
}
