import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

const userTable = 'userTable';
const orderItems = 'orderItems';
const userExperiences = ' userExperiences';

class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();

  Database? _database;

  Future<Database?> get database async {
    // ignore: unnecessary_null_comparison
    if (_database != null) {
      print(_database!.path);
      return _database;
    }
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "User5.db");

    var database = await openDatabase(
      path,
      version: 1,
      onCreate: initDB,
      onUpgrade: onUpgrade,
    );
    return database;
  }

  deleteDabase() async {
    await deleteDabase();
  }

  void onUpgrade(
    Database database,
    int oldVersion,
    int newVersion,
  ) {
    if (newVersion > oldVersion) {}
  }

  // static const tableUser = """ CREATE TABLE IF NOT EXISTS userTable (
  //   id INTEGER PRIMARY KEY,
  //   key TEXT,
  //   altid INTEGER,
  //   hasProfile INTEGER
  // );""";

  void initDB(Database database, int version) async {
    await database.execute("CREATE TABLE IF NOT EXISTS $userTable ("
        "id INTEGER PRIMARY KEY, "
        "email TEXT, "
        "key TEXT, "
        "altid INTEGER, "
        "hasProfile INTEGER "
        ")");

    await database.execute("CREATE TABLE IF NOT EXISTS $orderItems ("
        "id INTEGER PRIMARY KEY, "
        "shirt TEXT, "
        "shirtId INTEGER, "
        "color TEXT, "
        "price TEXT, "
        "quantity INTEGER, "
        "size TEXT, "
        "points_needed_to_purchase INTEGER,"
        "size_id INTEGER "
        ")");

    await database.execute("CREATE TABLE IF NOT EXISTS $userExperiences ("
        "id INTEGER PRIMARY KEY, "
        "doneIntro INTEGER, "
        "doneNP INTEGER, "
        "doneCompany INTEGER "
        ")");
  }
}
