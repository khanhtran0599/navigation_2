import 'package:flutter/material.dart';

/// [MySubHomePage] là một trang con bên trong nhánh Home.
/// Thể hiện khả năng điều hướng lồng nhau (nested navigation) trong GoRouter.
class MySubHomePage extends StatefulWidget {
  const MySubHomePage({super.key});

  @override
  State<MySubHomePage> createState() => _MySubHomePageState();
}

class _MySubHomePageState extends State<MySubHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sub Home")),
    );
  }
}
