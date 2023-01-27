import 'dart:io';

import 'package:flutter/material.dart';
import 'package:polosystest/view/index.dart';
import 'package:polosystest/viewstate/db_viewstate.dart';
import 'package:polosystest/viewstate/mainstate.dart';
import 'package:provider/provider.dart';

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => MainState()),
      ChangeNotifierProvider(create: (context) => DBViewState()),
    ],
    child: MaterialApp(home: IndexScreen()),
  ));
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
