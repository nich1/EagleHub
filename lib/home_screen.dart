import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'maps_screen.dart';
import 'more_screen.dart';
import 'dining_details_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final DateTime now = DateTime.now();
  final DateFormat timeFormat = DateFormat('h a'); // Updated to match time format

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

  Widget _buildStatus(String name, String openingHours) {
    final hours = openingHours.split('\n');
    bool open = false;
    bool closedForSummer = openingHours.contains('Closed for the summer.');

    for (String hour in hours) {
      if (hour.contains('—')) {
        final times = hour.split('—');
        final start = times[0].trim();
        final end = times[1].trim();

        if (isOpen(start, end)) {
          open = true;
          break;
        }
      }
    }

    return Row(
      children: [
        Icon(
          Icons.access_time,
          size: 12,
          color: open ? Colors.green : Colors.red,
        ),
        SizedBox(width: 5),
        Text(
          closedForSummer ? 'Closed for the summer.' : (open ? 'Open' : 'Closed'),
          style: TextStyle(
            fontSize: 12,
            color: closedForSummer ? Colors.red : (open ? Colors.green : Colors.red),
          ),
        ),
      ],
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UNT Dining Services'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Filter'),
                  content: Text('Filter implementation will be here.'),
                ),
              );
            },
          ),
        ],
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
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.restaurant),
                  title: Text('DISCOVERY PERKS MARKET & GRILL'),
                  subtitle: _buildStatus('DISCOVERY PERKS MARKET & GRILL', 'Closed for the summer.'),
                ),
                Container(
                  color: Colors.green[900],
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'FRISCO LANDING',
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.restaurant),
                  title: Text('THE MARKET AT FRISCO LANDING'),
                  subtitle: _buildStatus('THE MARKET AT FRISCO LANDING', 'Closed for the summer.'),
                ),
                Container(
                  color: Colors.green[900],
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'UNT MAIN CAMPUS',
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: Icon(Icons.restaurant),
                      title: Text('CHAMPS'),
                      subtitle: _buildStatus('CHAMPS', 'Closed for the summer.'),
                    ),
                    ListTile(
                      leading: Icon(Icons.restaurant),
                      title: Text('EAGLE LANDING'),
                      subtitle: _buildStatus('EAGLE LANDING', 'Closed for the summer.'),
                    ),
                    ListTile(
                      leading: Icon(Icons.restaurant),
                      title: Text('KITCHEN WEST'),
                      subtitle: _buildStatus('KITCHEN WEST', 'Closed for the summer.'),
                    ),
                    ListTile(
                      leading: Icon(Icons.restaurant),
                      title: Text('MEAN GREENS CAFÉ'),
                      subtitle: _buildStatus('MEAN GREENS CAFÉ', 'Closed for the summer.'),
                    ),
                    ListTile(
                      leading: Icon(Icons.restaurant),
                      title: Text('BRUCETERIA'),
                      subtitle: _buildStatus('BRUCETERIA', 'Monday - Sunday\n7 a.m. — 10 a.m.\n11 a.m. — 2 p.m.\n4:30 p.m. — 7 p.m.'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BruceteriaDetailsScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          MapsScreen(),
          MoreScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
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
            icon: Icon(Icons.more_vert),
            label: 'More',
          ),
        ],
      ),
    );
  }
}

class BruceteriaDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BRUCETERIA'),
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            TabBar(
              tabs: [
                Tab(text: 'BREAKFAST'),
                Tab(text: 'LUNCH'),
                Tab(text: 'DINNER'),
              ],
              indicatorColor: Colors.green[900],
              labelColor: Colors.green[900],
              unselectedLabelColor: Colors.black,
            ),
            Expanded(
              child: TabBarView(
                children: [
                  BreakfastMenu(),
                  Center(child: Text('LUNCH Menu')),
                  Center(child: Text('DINNER Menu')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BreakfastMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightGreen[50],
      child: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Text('100% Plant-based Tofu Hash', style: TextStyle(fontSize: 18)),
          SizedBox(height: 10),
          Text('Assorted Breakfast Pastries', style: TextStyle(fontSize: 18)),
          SizedBox(height: 10),
          Text('Brown Sugar Oatmeal', style: TextStyle(fontSize: 18)),
          SizedBox(height: 10),
          Text('Clark Bakery Biscuits', style: TextStyle(fontSize: 18)),
          SizedBox(height: 10),
          Text('Crustless Quiche with Bacon', style: TextStyle(fontSize: 18)),
          SizedBox(height: 10),
          Text('French Toast', style: TextStyle(fontSize: 18)),
          SizedBox(height: 10),
          Text('Fried Potatoes', style: TextStyle(fontSize: 18)),
          SizedBox(height: 10),
          Text('Ham Scramble', style: TextStyle(fontSize: 18)),
          SizedBox(height: 10),
          Text('Hard Boiled Eggs', style: TextStyle(fontSize: 18)),
          SizedBox(height: 10),
          Text('Maple Syrup', style: TextStyle(fontSize: 18)),
          SizedBox(height: 10),
          Text('Roasted Jalapeno Sausage', style: TextStyle(fontSize: 18)),
          SizedBox(height: 10),
          Text('Scrambled Eggs', style: TextStyle(fontSize: 18)),
          SizedBox(height: 10),
          Text('Sizzling Sausage Links', style: TextStyle(fontSize: 18)),
        ],
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
        child: Text(
          'Interactive map will be here.',
          style: TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
