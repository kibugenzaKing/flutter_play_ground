// ignore_for_file: avoid_dynamic_calls

import 'package:flutter_play_ground/sql/dart_global.dart';

class DBOperations {
  /// table name and columns titles names,
  /// example:
  /// ```dart
  /// String createTable = DBOperations.createTable(
  ///   'table_name',
  ///   <String, DataType>{
  ///     'name': DataType.text,
  ///     'age': DataType.integer,
  ///   },
  /// );
  /// db.execute(createTable);
  /// ```
  static void createTable({
    required dynamic execute,
    required String tableName,
    required Map<String, DataType> columns,
  }) {
    String columnsData = '';

    final Iterable<String> columnsKeys = columns.keys;
    final Iterable<DataType> dataType = columns.values;

    for (int i = 0; i < columnsKeys.length; i++) {
      if (i == 0) {
        columnsData +=
            '${columnsKeys.elementAt(i)} ${_data_type(dataType.elementAt(i))}';
      } else {
        columnsData += ',';
        columnsData += '\n';
        columnsData += '  ${columnsKeys.elementAt(i)} '
            '${_data_type(dataType.elementAt(i))}';
      }
    }
    execute('''
CREATE TABLE IF NOT EXISTS $tableName (
  $columnsData
);
''');
  }

  /// add more columns to a table, each column gets the value of the dataType respectively
  static void addColumnsToExistingTable({
    required dynamic execute,
    required String tableName,
    required Map<String, DataType> columns,
  }) {
    // ALTER TABLE users ADD COLUMN age INTEGER
    final Iterable<String> columnsKeys = columns.keys;
    final Iterable<DataType> dataType = columns.values;
    for (int i = 0; i < columnsKeys.length; i++) {
      execute(
        'ALTER TABLE $tableName ADD COLUMN ${columnsKeys.elementAt(i)} ${_data_type(dataType.elementAt(i))}',
      );
    }
  }

  /// execute is db.execute
  /// tableName is the name of the database,
  /// example:
  /// ```dart
  /// DBOperations.insertData(
  ///   execute: db.execute,
  ///   tableName: 'table_name',
  ///   data: <String, List<Object>>{
  ///     'name': <String>['Alice', 'John', 'paul'],
  ///     'age': <int>[25, 17, 35],
  /// // these lists should be equal to each other
  ///   },
  /// );
  /// ```
  static Future<void> insertData({
    required dynamic execute,
    required String tableName,
    required Map<String, List<dynamic>> data,
  }) async {
    try {
      String keys = '';
      List<String> values = <String>[];
      for (int i = 0; i < data.length; i++) {
        if (i == 0) {
          keys += data.keys.elementAt(i);
        } else {
          keys += ', ${data.keys.elementAt(i)}';
        }
        final List<String> element = data.values
            .elementAt(i)
            .map((dynamic val) => _value_type(val))
            .toList();
        if (i == 0) {
          values.addAll(element);
        } else {
          for (int i = 0; i < values.length; i++) {
            final String previous = values[i];
            values[i] = '$previous, ${element[i]}';
          }
        }
      }
      for (int i = 0; i < values.length; i++) {
        values[i] = '(${values[i]})';
      }
      keys = '($keys)';
      keys.appLog();
      values.appLog(color: red);
      if (values.length == 1) {
        execute('INSERT INTO $tableName $keys VALUES ${values.first};');
      } else {
        execute('BEGIN;');
        for (int i = 0; i < values.length; i++) {
          execute('INSERT INTO $tableName $keys VALUES ${values[i]};');
          await loadingIndicator(length: values.length, i: i);
        }
        execute('COMMIT;');
      }
      return;
    } catch (_) {
      execute('ROLLBACK;');
      _.appLog();
    }
  }

