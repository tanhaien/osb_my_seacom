import 'package:all_bluetooth/all_bluetooth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_chat/loading_screen.dart';
import 'home.dart';
import 'messages_screen.dart';

void main() {
  runApp(const MyApp());
}

final allBluetooth = AllBluetooth();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      theme: ThemeData(
        useMaterial3: true,
      ),
    debugShowCheckedModeBanner: false,
    );
  }
}
