import 'package:flutter/material.dart';
import 'pages/services /models.dart'; // Ensure you're importing the correct file where DiningLocation is defined

class DiningDetailsScreen extends StatelessWidget {
  final DiningLocation location;

  DiningDetailsScreen({required this.location});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(location.name),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Address: ${location.address}'),
          Text('Hours: ${location.hours}'),
          Text('Status: ${location.isOpen ? "Open" : "Closed"}'),
          SizedBox(height: 20),
          Text('Menu:'),
          ...location.menu
              .map((item) => Text(item))
              .toList(), // Access 'menu' here
        ],
      ),
    );
  }
}
