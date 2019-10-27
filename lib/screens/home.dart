import 'package:contacts_app/screens/contacts.dart';
import 'package:flutter/cupertino.dart';

import 'favourites.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(items: [
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.collections_solid),
          title: Text('All'),
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.heart_solid),
          title: Text('Favorits'),
        ),
      ]),
      tabBuilder: (context, index) {
        if (index == 0) {
          return Contacts();
        } else {
          return Favourites();
        }
      },
    );
  }
}
