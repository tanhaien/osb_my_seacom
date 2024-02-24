import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.wait([
      Permission.bluetooth.request(),
      Permission.bluetoothConnect.request(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: allBluetooth.streamBluetoothState,
      builder: (context, snapshot) {
        final bluetoothOn = snapshot.data ?? false;
        print(bluetoothOn);

        return Scaffold(
          appBar: AppBar(title: Center(child: Image.asset('lib/image/logoseacom_resized.jpg')
          ),),
          floatingActionButton: FloatingActionButton(
            onPressed: switch(bluetoothOn) {
              false => null,
              true => null,
            },
            child: const Icon(Icons.wifi_tethering),
            backgroundColor: bluetoothOn ? Colors.orangeAccent:Colors.grey,
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    switch(bluetoothOn) {
                      false => Text("OFF", style: TextStyle(color: Colors.red)),
                      true => Text("ON", style: TextStyle(color: Colors.green)),
                    },
                    ElevatedButton(onPressed: switch(bluetoothOn) {
                      false => null,
                      true => () {},
                    }, child: const Text("Paired Devices", style: TextStyle(color: Colors.orange)),)
                  ],
                ),
                Center(child: switch(bluetoothOn) {
                  false => Text("Turn BLUETOOTH on"),
                  true => null,
                },)
              ],
            ),
          ),
        );
      }
    );
  }

}