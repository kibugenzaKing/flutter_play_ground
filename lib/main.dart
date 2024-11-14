import 'dart:convert';

import 'package:flutter_play_ground/sql/dart_global.dart';
import 'package:flutter_play_ground/working_with_sql.dart';
import 'package:sqlite3/sqlite3.dart';

void main() async {
  // int fell = 0;
  // String feller = '';
  // try {
  //   // final String filecsv = await readStringFromFile(
  //   //   '/home/yking/Documents/Presentation/bible_csv/bible_books.csv',
  //   // );
  //   final String bibleFile = await readStringFromFile(
  //     '/home/yking/Documents/Presentation/bible_csv/bible_verses.csv',
  //   );

  //   // final List<String> books_verses = filecsv.split('\n');
  //   // books_verses.removeWhere((String element) => element.trim().isEmpty);
  //   // final Map<String, String> book_name = <String, String>{};
  //   // for (int i = 0; i < books_verses.length; i++) {
  //   //   book_name.addAll(<String, String>{
  //   //     books_verses[i].split(',').first.toString():
  //   //         books_verses[i].split(',').elementAt(2).toString(),
  //   //   });
  //   // }

  //   // attempting to extract chapter number

  //   {
  //     final List<String> bibleVerses = bibleFile.trim().split('\n');
  //     final Map<String, String> fullData = <String, String>{};
  //     bibleVerses.removeWhere((String element) => element.trim().isEmpty);
  //     String previousText = '';
  //     for (int i = 0; i < bibleVerses.length; i++) {
  //       final List<String> inside = bibleVerses[i].split(',');
  //       if (inside[2] == '1') {
  //         if (fullData.containsKey(inside[0])) {
  //           feller = '1. ${inside.last}';
  //           String updater = fullData[inside[0]]!;
  //           updater += ',${previousText.split(':').last}';
  //           fullData[inside[0]] = updater;
  //         } else {
  //           if (previousText.trim().isNotEmpty &&
  //               previousText.split(',').first != inside[0]) {
  //             fell++;
  //             feller = '2. ${inside.last}';
  //             String order = previousText.trim().split(',').first;
  //             String updater = fullData[order]!;
  //             updater += ',${previousText.split(':').last}';
  //             fullData[order] = updater;
  //           } else {
  //             String updater = previousText.split(':').last;
  //             fullData[inside[0]] = updater;
  //           }
  //         }
  //       }
  //       previousText = '${inside[0]}, ${inside[1]}:${inside[2]}';
  //       await loadingIndicator(
  //         length: bibleVerses.length,
  //         i: i,
  //         doneExecuting: 'done first loop',
  //       );
  //     }

  //     ('\n\n\n${fullData.length}\n\n\n').appLog();

  //     for (int i = 1; i <= 66; i++) {
  //       fullData[i.toString()].appLog(color: i.isEven ? noColor : purple);
  //     }

  //     // final Database db = sqlite3
  //     //     .open('/home/yking/Documents/Presentation/bible_csv/my_bible.sqlite');
  //     // db.dispose();
  //   }

  //   // final Database db = sqlite3
  //   //     .open('/home/yking/Documents/Presentation/bible_csv/my_bible.sqlite');
  //   'done'.appLog(color: noColor);
  // } catch (_) {
  //   _.appLog();
  // }
  // 'fell: $fell \n\n $feller'.appLog(color: purple);
}

// class BibleVerses {
//   static const String tableName = 'bible_verses';

//   static const String bookId = 'book_id';
//   static const String bookName = 'book_name';
//   static const String verseNumber = 'verse_number';
//   static const String verse = 'verse';
//   static const String extraData = 'extra_data';

//   static Map<String, DataType> createTableColumns = <String, DataType>{
//     bookId: DataType.integer,
//     bookName: DataType.text,
//     verseNumber: DataType.text,
//     verse: DataType.text,
//     extraData: DataType.text,
//   };

//   static Map<String, List<dynamic>> insertData({
//     required List<int> bookIdList,
//     required List<String> bookNameList,
//     required List<int> verseNumberList,
//     required List<String> verseList,
//   }) =>
//       <String, List<dynamic>>{
//         bookId: bookIdList,
//         bookName: bookNameList,
//         verseNumber: verseNumberList,
//         verse: verseList,
//       };
// }

/// format of verses number will be like
/// ```dart
/// {
/// 1:50
/// 2:30,
/// }
/// ```
class BibleModel {
  static const String tableName = 'bible_books';

  static const String bookName = 'book_name';
  static const String bookId = 'book_id';
  static const String chaptersNumber = 'chapters_number';
  static const String versesNumber = 'verses_number';
  static const String extraData = 'extra_data';

  static Map<String, DataType> createTableColumns = <String, DataType>{
    bookId: DataType.integer,
    bookName: DataType.text,
    chaptersNumber: DataType.integer,
    versesNumber: DataType.integer,
    extraData: DataType.text,
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
