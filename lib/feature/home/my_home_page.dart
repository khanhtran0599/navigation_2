import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Page")),
      body: Center(
        child: TextButton(
          onPressed: () {
            context.go("/home/subHome");
          },
          child: Text("Go sub home"),
        ),
      ),
    );
  }
}
