import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:todoku/core/database/tables/tasks_table.dart';
import 'package:todoku/core/utils/secure_storage_helper.dart';
import 'package:todoku/core/enums/task_category_enum.dart';
import 'package:todoku/core/enums/task_priority_enum.dart';

part 'secure_database.g.dart';

@DriftDatabase(tables: [TasksTable])
class SecureDatabase extends _$SecureDatabase {
  static const String _dbKeyName = "SQLCIPHER_PASSPHRASE";

  SecureDatabase({required SecureStorageHelper storageHelper})
    : super(_openConnection(storageHelper));

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection(SecureStorageHelper storageHelper) {
    return LazyDatabase(() async {
      String? passphrase = await storageHelper.read(_dbKeyName);

      if (passphrase == null) {
        final secureRandom = Random.secure();
        final values = List<int>.generate(32, (i) => secureRandom.nextInt(256));

        passphrase = values
            .map((b) => b.toRadixString(16).padLeft(2, '0'))
            .join();

        await storageHelper.write(_dbKeyName, passphrase);
      }

      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(path.join(dbFolder.path, 'todoku_encrypted.db'));

      return NativeDatabase.createInBackground(
        file,
        setup: (rawDb) {
          rawDb.execute("PRAGMA key = '$passphrase';");
          rawDb.execute("PRAGMA cipher = 'sqlcipher';");
          rawDb.execute("PRAGMA legacy = 4;");
        },
      );
    });
  }
}

class ListStringConverter extends TypeConverter<List<String>, String> {
  const ListStringConverter();

  @override
  List<String> fromSql(String fromDb) {
    if (fromDb.isEmpty || fromDb == 'null') return const [];
    try {
      return List<String>.from(json.decode(fromDb) as List);
    } catch (_) {
      return const [];
    }
  }

  @override
  String toSql(List<String> value) => json.encode(value);
}
