import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:chero_key/Database_sqlite/database_helper.dart';

import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DBProvider.instance.initializeDatabase();
  final loaded = Future.wait([
    Firebase.initializeApp(),
  ]);

  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);

  runApp(
    FutureBuilder(
      future: loaded,
      builder: (_, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error.toString());
        }

        if (snapshot.hasData) {
          return CheroKey();
        }

        return Container(color: Colors.white);
      },
    ),
  );
}
