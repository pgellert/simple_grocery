import 'package:flutter/material.dart';

import 'package:simple_grocery/data/api.dart';
import 'package:simple_grocery/models/grocery_item.dart';
import 'package:simple_grocery/pages/add_grocery_item_page.dart';
import 'package:simple_grocery/widgets/main_drawer.dart';

class GroceryListPage extends StatefulWidget {
  GroceryListPage({Key key}) : super(key: key);

  final String title = 'Grocery List';

  @override
  _GroceryListPageState createState() => _GroceryListPageState();
}

class _GroceryListPageState extends State<GroceryListPage> {
  final _groceryList = <GroceryItem>[];

  Future<void> _loadList() async {
    final list = await Api().getGroceryList();
    setState(() {
      _groceryList.clear();
      list.forEach((item) => _groceryList.add(item));
    });
  }

  void _addGroceryItem() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddGroceryItemPage()));
  }

  Future<void> _removeGroceryItem(int index) async {
    await Api().deleteGroceryItem(_groceryList[index].pk.toString());
    setState(() {
      _groceryList.removeAt(index);
    });
  }

  void initState() {
    super.initState();

    if (_groceryList.isEmpty) {
      _loadList();
    }
  }

  Widget _buildGroceryItems() {
    if (_groceryList.isEmpty) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        final item = _groceryList[index];

        return Dismissible(
          key: Key(item.name),
          background: Container(color: Colors.red),
          onDismissed: (direction) {
            _removeGroceryItem(index);

            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text("${item.name} deleted")));
          },
          child: ListTile(
            leading: Text('${item.amount}'),
            title: Text('${item.name}'),
            subtitle: Text('${item.msg}'),
          ),
        );
      },
      itemCount: _groceryList.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    final body = Padding(
      padding: EdgeInsets.only(
        left: 8.0,
        right: 8.0,
        bottom: 48.0,
      ),
      child: _buildGroceryItems(),
    );

    return Scaffold(
      appBar: AppBar(
        elevation: Theme.of(context).appBarTheme.elevation,
        title: Text(widget.title),
      ),
      drawer: MainDrawer(),
      body: body,
      floatingActionButton: FloatingActionButton(
        onPressed: _addGroceryItem,
        tooltip: 'Add',
        child: Icon(Icons.add),
      ),
    );
  }
}
