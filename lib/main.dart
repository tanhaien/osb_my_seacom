import 'package:all_bluetooth/all_bluetooth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_chat/loading_screen.dart';
import 'home.dart';
import 'map_data_provider.dart';
import 'messages_screen.dart';
import 'package:provider/provider.dart';


void main() async {
  final mapDataProvider = MapDataProvider();
  WidgetsFlutterBinding.ensureInitialized();
  print("\n\n----------------------- inited mapDataProvider -----------------------\n\n");
  await mapDataProvider.loadMapData(); // Load map data before building the app

  runApp(ChangeNotifierProvider<MapDataProvider>(
      create: (_) => mapDataProvider,
      child: MyApp(),
    ),
  );
}


final allBluetooth = AllBluetooth();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoadingScreen(),
      theme: ThemeData(
        useMaterial3: true,
      ),
    debugShowCheckedModeBanner: false,
    );
  }
}
