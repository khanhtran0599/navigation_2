import 'package:flutter/material.dart';

/// [MyPlaceDogWalkDetailPage] là một trang con bên trong nhánh Home.
/// Thể hiện khả năng điều hướng lồng nhau (nested navigation) trong GoRouter.
class MyPlaceDogWalkDetailPage extends StatefulWidget {
  final String id;
  const MyPlaceDogWalkDetailPage({super.key, required this.id});

  @override
  State<MyPlaceDogWalkDetailPage> createState() =>
      _MyPlaceDogWalkDetailPageState();
}

class _MyPlaceDogWalkDetailPageState extends State<MyPlaceDogWalkDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(widget.id)));
  }
}
