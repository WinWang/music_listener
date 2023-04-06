import 'package:music/business/page/netease_page/model/bean.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const tableVersion = 1;
const tableName = "my_record.db";

const idType = 'TEXT PRIMARY KEY';
const textType = 'TEXT NOT NULL';
const boolType = 'BOOLEAN NOT NULL';
const integerType = 'INTEGER NOT NULL';

const String tableRecord = 'record';
const String id = 'id';
const String picUrl = 'picUrl';
const String albumName = 'al_name';
const String name = 'name';
const String audioUrl = "audioUrl";
const String time = 'time';

const List<String> values = [id, picUrl, albumName, name, audioUrl, time];

class RecordDatabase {
  static final RecordDatabase instance = RecordDatabase._init();

  static Database? _database;

  RecordDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB(tableName);
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: tableVersion, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
CREATE TABLE $tableRecord ( 
  $id $idType, 
  $picUrl $textType,
  $name $textType,
  $albumName $textType,
  $audioUrl $textType,
  $time $textType
  )
''');
  }

  Future<void> create(MyRecord record) async {
    final db = await instance.database;
    final id = await db.insert(tableRecord, record.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<MyRecord> readRecord(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableRecord,
      columns: values,
      where: '$id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return MyRecord.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<MyRecord>> readAllRecord() async {
    final db = await instance.database;
    const orderBy = '$time ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');
    final result = await db.query(tableRecord, orderBy: orderBy);
    return result.map((json) => MyRecord.fromJson(json)).toList();
  }

  Future<int> update(MyRecord note) async {
    final db = await instance.database;

    return db.update(
      tableRecord,
      note.toJson(),
      where: '$id = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableRecord,
      where: '$id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
