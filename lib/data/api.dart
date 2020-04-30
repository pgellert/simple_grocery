import 'dart:async';
import 'dart:convert' show json;
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:simple_grocery/models/grocery_item.dart';

/// Singleton
class Api {
  final String _url = 'simple-grocery-api.herokuapp.com';
  final String _basePath = 'api/v1';
  final http.Client _client;
  http.Client client;

  static Api _apiInstance;

  factory Api({http.Client client}) {
    if(_apiInstance != null) return _apiInstance;

    if(client != null){
      _apiInstance = Api._internal(client);
    } else {
      _apiInstance = Api._internal(http.Client());
    }

    return _apiInstance;
  }

  Api._internal(this._client) : assert (_client != null) {
    client = _client;
  }


  Future<List> getGroceryList() async {
    final uri = Uri.http(_url, _basePath + '/groceries/');
    try {
      final response = await _client.get(uri);
      if (response.statusCode != HttpStatus.ok) {
        return null;
      }

      Iterable l = json.decode(response.body);
      return l.map((model) => GroceryItem.fromJson(model)).toList();
    } on Exception catch (e) {
      print('$e');
      return null;
    }
  }

  Future<GroceryItem> addGroceryItem(
      String name, String amount, String msg) async {
    final uri = Uri.http(_url, _basePath + '/groceries/');
    final data = {"name": name, "amount": amount, "msg": msg};
    try {
      final httpResponse = await _client.post(
        uri,
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: json.encode(data),
      );

      if (httpResponse.statusCode != HttpStatus.created) {
        return null;
      }
      // Finally, the string is parsed into a JSON object.
      final jsonBody = json.decode(httpResponse.body);
      return GroceryItem.fromJson(jsonBody);
    } on Exception catch (e) {
      print('$e');
      return null;
    }
  }

  Future<GroceryItem> getGroceryItem(String pk) async {
    final uri = Uri.http(_url, _basePath + '/groceries/$pk');
    try {
      final response = await _client.get(uri);
      if (response.statusCode != HttpStatus.ok) {
        return null;
      }

      final jsonBody = json.decode(response.body);
      return GroceryItem.fromJson(jsonBody);
    } on Exception catch (e) {
      print('$e');
      return null;
    }
  }

  Future<bool> updateGroceryItem(
      String pk, String name, String amount, String msg) async {
    final uri = Uri.http(_url, _basePath + '/groceries/$pk');
    final data = {"name": name, "amount": amount, "msg": msg};
    try {
      final response = await _client.put(
        uri,
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: json.encode(data),
      );
      if (response.statusCode != HttpStatus.noContent) {
        return false;
      }

      // httpResponse contains data about item

      return true;
    } on Exception catch (e) {
      print('$e');
      return false;
    }
  }

  Future<bool> deleteGroceryItem(String pk) async {
    final uri = Uri.http(_url, _basePath + '/groceries/$pk');
    try {
      final response = await _client.delete(uri);
      if (response.statusCode != HttpStatus.noContent) {
        return false;
      }
      return true;
    } on Exception catch (e) {
      print('$e');
      return false;
    }
  }
}
