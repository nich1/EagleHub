import 'package:flutter/material.dart';
import "look.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Eagle Hub',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Eagle Hub Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to LookPage (or any other page)
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LookPage()),
                      );
                    },
                    child: const Text('Search Meals'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to dining locations
                    },
                    child: const Text('Dining Locations'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to notifications
                    },
                    child: const Text('Notifications'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Weekly Meal Plan',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 7, // Number of days in a week
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text('Day ${index + 1}'),
                      subtitle: Text('Meals for the day...'),
                      onTap: () {
                        // Navigate to detailed view of meals for the day
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle maps button press
        },
        tooltip: 'Notifications',
        child: const Icon(Icons.map),
      ),
    );
  }
}
