import 'dart:io';

import 'package:flutter_play_ground/sql/dart_global.dart';
import 'package:flutter_play_ground/working_with_sql.dart';
import 'package:sqlite3/sqlite3.dart';

void main() async {
  try {
    final String filecsv = await readStringFromFile(
      '/home/yking/Documents/Presentation/bible_csv/bible_books.csv',
    );
    final List<String> books = filecsv.split('\n');
    books.removeWhere((String element) => element.trim().isEmpty);
    final List<int> bookIdList = <int>[];
    final List<String> bookNameList = <String>[];
    for (int i = 0; i < books.length; i++) {
      final List<String> dt = books[i].split(',');
      bookIdList.add(int.parse(dt[0]));
      bookNameList.add(dt[3]);
    }
    final File file =
        File('/home/yking/Documents/Presentation/bible_csv/my_bible.sqlite');
    final bool path = await file.exists();
    if (path) {
      final Database db = sqlite3.open(file.path);
      const String tableName = BibleBooksModel.tableName;
      // DBOperations.createTable(
      //   execute: db.execute,
      //   tableName: tableName,
      //   columns: BibleBooksModel.createTableColumns,
      // );
      // await DBOperations.insertData(
      //   execute: db.execute,
      //   tableName: tableName,
      //   data: BibleBooksModel.insertData(
      //     bookIdList: bookIdList,
      //     bookNameList: bookNameList,
      //   ),
      // );
      db.dispose();
    } else {
      throw ('file does not exist');
    }
  } catch (_) {
    _.appLog();
  }
}

class BibleBooksModel {
  static const String tableName = 'bible_books';

  static const String bookName = 'book_name';
  static const String bookId = 'book_id';
  static const String chaptersNumber = 'chapters_number';
  static const String versesNumber = 'verses_number';

  static Map<String, DataType> createTableColumns = <String, DataType>{
    bookId: DataType.integer,
    bookName: DataType.text,
    chaptersNumber: DataType.integer,
    versesNumber: DataType.integer,
  };

  /// this has to be equal to the number of items in [createTableColumns]
  static Map<String, List<dynamic>> insertData({
    required List<dynamic> bookIdList,
    required List<dynamic> bookNameList,
  }) =>
      <String, List<dynamic>>{
        bookId: bookIdList,
        bookName: bookNameList,
      };
}

// class BibleBooksModel {
//   static const String tableName = 'bible_books';

//   static const String bookName = 'book_name';
//   static const String bookId = 'book_id';

//   static Map<String, DataType> createTableColumns = <String, DataType>{
//     bookId: DataType.integer,
//     bookName: DataType.text,
//   };

//   /// this has to be equal to the number of items in [createTableColumns]
//   static Map<String, List<dynamic>> insertData({
//     required List<dynamic> bookIdList,
//     required List<dynamic> bookNameList,
//   }) =>
//       <String, List<dynamic>>{
//         bookId: bookIdList,
//         bookName: bookNameList,
//       };
// }




/* // print('Using sqlite3 ${sqlite3.version}');

  // // Create a new in-memory database. To use a database backed by a file, you
  // // can replace this with sqlite3.open(yourFilePath).
  // final Database db = sqlite3
  //     .open('/home/yking/Documents/Presentation/bible_csv/my_bible.sqlite');

  // // Create a table and insert some data
  // db.execute('''
  //   CREATE TABLE artists (
  //     id INTEGER NOT NULL PRIMARY KEY,
  //     name TEXT NOT NULL
  //   );
  // ''');

  // // Prepare a statement to run it multiple times:
  // final PreparedStatement stmt =
  //     db.prepare('INSERT INTO artists (name) VALUES (?)');
  // stmt
  //   ..execute(<Object?>['The Beatles'])
  //   ..execute(<Object?>['Led Zeppelin'])
  //   ..execute(<Object?>['The Who'])
  //   ..execute(<Object?>['Nirvana']);

  // // Dispose a statement when you don't need it anymore to clean up resources.
  // stmt.dispose();

  // // You can run select statements with PreparedStatement.select, or directly
  // // on the database:
  // final ResultSet resultSet =
  //     db.select('SELECT * FROM artists WHERE name LIKE ?', <Object?>['The %']);

  // // You can iterate on the result set in multiple ways to retrieve Row objects
  // // one by one.
  // for (final Row row in resultSet) {
  //   print('Artist[id: ${row['id']}, name: ${row['name']}]');
  // }

  // // Register a custom function we can invoke from sql:
  // db.createFunction(
  //   functionName: 'dart_version',
  //   argumentCount: const AllowedArgumentCount(0),
  //   function: (List<Object?> args) => Platform.version,
  // );
  // print(db.select('SELECT dart_version()'));

  // // Don't forget to dispose the database to avoid memory leaks
  // db.dispose(); */
