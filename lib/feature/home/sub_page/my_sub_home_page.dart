import 'package:flutter/material.dart';

class MySubHomePage extends StatefulWidget {
  const MySubHomePage({super.key});

  @override
  State<MySubHomePage> createState() => _MySubHomePageState();
}

class _MySubHomePageState extends State<MySubHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Sub Home")));
  }
}
