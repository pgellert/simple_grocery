// Create a MockClient using the Mock class provided by the Mockito package.
// Create new instances of this class in each test.
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:simple_grocery/data/api.dart';
import 'package:simple_grocery/models/grocery_item.dart';

class MockClient extends Mock implements http.Client {}

main() {
  final String _url = 'simple-grocery-api.herokuapp.com';
  final String _basePath = 'api/v1';

  final GroceryItem _mockItem =
      GroceryItem(pk: 2, name: 'apple', amount: 3, msg: 'needed for pie');

  var _client;
  var _api;

  setUpAll(() {
    _client = MockClient();
    _api = Api(client: _client);
  });

  tearDownAll(() {
    if (_client != null) {
      _client.close();
      _client = null;
    }

    _api = null;
  });

  group('getGroceryList', () {
    test(
        'returns a list of GroceryItem\'s if the http call completes successfully',
        () async {
      final uri = Uri.http(_url, _basePath + '/groceries/');

      when(_client.get(uri)).thenAnswer((_) async => http.Response(
          '[{"pk": 2, "name": "apple", "amount": 2, "msg": "needed for pie"}, {"pk": 3, "name": "orange", "amount": 5, "msg": ""}]',
          200));

      expect(await _api.getGroceryList(), isInstanceOf<List<GroceryItem>>());
      expect(await _api.getGroceryList(), hasLength(2));
    });
  });

  group('addGroceryItem', () {
    test('returns new item if the http call completes successfully', () async {
      final uri = Uri.http(_url, _basePath + '/groceries/');
      final data = {
        "name": _mockItem.name,
        "amount": _mockItem.amount,
        "msg": _mockItem.msg
      };


      when(_client.post(
        uri,
        headers: captureAnyNamed("headers"),
        body: json.encode(data),
        encoding: captureAnyNamed("encoding"),
      )).thenAnswer((_) async => http.Response(
          '{"pk": 2, "name": "apple", "amount": 2, "msg": "needed for pie"}',
          201));


      expect(
          await _api.addGroceryItem(
            _mockItem.name,
            _mockItem.amount.toString(),
            _mockItem.msg,
          ),
          _mockItem);

      expect(verify(_client).captured.single, uri);
    });
  });
}
