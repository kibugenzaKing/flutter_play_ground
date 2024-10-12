import 'package:cloud_firestore/cloud_firestore.dart';
// I am using firestore to store the app version, i update on every release

import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart' show SpinKitCircle;
// i use SpinKitCircle as animation, you can simply use it or ignore it. no difference at all

import 'dart:html' as html;

/// bool to check if the app loaded is new and not cache,
/// if true. return Child you provided, maybe (HomeWidget()) or whatever you want next
bool doneChecking = false;

/// reloading window is a bool to
/// help show a user the window is going to reload in text
/// as shown below, it helps a user understand what's going on.
/// Otherwise it would look weird to reload a tab, hhhhh
bool reloadingWindow = false;

/// app version to compare with firestore version, or whatever database you are using
/// please make sure this matches the app version in your database, otherwise the app would reload
/// infinitely.
const String appVersion = '0.02';

class CheckVersion extends StatefulWidget {
  const CheckVersion(this.child, {super.key});

  // child to show after successfully checking version. maybe your initial class widget.
  final Widget child;

  @override
  State<CheckVersion> createState() => CheckVersionState();
}

class CheckVersionState extends State<CheckVersion> {
  /// method to check for version
  void checkForVersion() async {
    /// making a request to firestore, use whatever database you want.
    /// as long as you have stored there some app version matching the one on top
    /// and the web app has access to that database
    final Map<String, dynamic>? version = await FirebaseFirestore.instance
        .collection('!my_data')
        .doc('!version')
        .get()
        .then((__) => __.data())
        .catchError((_) => null);
    if (version != null) {
      /// checking for the field version
      if (version['version'] == appVersion) {
        setState(() {
          doneChecking = true;
        });
      } else {
        setState(() {
          reloadingWindow = true;
        });
        await Future<void>.delayed(const Duration(seconds: 5));

        /// the version didn't match so reload the window for the user
        html.window.location.reload();
      }
    }
  }

  @override
  void initState() {
    checkForVersion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (doneChecking) return widget.child;

    /// first check if the app is running on web
    if (kIsWeb) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                reloadingWindow
                    ? 'This window is going to reload..'
                    : 'loading content...',
                style: TextStyle(
                  fontSize: 17,
                  color: reloadingWindow ? Colors.red : null,
                ),
              ),
              const SizedBox(height: 30),
              if (!reloadingWindow)
                const SpinKitCircle(
                  color: Colors.grey,
                  size: 30,
                ),
            ],
          ),
        ),
      );
    } else {
      return widget.child;
    }
  }
}
