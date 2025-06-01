import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService extends GetxService {
  static DatabaseService get to => Get.find();

  late Database _database;

  Future<DatabaseService> init() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'notes.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE notes (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            content TEXT NOT NULL,
            createdAt TEXT NOT NULL,
            updatedAt TEXT NOT NULL
          )
        ''');
      },
    );

    return this;
  }

  Database get database => _database;
}
