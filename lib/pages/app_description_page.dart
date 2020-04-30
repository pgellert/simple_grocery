import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:simple_grocery/widgets/main_drawer.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

class AppDescriptionPage extends StatelessWidget {
  final String title = 'App Description';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(title),
      ),
      drawer: MainDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.headline,
              children: [
                TextSpan(
                  text:
                      'This app is a simple grocery list application. I created this app solely for learning purposes, the app does not try to be useful or functional.\n',
                ),
                TextSpan(
                  text: 'More information at: ',
                ),
                TextSpan(
                  text: 'simple-grocery-api.herokuapp.com\n',
                  style: TextStyle(color: Colors.blue),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      launcher
                          .launch('http://simple-grocery-api.herokuapp.com');
                    },
                ),
                TextSpan(
                  text: 'Credits:\n',
                ),
                TextSpan(
                  text: 'Icon made by ',
                ),
                TextSpan(
                  text: 'Smashicons',
                  style: TextStyle(color: Colors.blue),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      launcher.launch('https://smashicons.com');
                    },
                ),
                TextSpan(
                  text: ' from ',
                ),
                TextSpan(
                  text: 'www.flaticon.com',
                  style: TextStyle(color: Colors.blue),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      launcher.launch('https://www.flaticon.com');
                    },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