  /// this is select method, it returns Map<String, List<dynamic>>? or int?
  /// unique can be age > 25 or name = 'Alice' or on order by can be
  /// column name like "age"
  /// limit is the number of documents to return
  static dynamic selectData({
    required dynamic select_func,
    required String tableName,
    required List<String> columnsNames,
    required SelectData select,
    int? limit,
    String? unique,
  }) {
    try {
      Map<String, List<dynamic>> data = <String, List<dynamic>>{};

      final dynamic result;

      switch (select) {
        // retrieve all data
        case SelectData.selectAll:
          result = select_func(
            'SELECT * FROM $tableName'
            '${limit != null ? ' LIMIT $limit' : ''};',
          );
          break;
        // order on a unique condition
        case SelectData.condition:
          if (unique == null) throw ('please provide the condition');
          result = select_func('SELECT * FROM $tableName WHERE $unique'
              '${limit != null ? ' LIMIT $limit' : ''};');
          break;
        // order by the biggest
        case SelectData.orderResultByTheBiggest:
          if (unique == null) throw ('please provide name of the column');
          result = select_func('SELECT * FROM $tableName ORDER BY $unique DESC'
              '${limit != null ? ' LIMIT $limit' : ''};');
        // order by the smallest
        case SelectData.orderResultByTheSmallest:
          if (unique == null) throw ('please provide name of the column');
          result = select_func('SELECT * FROM $tableName ORDER BY $unique ASC'
              '${limit != null ? ' LIMIT $limit' : ''};');
        case SelectData.countResult:
          result = select_func('SELECT COUNT(*) AS count FROM $tableName;');
          // return number of items inside the sql,
          return result.first['count'];
      }

      for (final dynamic row in result) {
        /// nested for loop to add the key to map,
        /// so that I will be able to create the pattern
        /// key: [All values]
        for (final String element in columnsNames) {
          if (!data.containsKey(element)) {
            data.addAll(
              <String, List<dynamic>>{
                element: <dynamic>[],
              },
            );
          }
          final List<dynamic>? keysData = data[element];
          if (keysData == null) throw ('this is an error, review this!!');
          keysData.add(row[element]);
          data[element] = keysData;
        }
      }
      return data;
    } catch (_) {
      _.appLog();
    }
    return null;
  }

  /// ex:  db.execute("UPDATE users SET age = 26 WHERE name = 'Alice';");
  ///
  /// ```dart
  /// DBOperations.updateData(
  ///   execute: db.execute,
  ///   tableName: tableName,
  ///   update: ['age = 26'],
  ///   condition: 'name = ["'Alice'"]',
  /// );
  /// ```
  static void updateData({
    required dynamic execute,
    required String tableName,
    required List<String> updates,
    required List<String> conditions,
  }) {
    if (tableName.isEmpty) return;

    try {
      execute('BEGIN;');

      for (int i = 0; i < updates.length; i++) {
        execute(
          'UPDATE $tableName SET ${updates.elementAt(i)} WHERE ${conditions.elementAt(i)};',
        );
        loadingIndicator(length: updates.length, i: i);
      }

      execute('COMMIT;');

      // execute('UPDATE $tableName SET $update WHERE $condition;');
    } catch (_) {
      _.appLog();
    }
  }

  /// delete data, where condition is met
  /// ```dart
  /// DBOperations.deleteData(
  ///   execute: db.execute,
  ///   tableName: tableName,
  ///   condition: 'name = "Bosco"',
  /// );
  /// // delete on null works like
  /// DELETE FROM user WHERE name IS NULL;
  /// ```
  static void deleteData({
    required dynamic execute,
    required String tableName,
    required String unique,
    bool deleteOnNull = false,
  }) {
    try {
      if (deleteOnNull) {
        execute('DELETE FROM $tableName WHERE $unique IS NULL;');
      } else {
        execute('DELETE FROM $tableName WHERE $unique;');
      }
    } catch (_) {
      _.appLog();
    }
  }

  static void dropTable({
    required dynamic execute,
    required String tableName,
  }) {
    try {
      execute('DROP TABLE IF EXISTS $tableName;');
    } catch (_) {
      _.appLog();
    }
  }
}

/// this helps in creating table data types
/// the data that which Sql uses, mainly text, int, null
enum DataType {
  text,
  integer,
  nul,
}

enum SelectData {
  selectAll,
  condition,
  orderResultByTheBiggest,
  orderResultByTheSmallest,
  countResult,
}

String _data_type(DataType data) {
  switch (data) {
    case DataType.text:
      return 'TEXT';
    case DataType.integer:
      return 'INTEGER';
    case DataType.nul:
      return 'NULL';
    default:
      return 'NULL';
  }
}

String _value_type(dynamic value) {
  if (value.runtimeType == String) {
    return '"$value"';
  }
  if (value.runtimeType == int) {
    return value.toString();
  }
  return 'NULL';
}
