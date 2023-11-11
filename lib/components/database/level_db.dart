import 'package:journey_of_salvation/components/database/database_service.dart';
import 'package:sqflite/sqflite.dart';

class LevelDB {
  final tableName = 'levels';

  //funtion create table
  Future<void> create(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $tableName (
        id $idType,
        levelName $textType
      )
    ''');
  }

//function insert
  Future<int> insert(Map<String, dynamic> data) async {
    final database = await DatabaseService().database;
    return await database.insert(tableName, data);
  }

  //fetch all
  Future<List<Map<String, dynamic>>> fetchAll() async {
    final database = await DatabaseService().database;
    return await database.query(tableName);
  }

  //fetch by id
  Future<List<Map<String, dynamic>>> fetchById(int id) async {
    final database = await DatabaseService().database;
    return await database.query(tableName, where: 'id = ?', whereArgs: [id]);
  }

  //fetch by levelName
  Future<List<Map<String, dynamic>>> fetchByLevelName(String levelName) async {
    final database = await DatabaseService().database;
    return await database.query(tableName, where: 'levelName = ?', whereArgs: [levelName]);
  }

  //update
  Future<int> update(Map<String, dynamic> data) async {
    final database = await DatabaseService().database;
    return await database.update(tableName, data, where: 'id = ?', whereArgs: [data['id']]);
  }

}
