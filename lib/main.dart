import 'package:flutter/material.dart';

import 'package:simple_grocery/pages/grocery_list_page.dart';
import 'package:simple_grocery/utils/utils.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grocery List',
      debugShowCheckedModeBanner: false,
      theme: Theme.of(context).copyWith(
        //primaryColor: platformIsIOS(context) ? Colors.grey[300] : Colors.blue,
        //accentColor: platformIsIOS(context) ? Colors.blue : Colors.amberAccent,
        //backgroundColor: platformIsIOS(context) ? Colors.white : Colors.grey[300],
        primaryColor: Colors.blue,
        accentColor: Colors.amberAccent,
        iconTheme: IconThemeData(
          color: platformIsIOS(context) ? Colors.grey : Colors.white,
        ),
        appBarTheme: AppBarTheme(
          textTheme: TextTheme(
            title: TextStyle(color: Colors.black),
          ),
          elevation: platformIsIOS(context) ? 0.0 : 1.0,
          iconTheme: IconThemeData(
            color: platformIsIOS(context) ? Colors.grey : Colors.white,
          ),
          brightness: platformIsIOS(context) ? Brightness.light : Brightness.dark,
        ),
      ),
      home: GroceryListPage(),
    );
  }
}
