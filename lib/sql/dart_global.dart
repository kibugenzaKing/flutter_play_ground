// ignore_for_file: avoid_print

import 'dart:io';
import 'dart:math';

Future<void> runDartProcessInTerminal(
  String path, {
  bool zoom = false,
  String title = 'Output',
}) async {
  await Process.run(
    'gnome-terminal',
    <String>[
      '--maximize',
      if (zoom) '--zoom=3.0',
      '--hide-menubar',
      '--title=$title',
      '--',
      'dart',
      'run',
      path,
    ],
  );
}

String returnStringFromTerminalOutput() => stdin.readLineSync() ?? '';

Future<void> logErrorThroughDialog(String error) async => await Process.run(
      'zenity',
      <String>[
        '--error',
        '--title=Hey king, here are some errors 👇👇👇',
        '--text=$error',
      ],
    );

Future<void> userExtensionDisableOrEnable({required bool disable}) async =>
    await Process.run(
      'gsettings',
      <String>[
        'set',
        'org.gnome.shell',
        'disable-user-extensions',
        '$disable',
      ],
    );

String formatNumberAddingCommas(String numberString) {
  final bool hasDot = numberString.split('.').length > 1;
  String reversedNumberString;
  // Reverse the string to make inserting commas easier
  if (hasDot) {
    reversedNumberString =
        numberString.split('.').first.split('').reversed.join('');
  } else {
    reversedNumberString = numberString.split('').reversed.join('');
  }

  // Insert commas every three digits
  String formattedReversedNumberString = '';
  for (int i = 0; i < reversedNumberString.length; i++) {
    if (i > 0 && i % 3 == 0) {
      formattedReversedNumberString += ',';
    }
    formattedReversedNumberString += reversedNumberString[i];
  }
  // Reverse the string back to the original order and return it
  if (hasDot) {
    return '${formattedReversedNumberString.split('').reversed.join('')}.${numberString.split('.').last}';
  } else {
    return formattedReversedNumberString.split('').reversed.join('');
  }
}

Future<void> copyToClipBoard(String text) async {
  await Process.run(
    'sh',
    <String>[
      '-c',
      'echo "$text" | xclip -selection clipboard',
    ],
  );
}

String logsString(String logger) {
  final DateTime dateTime = DateTime.now();
  final String log = 'Time: ${addZeroToNumber(dateTime.hour)}:'
      '${addZeroToNumber(dateTime.minute)}'
      '   Date: '
      '${addZeroToNumber(dateTime.day)}'
      '/${addZeroToNumber(dateTime.month)}/'
      '${addZeroToNumber(dateTime.year)}\n'
      '$logger';
  return log;
}

String addZeroToNumber(int number) {
  if (number.toString().length == 1) {
    return '0$number';
  } else {
    return number.toString();
  }
}

Future<void> infoDialog({
  required String title,
  required String message,
}) async =>
    await Process.run(
      'zenity',
      <String>[
        '--info',
        '--width=300',
        '--height=100',
        '--title=$title',
        '--text=$message',
      ],
    );

Future<void> confirmDialog({
  required String title,
  required String message,
  required String yes,
  required String no,
  required void Function() yesClicked,
  required void Function() noClicked,
}) async =>
    await Process.run(
      'zenity',
      <String>[
        '--question',
        '--title=$title',
        '--text=$message',
        '--width=300',
        '--height=150',
      ],
      runInShell: true,
    ).then(
      (ProcessResult value) {
        value.exitCode.appLog();
        if (value.exitCode == 0) {
          return yesClicked();
        } else if (value.exitCode == 1) {
          return noClicked();
        }
      },
    );

Future<String> pickFileDialog() async {
  final ProcessResult process = await Process.run(
    'zenity',
    <String>[
      '--file-selection',
      '--title=🪿🪿🪿Hitamo File🐧🐧🐧',
    ],
  );
  return process.stdout.toString().trim();
}

Future<String> pickFolderDialog() async {
  final ProcessResult process = await Process.run(
    'zenity',
    <String>[
      '--file-selection',
      '--directory',
      '--title=🪿🪿🪿Hitamo Folder🐧🐧🐧',
    ],
  );
  return process.stdout.toString().trim();
}

Future<String> currentWindow() async => await Process.run(
      'xdotool',
      <String>['getwindowfocus', 'getwindowname'],
    ).then((ProcessResult value) => value.stdout.toString());

Future<String> entryTextDialog(String message) async {
  final ProcessResult processResult = await Process.run(
    'zenity',
    <String>[
      '--entry',
      '--title=🪿🪿🪿 Entry 🐧🐧🐧',
      '--text=$message',
    ],
  );
  return processResult.stdout.toString().trim();
}

