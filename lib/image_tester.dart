import 'package:flutter/material.dart';

class ImageTester extends StatefulWidget {
  const ImageTester({super.key});

  @override
  State<ImageTester> createState() => _ImageTesterState();
}

class _ImageTesterState extends State<ImageTester> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Image.asset('images/KitchenWest.png'),
    ));
  }
}
