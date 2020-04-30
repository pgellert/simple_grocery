import 'package:flutter/material.dart';

import 'package:simple_grocery/data/api.dart';
import 'package:simple_grocery/widgets/grocery_item_form.dart';

class AddGroceryItemPage extends StatelessWidget {
  final String title = 'Add Grocery Item';


  Future<void> addGroceryItem(String name, int amount, String msg) async {
    await Api().addGroceryItem(name, amount.toString(), msg);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: GroceryItemForm(onAdd: addGroceryItem),
          )),
    );
  }
}
