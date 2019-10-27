import 'package:flutter/material.dart';

import 'package:contacts_app/screens/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Welcome to Flutter',
        theme: ThemeData(primarySwatch: Colors.red),
        home: MainPage());
  }
}

//region Main Widget
class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  MainState createState() => MainState();
}

class MainState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts"),
      ),
      body: Center(
        child: HomeScreen(),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }
}
//endregion
