import 'package:contacts_app/model/contact.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../API.dart';
import '../contact_item.dart';
import '../database_helper.dart';

const rowCount = 10;
const initRowCount = 20;

class ContactsState extends State<Contacts> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  ScrollController _scrollController = new ScrollController();
  List _contacts = new List();
  var _page = 1;
  bool _isLoading = false;

  final _dbHelper = DatabaseHelper.instance;

  void fetchContacts() {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });

      API.fetchContacts(++_page, rowCount).catchError((e) {
        showToast(context, "Something happend: ${e.error}");
      }).then((response) {
        response.contacts.forEach((item) => _insertContact(item));

        this.setState(() {
          _isLoading = false;
          _contacts.addAll(response.contacts);
        });
      });
    }
  }

  void _initContacts() {
    _dbHelper.loadContacts().then((contacts) {
      this.setState(() {
        _contacts = contacts;
      });
    });
  }

  void _insertContact(Contact contact) async {
    await _dbHelper.insertContact(contact);
  }

  Future<void> _refresh() {
    return API.fetchContacts(1, initRowCount).catchError((e) {
      showToast(context, "Something happend: ${e.error}");
    }).then((response) {
      response.contacts.forEach((item) => _insertContact(item));

      this.setState(() {
        _isLoading = false;
        _contacts = response.contacts;
      });
    });
  }

  @override
  void initState() {
    this._initContacts();
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        fetchContacts();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
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

  Widget _buildContacts() {
    return RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: ListView.separated(
            itemCount: _contacts.length + 1,
            separatorBuilder: (BuildContext context, int index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Divider(),
                ),
            itemBuilder: (context, i) {
              if (i == _contacts.length) return _buildProgressIndicator();

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
                        _contacts.remove(_contacts[i]);
                      });
                    },
                  ),
                ],
                child: ContactWidget(
                  contact: _contacts[i],
                  onFavoritePressed: (contact) {
                    setState(() {
                      _dbHelper.insertFavorite(contact);
                      _contacts.remove(contact);
                      showToast(context, "Added to favourites");
                    });
                  },
                ),
              );
            },
            controller: _scrollController));
  }

  @override
  Widget build(BuildContext context) {
    return _buildContacts();
  }
}

class Contacts extends StatefulWidget {
  @override
  ContactsState createState() => ContactsState();
}

showToast(BuildContext context, String message) {
  Scaffold.of(context).showSnackBar(new SnackBar(
    content: new Text(message),
  ));
}
