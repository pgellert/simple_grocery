import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_grocery/pages/app_description_page.dart';
import 'package:simple_grocery/pages/grocery_list_page.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Center(
              child: Text('Grocery List App'),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          ListTile(
            title: Text('Grocery List'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => GroceryListPage()));
            },
          ),
          ListTile(
            title: Text('App Description'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AppDescriptionPage()));
            },
          ),
        ],
      ),
    );
  }
}
