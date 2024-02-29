import 'package:flutter/material.dart';
import 'map_screen.dart';
import 'messages_screen.dart'; // Import the HomeScreen

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Image.asset('lib/image/logoseacom_resized.jpg')),
      ),
      body: Center(
        child: GridView.count(
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          padding: EdgeInsets.all(20),
          crossAxisCount: 2,
          children: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.orangeAccent, // background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // border shape
                ),
                padding: EdgeInsets.all(50), // button size
              ),
              onPressed: () {
                // Add your functionality for Button 1 here
              },
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.lock_open, color: Colors.white, size: 30.0),
                  Text('Login',
                      style: TextStyle(color: Colors.white, fontSize: 16.0)),
                ],
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.orangeAccent, // background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // border shape
                ),
                padding: EdgeInsets.all(50), // button size
              ),
              onPressed: () {
                // Add your functionality for Button 1 here
              },
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.device_unknown, color: Colors.white, size: 30.0),
                  Text('Devices',
                      style: TextStyle(color: Colors.white, fontSize: 16.0)),
                ],
              ),
              // Repeat for other buttons...
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.orangeAccent, // background colorqqqq
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // border shape
                ),
                padding: EdgeInsets.all(50), // button size
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.messenger, color: Colors.white, size: 20.0),
                  Text('Messages',
                      style: TextStyle(color: Colors.white, fontSize: 12.0)),
                ],
              ),
              // Repeat for other buttons...
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.orangeAccent, // background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // border shape
                ),
                padding: EdgeInsets.all(50), // button size
              ),
              onPressed: () {},
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.settings, color: Colors.white, size: 30.0),
                  Text('Settings',
                      style: TextStyle(color: Colors.white, fontSize: 16.0)),
                ],
              ),
              // Repeat for other buttons...
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.orangeAccent, // background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // border shape
                ),
                padding: EdgeInsets.all(50), // button size
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MapScreen(title: 'Vietnam Offline Map',)),
                );
              },
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.map, color: Colors.white, size: 30.0),
                  Text('Map',
                      style: TextStyle(color: Colors.white, fontSize: 16.0)),
                ],
              ),
              // Repeat for other buttons...
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.redAccent, // background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // border shape
                ),
                padding: EdgeInsets.all(50), // button size
              ),
              onPressed: () {},
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.sos_outlined, color: Colors.white, size: 60.0),
                ],
              ),
              // Repeat for other buttons...
            ),
          ],
        ),
      ),
    );
  }
}
