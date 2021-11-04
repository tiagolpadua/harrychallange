import 'package:harrychallange/database/character_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'harry.db');
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(CharacterDAO.tableSql);
    },
    version: 1,
  );
}
