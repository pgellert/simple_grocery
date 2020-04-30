// Create a Form Widget
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_grocery/utils/utils.dart';

class GroceryItemForm extends StatefulWidget {
  final onAdd;

  GroceryItemForm({
    @required this.onAdd,
  });

  @override
  State<GroceryItemForm> createState() => _GroceryItemFormState();
}

class _GroceryItemFormState extends State<GroceryItemForm> {
  final _formKey = GlobalKey<FormState>();

  String _name;
  int _amount;
  String _msg;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
            },
            onSaved: (value) {
              _name = value;
            },
            style: Theme.of(context).textTheme.subtitle.copyWith(
                  fontSize: 24,
                ),
            decoration: InputDecoration(
              labelStyle: Theme.of(context).textTheme.caption,
              labelText: 'Name',
            ),
            keyboardType: TextInputType.text,
          ),
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              } else {
                try {
                  final intValue = int.parse(value);
                  if (intValue <= 0) {
                    return 'Please enter a positive integer';
                  }
                } catch (e) {
                  return 'Please enter an integer';
                }
              }
            },
            onSaved: (value) {
              _amount = int.parse(value);
            },
            initialValue: '1',
            style: Theme.of(context).textTheme.subtitle.copyWith(
                  fontSize: 24,
                ),
            decoration: InputDecoration(
              labelStyle: Theme.of(context).textTheme.caption,
              labelText: 'Amount',
            ),
            keyboardType: TextInputType.number,
          ),
          TextFormField(
            onSaved: (value) {
              _msg = value;
            },
            style: Theme.of(context).textTheme.subtitle.copyWith(
                  fontSize: 24,
                ),
            decoration: InputDecoration(
              labelStyle: Theme.of(context).textTheme.caption,
              labelText: 'Message',
            ),
            keyboardType: TextInputType.text,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Builder(
              builder: (BuildContext context) {
                if(platformIsIOS(context)){
                  return CupertinoButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();

                      widget.onAdd(_name, _amount, _msg);
                      Scaffold.of(context)
                          .showSnackBar(SnackBar(content: Text('Item added')));

                      _formKey.currentState.reset();
                    }
                  },
                  child: Text(
                    'Add',
                    style: Theme.of(context).textTheme.button,
                  ),
                );
                } else {
                  return RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();

                      widget.onAdd(_name, _amount, _msg);
                      Scaffold.of(context)
                          .showSnackBar(SnackBar(content: Text('Item added')));

                      _formKey.currentState.reset();
                    }
                  },
                  child: Text(
                    'Add',
                    style: Theme.of(context).textTheme.button,
                  ),
                );
                }

                
              },
            ),
          ),
        ],
      ),
    );
  }
}
