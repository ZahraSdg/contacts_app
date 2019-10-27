import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../database_helper.dart';
import '../favourite_item.dart';

class FavouritesState extends State<Favourites> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  List _favourites = new List();
  bool _isLoading = false;

  final _dbHelper = DatabaseHelper.instance;

  Future<void> _loadFavourites() {
    return _dbHelper.loadFavourites().then((contacts) {
      this.setState(() {
        _isLoading = false;
        _favourites = contacts;
      });
    });
  }

  @override
  void initState() {
    this._loadFavourites();
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
  }

  @override
  void dispose() {
    _dbHelper.close();
    super.dispose();
  }



  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: _isLoading ? 1.0 : 00,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget _buildFavourites() {
    return RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _loadFavourites,
        child: ListView.separated(
            itemCount: _favourites.length + 1,
            separatorBuilder: (BuildContext context, int index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Divider(),
                ),
            itemBuilder: (context, i) {
              if (i == _favourites.length) return _buildProgressIndicator();

              return Slidable(
                actionPane: SlidableDrawerActionPane(),
                secondaryActions: <Widget>[
                  IconSlideAction(
                    caption: 'Edit',
                    icon: Icons.edit,
                    color: Colors.blueGrey,
                  ),
                  IconSlideAction(
                    caption: 'Delete',
                    icon: Icons.delete,
                    color: Colors.blueGrey,
                    onTap: () {
                      setState(() {
                        _favourites.remove(_favourites[i]);
                      });
                    },
                  ),
                ],
                child: FavouriteWidget(contact: _favourites[i]),
              );
            }));
  }

  @override
  Widget build(BuildContext context) {
    return _buildFavourites();
  }
}

class Favourites extends StatefulWidget {
  @override
  FavouritesState createState() => FavouritesState();
}
