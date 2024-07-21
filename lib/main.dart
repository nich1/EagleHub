import 'package:flutter/material.dart';
import 'home_screen.dart'; // Update to reflect the new location


void main() {
  runApp(EagleHubApp());
}

class EagleHubApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UNT Dining Services',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}


