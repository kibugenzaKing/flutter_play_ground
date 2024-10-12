import 'dart:io';
import 'package:flutter_play_ground/sql/dart_global.dart';
import 'package:sqlite3/sqlite3.dart';

void main() async {
  await codes();
}

Future<void> codes() async {
  try {
    /*
// remove english from the bible verses
// Open the SQLite database
    final File dbFile =
        File('/home/yking/Documents/Presentation/bible_test.sqlite');
    dbFile.path.appLog(color: red);
    final Database db = sqlite3.open(dbFile.path);
    'ln: 16'.appLog(color: red);
    // Fetch all rows from the "texts" table
    final ResultSet rows =
        db.select('SELECT chapter_id, chapter_num, position, text FROM texts');

    for (final Row row in rows) {
      String originalText = row['text'] ?? '';

      // Split the text at '<br/>' and take the first part (Kinyarwanda)
      String newText = originalText.split('<br/>').first;

      // Update the row with the new text
      db.execute(
        '''
      UPDATE texts
      SET text = ?
      WHERE chapter_id = ? AND chapter_num = ? AND position = ?
    ''',
        <Object?>[
          newText,
          row['chapter_id'],
          row['chapter_num'],
          row['position'],
        ],
      );
    }

    // Dispose the database connection
    db.dispose();
    ('All rows have been updated!').appLog(); */

    // format bible verses
    /* final File dbPath =
        File('/home/yking/Documents/Presentation/bible_test.sqlite');

    // Open the database
    final Database db = sqlite3.open(dbPath.path);

    // Query to fetch books (replace 'your_table_name' with the actual table name)
    final List<Map<String, dynamic>> books = db.select('''
    SELECT
      rowid AS book_id,  -- Assuming rowid can serve as book_id
      CASE
        WHEN title IN ('Itangiriro', 'Kuva', 'Abalewi', 'Kubara', 'Gutegeka kwa kabiri', 'Yosuwa', 'Abacamanza', 'Rusi', '1 Samweli', '2 Samweli', '1 Abami', '2 Abami', '1 Ngoma', '2 Ngoma', 'Ezira', 'Nehemiya', 'Esiteri', 'Yobu', 'Zaburi', 'Imigani', 'Umubwiriza', 'Indirimbo ya Salomo', 'Yesaya', 'Yeremiya', 'Amaganya ya Yeremiya', 'Ezekiyeli', 'Daniyeli', 'Hoseya', 'Yoweli', 'Amosi', 'Obadiya', 'Yona', 'Mika', 'Nahumu', 'Habakuki', 'Zefaniya', 'Hagayi', 'Zekariya', 'Malaki') THEN 1  -- Old Testament books
        ELSE 2  -- New Testament books
      END AS testament_id,
      title AS book_name,
      CASE
        WHEN title = '---' THEN 'HB'
        -- Add more abbreviations as necessary
        ELSE title
      END AS book_abbreviation
    FROM chapters;  -- Replace with your actual table name
  ''');

    // Open a file for writing
    final File csvFile =
        File('/home/yking/Documents/Presentation/bible_books.csv');
    final IOSink csvSink = csvFile.openWrite();

    // Write the header (if needed, remove this line if not necessary)
    // csvSink.writeln('<book_id>,<testament_id>,<book_name>,<book_abbreviation>');

    // Write data to CSV file
    for (final Map<String, dynamic> book in books) {
      final dynamic bookId = book['book_id'];
      final dynamic testamentId = book['testament_id'];
      final dynamic bookName = book['book_name'];
      final dynamic bookAbbreviation = book['book_abbreviation'];

      csvSink.writeln('$bookId,$testamentId,$bookName,$bookAbbreviation');
    }

    // Close the file and the database
    csvSink.close();
    db.dispose();

    print('CSV file has been generated.'); */

    // add book id
    /* final List<String> data = await readStringFromFile(
      '/home/yking/Documents/Presentation/bible_books.csv',
    ).then((String value) => value.split('\n'));

    data.removeWhere((String element) => element.trim().isEmpty);

    final List<String> wellFormatted = <String>[];
    for (final String dt in data) {
      final String out = dt.trim().substring(4);
      wellFormatted.add('${data.indexOf(dt) + 1}$out');
    }
    await writeString(
      data: wellFormatted.join(' '),
      filePath: '/home/yking/Documents/Presentation/bible_books.csv',
    ); */

/*     // code to update only one table in SQL 
    // Paths to your source and target SQLite databases
      final File sourceDbPath = File('/home/yking/Documents/Presentation/bible.sqlite');
      final File targetDbPath = File('/home/yking/Documents/Presentation/bible_test_mod.sqlite');

      // Open the source and target databases
      final Database sourceDb = sqlite3.open(sourceDbPath.path);
      final Database targetDb = sqlite3.open(targetDbPath.path);

      // Query to get the data from the `texts` table in the source database
      final List<Map<String, dynamic>> rows = sourceDb.select('''
      SELECT * FROM texts;
    ''');

      // Insert the data into the `texts` table of the target database
      for (final Map<String, dynamic> row in rows) {
        final dynamic chapterId =
            row['chapter_id']; // Adjust the column name as needed

        // Insert the row into the target database's `texts` table
        targetDb.execute('''
        INSERT INTO texts (chapter_id)  -- Adjust the column names here
        VALUES (?);
      ''', <Object?>[chapterId],);
      }

      // Dispose of the database connections
      sourceDb.dispose();
      targetDb.dispose();

      print('Data has been copied to the target database.');
 */

    /* // Path to your SQLite database
    final File dbPath =
        File('/home/yking/Documents/Presentation/bible_test.sqlite');

    // Open the database
    final Database db = sqlite3.open(dbPath.path);
    'started'.appLog(color: red);

// 1,1,1,”In the beginning God created the heaven and the earth.”
    // Query to fetch verses where 'head = 0' (i.e., it's a verse, not a heading)
    final List<Map<String, dynamic>> verses = db.select('''
    SELECT
      chapter_id,           -- The ID of the book (e.g., 1 for Genesis, 40 for Matthew)
      chapter_num,          -- The chapter number
      position,             -- The verse number
      text                  -- The actual verse text
    FROM texts
    WHERE head = 0        -- Exclude headers (only include verses)
    ORDER BY chapter_id, chapter_num, position;
  ''');

    // Open a file for writing the CSV output
    final File csvFile =
        File('/home/yking/Documents/Presentation/bible_verses.csv');
    final IOSink csvSink = csvFile.openWrite();

    // Write verses to CSV file in the desired format: <book_id>,<chapter_number>,<verse_number>,<verse_text>
    for (final Map<String, dynamic> verse in verses) {
      final int bookId =
          int.parse((verse['chapter_id'] as dynamic).toString().trim()) - 2393;
      final dynamic chapterNumber = verse['chapter_num'];
      final dynamic verseNumber = verse['position'];
      final dynamic verseText = verse['text'];

      // <book_id>,<chapter_number>,<verse_number>,<verse_text>
      // 1,1,1,”In the beginning God created the heaven and the earth.”
      // Write to CSV in the format: <book_id>,<chapter_number>,<verse_number>,<verse_text>
      csvSink.writeln('$bookId,$chapterNumber,$verseNumber,"$verseText"');
    }

    // Close the file and the database connection
    csvSink.close();
    db.dispose();

    print('Verse CSV file has been generated.');

    returnStringFromTerminalOutput(); */

/*     // // Path to your SQLite database
    // final File dbPath =
    //     File('/home/yking/Documents/Presentation/bible.sqlite');

    // // Open the database
    // final Database db = sqlite3.open(dbPath.path);

    // // Query to get table information (column names and types)
    // final List<Map<String, dynamic>> columns =
    //     db.select('PRAGMA table_info(texts);');

    // // Print column names
    // print('Columns in the "texts" table:');
    // for (final Map<String, dynamic> column in columns) {
    //   final String columnName = column['name'];
    //   print(columnName);
    // }

    // // Close the database connection
    // db.dispose(); */
  } catch (_) {
    _.appLog();
  }
}
