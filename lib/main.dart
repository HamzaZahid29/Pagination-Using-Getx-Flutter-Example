import 'dart:io';

import 'package:flutter/material.dart';

import 'home.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) =>true;
  }
}
void main() {
  HttpOverrides.global = MyHttpOverrides();

  runApp(
      MaterialApp(
        initialRoute: 'home',
        routes: {
          'home' : (_)=>Home()
        },
      )
  );
}