Future<String> pasteClipBoard() async => await Process.run(
      'xclip',
      <String>[
        '-selection',
        'clipboard',
        '-o',
      ],
    ).then((ProcessResult value) => value.stdout.toString().trim());

/// overrides the current string with new data
Future<void> writeString({
  required String data,
  required String filePath,
}) async {
  try {
    final File file = File(filePath);
    await file.writeAsString(data);
  } catch (_) {
    logErrorThroughDialog(_.toString());
  }
}

Future<String> readStringFromFile(String filePath) async {
  final File file = File(filePath);
  return await file.readAsString();
}

Future<void> pressKey(String key) async => await Process.run(
      'ydotool',
      <String>[
        'key',
        key,
        '--delay=300',
      ],
    );

String dayOfYear() {
  final DateTime dateTime = DateTime.now();
  return (dateTime.difference(DateTime(dateTime.year, 1, 1)).inDays + 1)
      .toString();
}

void dividerSpacerInLogs() =>
    '--------------------------------'.appLog(color: noColor);

Future<void> typeSomething(String words, {int? delay}) async =>
    await Process.run(
      'ydotool',
      <String>[
        'type',
        words,
        '--delay=100',
        if (delay != null) ...<String>[
          '--key-delay',
          '$delay',
        ],
      ],
    );

String red = 'red';
String timeInGreen = 'time-green';
String timeInRed = 'time-red';
String purple = 'purple';
String noColor = 'no_color';

String greenColorFunc(String? txt) {
  String greenColorCode = '\x1B[32m';
  String resetColorCode = '\x1B[0m';
  return '$greenColorCode$txt$resetColorCode';
}

String purpleColorFunc(String? txt) {
  String purpleColorCode = '\x1B[35m';
  String resetColorCode = '\x1B[0m';
  return '$purpleColorCode$txt$resetColorCode';
}

String redColorFunc(String? txt) {
  String redColorCode = '\x1B[31m';
  String resetColorCode = '\x1B[0m';
  return '$redColorCode$txt$resetColorCode';
}

String returnAStringFromList(List<String> myListToTurnIntoAString) {
  final String s = myListToTurnIntoAString.toString();
  return s.substring(1, s.lastIndexOf(']'));
}

extension Log on dynamic {
  void appLog({String? color}) {
    if (color == red) {
      return print(redColorFunc(toString()));
    } else if (color == timeInGreen) {
      final DateTime now = DateTime.now();
      final String t =
          'time: ${now.hour}:${now.minute}:${now.second}:${now.millisecond}';
      return print(greenColorFunc('(Time: $t) ${toString()}'));
    } else if (color == timeInRed) {
      final DateTime now = DateTime.now();
      final String t =
          'time: ${now.hour}:${now.minute}:${now.second}:${now.millisecond}';
      return print(redColorFunc('(Time: $t) ${toString()}'));
    } else if (color == purple) {
      return print(purpleColorFunc(toString()));
    } else if (color == noColor) {
      return print(toString());
    } else {
      return print(greenColorFunc(toString()));
    }
  }
}

int generateRandomInteger({
  required int max,
  int? lower,
}) =>
    Random().nextInt(max) + (lower ?? 2);

String reverseString(String input) {
  String reversed = '';
  for (int i = input.length - 1; i >= 0; i--) {
    reversed += input[i]; /* reversed = reversed + input[i]; */
  }
  return reversed;
}

Future<void> loadingIndicator({
  required int length,
  required int i,
  String? doneExecuting,
}) async {
  final int percentage = ((100 / (length)) * (i + 1)).toInt();
  final List<String> replacer = <String>['/', '\\', '|', '*'];
  replacer.shuffle();
  final int done = percentage ~/ 5;
  // check if it's the next line after checked mark
  // 3 + 1 == 20 - 3
  final List<String> theRest = List<String>.generate(
    20 - done,
    (int i) => '[-]',
  );
  // animate first [-] which is being executed
  if (theRest.isNotEmpty) theRest[0] = '[${replacer.first}]';
  final String output = '${'✅ ' * done}${theRest.join()} $percentage%'; // 4 16

  stdout.write('\r$output'); // '\r' moves to the start of the line
  // await Future<void>.delayed(const Duration(milliseconds: 100));

  // Clear the line by printing spaces over it
  if (i + 1 == length) {
    stdout.write(
      '\r${'\n\n${greenColorFunc('${' ' * 7}${doneExecuting ?? 'Done...'}${' ' * 7}')}\n\n'}\r',
    );
  } else {
    stdout.write('\r${' ' * output.length}\r');
  }
}
