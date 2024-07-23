import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'maps_screen.dart';
import "look.dart";

import 'map_page.dart';
import 'notifications_screen.dart'; // Renamed MoreScreen to NotificationsScreen
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final DateTime now = DateTime.now();
  final DateFormat timeFormat = DateFormat('h a');

  bool isOpen(String openingTime, String closingTime) {
    try {
      final openTime = timeFormat.parse(openingTime);
      final closeTime = timeFormat.parse(closingTime);
      final nowTime = timeFormat.parse(timeFormat.format(now));

      return nowTime.isAfter(openTime) && nowTime.isBefore(closeTime);
    } catch (e) {
      print('Error parsing time: $e');
      return false;
    }
  }

  void _showNotifications() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LookPage(),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eagle Hub'),
        actions: [],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          Container(
            color: Colors.lightGreen[50],
            child: ListView(
              children: [
                Container(
                  color: Colors.green[900],
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'DISCOVERY PARK',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                _buildDiningTab(
                    'DISCOVERY PERKS MARKET & GRILL',
                    'https://dining.unt.edu/portfolio-item/discovery-perks/',
                    'Click to view menu'),
                Container(
                  color: Colors.green[900],
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'FRISCO LANDING',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                _buildDiningTab(
                    'THE MARKET AT FRISCO LANDING',
                    'https://dining.unt.edu/portfolio-item/the-market-at-frisco-landing/',
                    'Click to view menu'),
                Container(
                  color: Colors.green[900],
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'UNT MAIN CAMPUS',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDiningTab(
                        'CHAMPS',
                        'https://diningmenus.unt.edu/?locationID=15',
                        'Click to view menu'),
                    _buildDiningTab(
                        'EAGLE LANDING',
                        'https://diningmenus.unt.edu/?locationID=31',
                        'Click to view menu'),
                    _buildDiningTab(
                        'KITCHEN WEST',
                        'https://diningmenus.unt.edu/?locationID=25',
                        'Click to view menu'),
                    _buildDiningTab(
                        'MEAN GREENS CAFÉ',
                        'https://diningmenus.unt.edu/?locationID=10',
                        'Click to view menu'),
                    _buildDiningTab(
                        'BRUCETERIA',
                        'https://diningmenus.unt.edu/?locationID=20',
                        'Click to view menu'),
                    _buildDiningTab(
                        'EINSTEIN BROS. BAGELS',
                        'https://dining.unt.edu/portfolio-item/einstein-bros-bagels/',
                        'Click to view menu'),
                    _buildDiningTab(
                        'STARBUCKS COFFEE STAND',
                        'https://dining.unt.edu/portfolio-item/starbucks-coffee-stand/',
                        'Click to view menu'),
                    _buildDiningTab(
                        'THE MARKET BY CLARK BAKERY',
                        'https://dining.unt.edu/portfolio-item/the-market/',
                        'Click to view menu'),
                    _buildDiningTab(
                        'WHICH WICH',
                        'https://dining.unt.edu/portfolio-item/which-wich/',
                        'Click to view menu'),
                    _buildDiningTab(
                        'AVESTA',
                        'https://diningmenus.unt.edu/?locationID=30',
                        'Click to view menu'),
                    _buildDiningTab(
                        'BURGER KING',
                        'https://dining.unt.edu/portfolio-item/burger-king/',
                        'Click to view menu'),
                    _buildDiningTab(
                        'CAMPUS CHAT FOOD COURT',
                        'https://dining.unt.edu/portfolio-item/the-campus-chat-food-court/',
                        'Click to view menu'),
                    _buildDiningTab(
                        'CHICK-FIL-A',
                        'https://dining.unt.edu/portfolio-item/chick-fil-a/',
                        'Click to view menu'),
                    _buildDiningTab(
                        'FOOD-TO-GO PANTRY',
                        'https://dining.unt.edu/portfolio-item/food-to-go-pantry/',
                        'Click to view menu'),
                    _buildDiningTab(
                        'FUZZY\'S TACO SHOP',
                        'https://dining.unt.edu/portfolio-item/fuzzys-taco-shop/',
                        'Click to view menu'),
                    _buildDiningTab(
                        'JAMBA',
                        'https://dining.unt.edu/portfolio-item/jamba/',
                        'Click to view menu'),
                    _buildDiningTab(
                        'KRISPY KRUNCHY CHICKEN',
                        'https://dining.unt.edu/portfolio-item/krispy-krunchy-chicken/',
                        'Click to view menu'),
                    _buildDiningTab(
                        'STARBUCKS',
                        'https://dining.unt.edu/portfolio-item/starbucks/',
                        'Click to view menu'),
                    _buildDiningTab(
                        'VERDE EVERYDAY EXPRESS',
                        'https://dining.unt.edu/portfolio-item/verde-everyday-express/',
                        'Click to view menu'),
                  ],
                ),
              ],
            ),
          ),
          MapPage(),
          LookPage(), // Changed to NotificationsScreen
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.green[900],
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: 'Dining Locations',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
        ],
      ),
    );
  }

  Widget _buildDiningTab(String title, String url, String subtitle) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(Icons.restaurant),
        title: Text(title),
        subtitle: Text(subtitle),
        onTap: () {
          _launchUrl(url);
        },
      ),
    );
  }
}

class NotificationsScreen extends StatelessWidget {
  // Renamed from MoreScreen to NotificationsScreen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: ElevatedButton(
        onPressed: () {
          // Navigate to dining locations
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LookPage(),
            ),
          );
        },
        child: const Text('Dining Locations'),
      ),
    );
  }
}

class MapsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Map'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              // Navigate to dining locations
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MapPage(),
                ),
              );
            },
            child: const Text('Dining Locations'),
          ),
        ));
  }
}
