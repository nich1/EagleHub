import 'package:flutter/material.dart';
import 'package:practice/food.dart';

class LookPage extends StatefulWidget {
  @override
  _LookPageState createState() => _LookPageState();
}

class _LookPageState extends State<LookPage> {
  TextEditingController controller = TextEditingController();
  List<FoodItems> food = allFoodItems;

  @override
  void dispose() {
    controller
        .dispose(); // Dispose of the controller when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Menu'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Enter Dish name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.green),
                ),
              ),
              onChanged: searchDish,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: food.length,
              itemBuilder: (context, index) {
                final FoodItems item = food[index];
                return ListTile(
                  leading: Icon(Icons.restaurant_menu),
                  title: Text(item.foodName),
                  subtitle: Text(item.cafeteria),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void searchDish(String query) {
    final List<FoodItems> suggestions = allFoodItems.where((foodItem) {
      final foodNameLower = foodItem.foodName.toLowerCase();
      final inputLower = query.toLowerCase();
      return foodNameLower.contains(inputLower);
    }).toList();

    setState(() {
      food = suggestions;
    });
  }
}
