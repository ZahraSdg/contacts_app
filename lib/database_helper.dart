import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sql.dart';
import 'package:sqflite/sqlite_api.dart';

import 'model/contact.dart';

class DatabaseHelper {
  static final _databaseName = "contacts_daabase.db";
  static final _databaseVersion = 1;

  static final contactsTable = 'contacts';
  static final favouritesTable = 'favourites';

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _databaseName);

    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database database, int version) async {
    await database.execute(
        'CREATE TABLE $contactsTable (id TEXT PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, gender TEXT, date_of_birth TEXT, phone_no TEXT)');
    await database.execute(
        'CREATE TABLE $favouritesTable (id TEXT PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, gender TEXT, date_of_birth TEXT, phone_no TEXT)');
  }

  insertContact(Contact contact) async {
    final Database db = await instance.database;

    return await db.insert(contactsTable, contact.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  loadContacts() async {
    final Database db = await instance.database;
    var result = await db.query(contactsTable);

    return result.isNotEmpty
        ? result.map((contact) => Contact.fromJson(contact)).toList()
        : [];
  }

  insertFavorite(Contact contact) async {
    final Database db = await instance.database;

    return await db.insert(favouritesTable, contact.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  loadFavourites() async {
    final Database db = await instance.database;
    var result = await db.query(favouritesTable);

    return result.isNotEmpty
        ? result.map((contact) => Contact.fromJson(contact)).toList()
        : [];
  }

  close() async{
    final Database db = await instance.database;
    db.close();
  }
}
