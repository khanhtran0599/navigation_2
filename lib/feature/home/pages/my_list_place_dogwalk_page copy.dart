import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation_2/feature/home/widgets/item_place_widget.dart';

/// [MyListPlaceDogWalkPage] là một trang con bên trong nhánh Home.
/// Thể hiện khả năng điều hướng lồng nhau (nested navigation) trong GoRouter.
class MyListPlaceDogWalkPage extends StatefulWidget {
  final String? title;
  final List<PlaceDogWalk> listPlace;
  const MyListPlaceDogWalkPage({
    super.key,
    this.title = "NoTitle",
    required this.listPlace,
  });

  @override
  State<MyListPlaceDogWalkPage> createState() => _MyListPlaceDogWalkPageState();
}

class _MyListPlaceDogWalkPageState extends State<MyListPlaceDogWalkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title ?? "NoTitle")),
      body: ListView.builder(
        itemCount: widget.listPlace.length,
        itemBuilder: (context, index) {
          var placeDogWalk = widget.listPlace[index];
          return PlaceItemWidget(
            placeDogWalk: placeDogWalk,
            onTap: () {
              context.push("/home/myDetail/${placeDogWalk.id}");
            },
          );
        },
      ),
    );
  }
}
