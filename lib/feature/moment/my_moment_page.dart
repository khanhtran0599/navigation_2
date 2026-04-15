import 'package:flutter/material.dart';

class MyMomentPage extends StatefulWidget {
  const MyMomentPage({super.key});

  @override
  State<MyMomentPage> createState() => _MyMomentPageState();
}

class _MyMomentPageState extends State<MyMomentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Moments Page")));
  }
}